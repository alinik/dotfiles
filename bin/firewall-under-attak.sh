#!/bin/bash
curl -s -X PATCH "https://api.cloudflare.com/client/v4/zones/16ba1ded01e49db0a0e6c9356647ba49/settings/security_level" -H "Authorization: Bearer qhTngdSH2LDjKNK2lAKFBWske63F945DImnJCmjl" -H "Content-Type:application/json" -d '{"value":"under_attack"}'|jq .success
