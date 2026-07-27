function gpsup --description 'git push --set-upstream origin <current-branch> (omz git plugin port)'
    git push --set-upstream origin (git symbolic-ref --short HEAD)
end
