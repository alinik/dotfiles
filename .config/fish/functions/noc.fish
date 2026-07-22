function noc --description 'strip comment-only and blank lines'
    grep -vE '^\s*[#;]|^\s*$' $argv
end
