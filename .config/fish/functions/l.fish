function l
    if type -q lsd
        command lsd -lh --group-directories-first $argv 2> /dev/null
    else
        command ls -lh $argv
    end
end
