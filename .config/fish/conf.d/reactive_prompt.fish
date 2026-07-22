status is-interactive; or exit

function __reactive_space -d "expand abbreviations, insert space, force prompt repaint (live right-prompt)"
    commandline -f expand-abbr
    commandline -i ' '
    commandline -f repaint
end

bind ' ' __reactive_space
