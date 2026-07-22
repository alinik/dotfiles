function mkenv --description 'generate .env from a general-secret configmap named after the cwd'
    set -l env_configmap (basename (pwd))-env
    python3 "$HOME/bin/mkenv-configmaps" general-secret $env_configmap --output .env
end
