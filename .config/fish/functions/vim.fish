function vim --description 'Open Helix when available, otherwise Vim'
    if type -q hx
        command hx $argv
    else
        command vim $argv
    end
end
