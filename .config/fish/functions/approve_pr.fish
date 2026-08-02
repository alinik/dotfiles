function approve_pr --description 'approve a Bitbucket PR by its overview UI URL'
    if not command -v jq >/dev/null 2>&1
        echo "approve_pr: jq not found in PATH." >&2
        return 127
    end

    set -l ui_url $argv[1]
    set -l base (string replace -r '/overview$' '' -- $ui_url)
    set -l api_url (string replace '/projects/' '/rest/api/1.0/projects/' -- $base)/approve
    curl -s -X POST "$api_url" \
        -H "Authorization: Bearer $BITBUCKET_BOT_API_KEY" \
        -H "Content-Type: application/json" \
        | jq .status
end
