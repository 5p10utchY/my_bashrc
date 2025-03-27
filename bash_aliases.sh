## Alias perso
alias l='ls -AF'
alias ll='ls -lh'
alias lla='ls -lAh'
alias c='clear'

## Pour utiliser un SuperDrive Apple
alias apple-superdrive-connect='sg_raw /dev/sr0 EA 00 00 00 00 00 01'

## Serveur Jelastic d'Infomaniak pour l'activation et désactivation du VPS
## Exemple:
alias ik-vps-connect='ssh 21423073-7715@gate.jpc.infomaniak.com -p 3022 -i ~/.ssh/vps-jelastic-03_rsa'
alias ik-vps-start='curl -d "envName=envsg-2600289&session=efa9be44742a2b30c4db02394122" -X POST https://app.jpc.infomaniak.com/1.0/environment/control/rest/startenv'
alias ik-vps-stop='curl -d "envName=envsg-2600289&session=efa9be44742a2b30c4db02394122" -X POST https://app.jpc.infomaniak.com/1.0/environment/control/rest/stopenv'

## nVim pour le développement
#alias vi='nvim'
#alias vim='nvim'
#alias vimdiff='nvim -d'
#export EDITOR=nvim

