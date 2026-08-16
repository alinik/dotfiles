function vi --description 'Open Helix when available, otherwise Vi'
    if type -q hx
        command hx $argv
    else
        command vi $argv
    end
end
