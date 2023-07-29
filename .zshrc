# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

bindkey  "^[[H"   beginning-of-line
bindkey  "^[[F"   end-of-line
bindkey  "^[[3~"  delete-char

# The following lines were added by compinstall
zstyle :compinstall filename '/home/rjun/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
bindkey -e
# End of lines configured by zsh-newuser-install
source /home/rjun/.config/zsh/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f /home/rjun/.config/zsh/powerlevel10k/p10k.zsh ]] || source /home/rjun/.config/zsh/powerlevel10k/p10k.zsh


source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 
source /home/rjun/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh



ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.tar.xz)    tar xJf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}



# ALIASES #

alias ls='ls --color=auto'
alias grep='grep --color'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias vim='nvim'
alias mnthub='sudo mount /dev/sda5 /mnt/archb/'
alias mntarch='sudo mount /dev/sda8 /mnt/archb/'
alias vpn='sudo systemctl start warp-svc.service && echo "VPN is Connected"'
alias vpn-off='sudo systemctl stop warp-svc.service && echo "VPN Disconnected"'
alias gpt='function_name() { tgpt "$*"; }; function_name'
alias ai='function_name() { tgpt "$*"; }; function_name'
alias dotfiles='git --git-dir=$HOME/Documents/dotfiles/ --work-tree=$HOME/'

neofetch
