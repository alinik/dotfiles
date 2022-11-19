[ -e /usr/bin/vault ] || exit 0
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/bin/vault vault
#vault status -format=yaml |grep -q "sealed: true" && echo Vault $VAULT_ADDR Sealed!
