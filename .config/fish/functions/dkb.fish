function dkb --description 'docker build tagged reg.maxpool.ir/applications/<dir>:<branch>, starting Colima if needed'
    if not command -v docker >/dev/null 2>&1
        echo "dkb: docker not found in PATH." >&2
        return 127
    end

    if test -e /opt/homebrew/bin/colima
        if not colima status >/dev/null 2>&1
            echo "⚠️  Colima is not running. Starting Colima..."
            colima start
            while not colima status 2>&1 | grep -q "colima is running"
                sleep 1
            end
            echo "✅ Colima is up."
        end
    end

    set -l image_name (basename $PWD)
    set -l branch (git rev-parse --abbrev-ref HEAD)

    docker build . \
        --platform=linux/amd64 \
        --build-arg BRANCH="$branch" \
        --build-arg MODULE_NAME="$image_name" \
        -t "reg.maxpool.ir/applications/$image_name:$branch" \
        $argv
end
