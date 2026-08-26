function sync-hosts --description 'Safely sync the managed DNS hosts block to /etc/hosts'
    set -l dns_repository /Users/ali/PycharmProjects/DEV/dns
    set -l source_file $dns_repository/dnsdist/hosts
    set -l source_is_default 1
    set -l hosts_file /etc/hosts
    set -l begin_marker '# -----BEGIN /etc/hosts----- #'
    set -l end_marker '# -----END /etc/hosts----- #'
    set -l action sync
    set -l dry_run 0

    # Allow a one-off source without editing this function.
    if set -q SYNC_HOSTS_SOURCE
        set source_file $SYNC_HOSTS_SOURCE
        set source_is_default 0
    end

    for argument in $argv
        switch $argument
            case sync remove status
                if test $action != sync
                    echo 'Usage: sync-hosts [sync|remove|status] [--dry-run]' >&2
                    return 2
                end
                set action $argument
            case --dry-run -n
                set dry_run 1
            case '*'
                echo 'Usage: sync-hosts [sync|remove|status] [--dry-run]' >&2
                return 2
        end
    end

    if not test -r $hosts_file
        echo "sync-hosts: Cannot read $hosts_file" >&2
        return 1
    end

    # Keep the default DNS source current, but never merge or overwrite local work.
    if test $action = sync; and test $source_is_default -eq 1
        if not test -d $dns_repository
            echo "sync-hosts: Cannot find DNS repository at $dns_repository" >&2
            return 1
        end

        if not git -C $dns_repository pull --ff-only
            echo 'sync-hosts: Failed to update the DNS repository' >&2
            return 1
        end
    end

    set -l cleaned_file (mktemp -t sync-hosts-cleaned.XXXXXX)
    or return 1
    set -l result_file (mktemp -t sync-hosts-result.XXXXXX)
    or begin
        rm -f $cleaned_file
        return 1
    end

    # Reject malformed managed blocks instead of silently deleting unrelated lines.
    awk -v begin="$begin_marker" -v end="$end_marker" '
        $0 == begin {
            if (managed || ++found_begin > 1) exit 1
            managed = 1
            next
        }
        $0 == end {
            if (!managed || ++found_end > 1) exit 1
            managed = 0
            next
        }
        !managed { print }
        END {
            if (managed || found_begin != found_end) exit 1
        }
    ' $hosts_file >$cleaned_file

    if test $status -ne 0
        echo 'sync-hosts: /etc/hosts has a malformed or duplicate managed block; refusing to change it' >&2
        rm -f $cleaned_file $result_file
        return 1
    end

    if test $action = status
        if cmp -s $hosts_file $cleaned_file
            echo 'No managed block is installed in /etc/hosts'
        else
            echo 'A managed block is installed in /etc/hosts'
        end
        rm -f $cleaned_file $result_file
        return 0
    end

    if test $action = remove
        cp $cleaned_file $result_file
    else
        if not test -r $source_file
            echo "sync-hosts: Cannot read $source_file" >&2
            rm -f $cleaned_file $result_file
            return 1
        end

        set -l managed_block (mktemp -t sync-hosts-block.XXXXXX)
        or begin
            rm -f $cleaned_file $result_file
            return 1
        end

        awk -v begin="$begin_marker" -v end="$end_marker" '
            $0 == begin {
                if (managed || ++found_begin > 1) exit 1
                managed = 1
            }
            managed { print }
            $0 == end {
                if (++found_end > 1) exit 1
                managed = 0
            }
            END {
                if (managed || found_begin != 1 || found_end != 1) exit 1
            }
        ' $source_file >$managed_block

        if test $status -ne 0
            echo 'sync-hosts: Source must contain exactly one complete managed block' >&2
            rm -f $cleaned_file $result_file $managed_block
            return 1
        end

        cp $cleaned_file $result_file
        cat $managed_block >>$result_file
        rm -f $managed_block
    end

    if cmp -s $hosts_file $result_file
        echo '/etc/hosts is already up to date'
        rm -f $cleaned_file $result_file
        return 0
    end

    if test $dry_run -eq 1
        diff -u $hosts_file $result_file
        set -l diff_status $status
        rm -f $cleaned_file $result_file
        return (test $diff_status -le 1; and echo 0; or echo $diff_status)
    end

    sudo install -m 0644 $result_file $hosts_file
    set -l install_status $status
    rm -f $cleaned_file $result_file

    if test $install_status -ne 0
        echo 'sync-hosts: Failed to update /etc/hosts' >&2
        return $install_status
    end

    if test $action = remove
        echo 'Removed the managed block from /etc/hosts'
    else
        echo 'Synced the managed block to /etc/hosts'
    end
end
