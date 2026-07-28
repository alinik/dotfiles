function sync-hosts --description 'Sync the Bitmax managed block to /etc/hosts'
    set -l primary_hostname Bagheri-MacBook-Pro
    set -l project_source /Users/ali/PycharmProjects/DEV/dns/dnsdist
    set -l source_file $HOME/.local/dotfiles/hosts
    set -l hosts_file /etc/hosts
    set -l begin_marker '# -----BEGIN /etc/hosts----- #'
    set -l end_marker '# -----END /etc/hosts----- #'
    set -l action sync

    if test (count $argv) -gt 1; or test (count $argv) -eq 1 -a "$argv[1]" != remove
        echo 'Usage: sync-hosts [remove]' >&2
        return 2
    end

    if test (count $argv) -eq 1
        set action $argv[1]
    end

    if test (command hostname) = $primary_hostname
        if not test -r $project_source
            echo "sync-hosts: Cannot read $project_source" >&2
            return 1
        end

        if not cp $project_source $source_file
            echo "sync-hosts: Failed to refresh $source_file" >&2
            return 1
        end
    end

    if not test -r $hosts_file
        echo "sync-hosts: Cannot read $hosts_file" >&2
        return 1
    end

    set -l cleaned_file (mktemp -t sync-hosts-cleaned.XXXXXX)
    or return 1
    set -l result_file (mktemp -t sync-hosts-result.XXXXXX)
    or begin
        rm -f $cleaned_file
        return 1
    end

    # Remove every previously managed block, including its marker lines.
    awk -v begin="$begin_marker" -v end="$end_marker" '
        $0 == begin { managed = 1; next }
        managed && $0 == end { managed = 0; next }
        !managed { print }
    ' $hosts_file >$cleaned_file

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
            $0 == begin { found_begin++; managed = 1 }
            managed { print }
            managed && $0 == end { found_end++; managed = 0 }
            END {
                if (found_begin != 1 || found_end != 1 || managed)
                    exit 1
            }
        ' $source_file >$managed_block

        if test $status -ne 0
            echo 'sync-hosts: The source must contain exactly one complete managed block' >&2
            rm -f $cleaned_file $result_file $managed_block
            return 1
        end

        cp $cleaned_file $result_file
        cat $managed_block >>$result_file
        rm -f $managed_block
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
