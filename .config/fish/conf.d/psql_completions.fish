# psql completions — additions on top of fish's built-in psql.fish.
#
# Lives in conf.d, not completions/: a completions/psql.fish would shadow the
# psql completions embedded in the fish binary instead of adding to them.
#
# Fish already ships every psql switch; what it does not do is fill in the
# values. This adds:
#   -h/--host   hostnames from /etc/hosts that look like database servers
#   -U/--user   usernames from ~/.pgpass
#   -d/dbname   live database list, queried from whatever host/port/user is
#               already on the command line (cached, see __psql_databases)

function __psql_hosts --description 'DB-ish hostnames from /etc/hosts'
    awk '!/^[[:space:]]*#/ && NF > 1 { for (i = 2; i <= NF; i++) print $i }' /etc/hosts \
        | string match -ri '.*(db|postgre|pg-).*' \
        | sort -u
end

function __psql_users --description 'Usernames from ~/.pgpass'
    test -r ~/.pgpass; or return
    awk -F: '!/^[[:space:]]*#/ && NF >= 4 { print $4 }' ~/.pgpass \
        | string match -rv '^\*?$' \
        | sort -u
end

# Pull -h/-p/-U out of the command line being typed, so database completion
# targets the server the user is actually connecting to.
function __psql_conn_flag --argument-names short long
    set -l tokens (commandline -opc)
    set -l n (count $tokens)
    for i in (seq $n)
        switch $tokens[$i]
            case "--$long=*"
                echo (string replace -- "--$long=" '' $tokens[$i])
                return 0
            case "-$short" "--$long"
                if test $i -lt $n
                    echo $tokens[(math $i + 1)]
                    return 0
                end
            case "-$short*"
                # psql allows the value glued to the switch: -hdb.example
                echo (string replace -- "-$short" '' $tokens[$i])
                return 0
        end
    end
    return 1
end

function __psql_databases --description 'Databases on the server on the command line'
    set -l host (__psql_conn_flag h host)
    set -l port (__psql_conn_flag p port)
    set -l user (__psql_conn_flag U username)

    set -l cache_dir $HOME/.cache/fish-psql-completions
    set -l key (string join _ -- $host $port $user | string replace -a / _)
    set -l cache $cache_dir/$key

    # Serve from cache while it is under 10 minutes old; a live connection on
    # every keystroke would be far too slow.
    if test -r $cache
        set -l age (math (date +%s) - (stat -f %m $cache))
        if test $age -lt 600
            cat $cache
            return 0
        end
    end

    set -l args
    test -n "$host"; and set -a args -h $host
    test -n "$port"; and set -a args -p $port
    test -n "$user"; and set -a args -U $user

    # -w: never prompt for a password. Without it a host missing from ~/.pgpass
    # would hang the completion waiting on stdin.
    set -l dbs (PGCONNECT_TIMEOUT=2 command psql $args -w -Atq -d postgres \
        -c 'select datname from pg_database where not datistemplate order by 1' 2>/dev/null)
    or return 1

    mkdir -p $cache_dir
    printf '%s\n' $dbs | tee $cache
end

complete -c psql -s h -l host -x -a '(__psql_hosts)' -d Host
complete -c psql -s U -l username -x -a '(__psql_users)' -d User
complete -c psql -s d -l dbname -x -a '(__psql_databases)' -d Database
# The bare positional argument is the database name too: psql -h host dbname
complete -c psql -n 'not __fish_is_switch' -x -a '(__psql_databases)' -d Database
