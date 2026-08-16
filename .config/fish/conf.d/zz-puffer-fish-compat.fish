# puffer-fish uses `commandline --search-field`, introduced in Fish 4.
# On older, offline server installations, restore the default bindings instead
# of letting its key handlers emit an error whenever these keys are pressed.
if status is-interactive
    set -l fish_major (string split . -- $version)[1]
    if test "$fish_major" -lt 4
        for mode in default insert
            bind --erase --mode $mode . ! '$' '*'
        end
    end
end
