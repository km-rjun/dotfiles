bindkey  "^[[1"   beginning-of-line
bindkey  "^[[4"   end-of-line
bindkey  "^[[3~"  delete-char
bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word

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

# Check and install zsh-autosuggestions if not already installed
if [ ! -f ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh ]; then
  echo "zsh-autosuggestions not found, installing..."
  git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.config/zsh/zsh-autosuggestions
fi

# Check and install zsh-syntax-highlighting if not already installed
if [ ! -f ~/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh ]; then
  echo "zsh-syntax-highlighting not found, installing..."
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.config/zsh/zsh-syntax-highlighting
fi

# Source the plugins only if the files exist
if [ -f ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh ]; then
  source ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
fi

if [ -f ~/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh ]; then
  source ~/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
fi

# ALIASES #
alias ls='ls --color=auto'
alias grep='grep --color'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias vim='nvim'
alias ed='nvim $(fzf --preview="cat {}")'
alias j="cd \$(dirs -l -p | sed 's#~#$HOME#g' | fzf --height 40% --reverse --preview 'tree -C {} | head -200')"
eval "$(starship init zsh)"
