function cmdb --wraps git
    sudo git --git-dir=/root/.cmdb --work-tree=/ $argv
end
