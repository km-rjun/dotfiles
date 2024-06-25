bindkey  "^[[H"   beginning-of-line
bindkey  "^[[F"   end-of-line
bindkey  "^[[3~"  delete-char

# zstyle :compinstall filename '/home/rjun/.zshrc'
autoload -Uz compinit
setopt PROMPT_SUBST
compinit
zstyle ':completion:*' menu select
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory
bindkey -e

source ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
source ~/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
source <(fzf --zsh)

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
alias dotfiles='git --git-dir=$HOME/dotfiles/ --work-tree=$HOME/'
alias viclean='rm -f /home/rjun/.local/state/nvim/swap/*'

eval "$(starship init zsh)"
