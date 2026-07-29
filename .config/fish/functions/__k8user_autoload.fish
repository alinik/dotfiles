function __k8user_autoload --on-variable PWD --description 'auto-load update-cert.sh completions when entering k8-user dir'
    if test "$PWD" = "/Users/ali/PycharmProjects/DEV/k8-user"
        if not set -q __k8user_completions_loaded
            set -g __k8user_completions_loaded 1

            complete -c update-cert.sh -n '__fish_is_first_arg' -a '(cd /Users/ali/PycharmProjects/DEV/k8-user; for f in csr/*.csr; basename $f .csr; end)' -d user
            complete -c update-cert.sh -n '__fish_is_nth_token 2' -a 'novin delta asiatech' -d cluster
            complete -c update-cert.sh -n '__fish_is_nth_token 3' -a '170 365' -d days

            complete -c ./update-cert.sh -n '__fish_is_first_arg' -a '(cd /Users/ali/PycharmProjects/DEV/k8-user; for f in csr/*.csr; basename $f .csr; end)' -d user
            complete -c ./update-cert.sh -n '__fish_is_nth_token 2' -a 'novin delta asiatech' -d cluster
            complete -c ./update-cert.sh -n '__fish_is_nth_token 3' -a '170 365' -d days

            echo "update-cert.sh completions loaded" >&2
        end
    end
end
