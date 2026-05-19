typeset -g KLFJ_PLUGIN_DIR="${${(%):-%x}:A:h}"

klfj() {
    "${KLFJ_PLUGIN_DIR}/klfj" "$@"
}

_klfj() {
    local saved_current=$CURRENT
    local -a saved_words
    local -a args_without_klfj_flags
    local i
    local current_adjust=1

    saved_words=("${words[@]}")
    words=("kubectl" "logs")

    args_without_klfj_flags=()
    for (( i = 2; i <= ${#saved_words[@]}; i++ )); do
        case "${saved_words[i]}" in
            --no-color)
                if (( i < saved_current )); then
                    (( current_adjust -= 1 ))
                fi
                ;;
            *)
                args_without_klfj_flags+=("${saved_words[i]}")
                ;;
        esac
    done

    if (( ${#args_without_klfj_flags[@]} > 0 )); then
        words+=("${args_without_klfj_flags[@]}")
    fi
    (( CURRENT = saved_current + current_adjust ))

    _kubectl
}

compdef _klfj klfj
