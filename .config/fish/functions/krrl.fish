function krrl
    set -l args $argv
    set -l namespace
    set -l context
    set -l label

    set -l i 1
    while test $i -le (count $args)
        set -l a $args[$i]
        switch $a
            case -n --namespace
                set -l next (math $i + 1)
                if test $next -le (count $args)
                    set namespace $args[$next]
                    set i (math $i + 1)
                end
            case '--namespace=*'
                set namespace (string replace -- '--namespace=' '' -- $a)
            case '-n*'
                if test (string length -- $a) -gt 2
                    set namespace (string sub -s 3 -- $a)
                end
            case -c --context
                set -l next (math $i + 1)
                if test $next -le (count $args)
                    set context $args[$next]
                    set i (math $i + 1)
                end
            case '--context=*'
                set context (string replace -- '--context=' '' -- $a)
            case '-c*'
                if test (string length -- $a) -gt 2
                    set context (string sub -s 3 -- $a)
                end
            case '*'
                if test -z "$label"
                    set label $a
                end
        end
        set i (math $i + 1)
    end

    set -l kubectl_args
    if test -n "$context"
        set -a kubectl_args --context $context
    end
    if test -n "$namespace"
        set -a kubectl_args -n $namespace
    end

    kubectl $kubectl_args rollout restart deploy,sts,ds -l app=$label
end
