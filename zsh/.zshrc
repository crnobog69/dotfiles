# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.



# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# ZSH_THEME="powerlevel10k/powerlevel10k"

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in Powerlevel10k
# zinit ice depth=1; zinit light romkatv/powerlevel10k

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

bindkey '^[[5~' beginning-of-line
bindkey '^[[6~' end-of-line
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word
bindkey "\e[3~" delete-char

export TERM="xterm-256color"

# History
HISTSIZE=1000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# ALIAS -----------------------------------------------------

alias linutil="curl -fsSL https://christitus.com/linux | sh"
alias ftn="~/dotfiles/scripts/ftn.sh"
alias azu='eos-update --aur'
alias cmd='bat ~/dotfiles/cmd/cmd.md'
alias catgit='brave https://github.com/catppuccin'
alias pasters="~/dotfiles/scripts/pasters/pasters.py"
alias ls='ls --color'
alias neovim='nvim'
alias vim='nvim'
alias lsd='lsd'
alias ls='lsd -1'

# ALIAS -----------------------------------------------------

export "MICRO_TRUECOLOR=1"

export EDITOR="micro"


# Shell integrations
eval "$(fzf --zsh)"

eval $(thefuck --alias fk)

eval "$(starship init zsh)"

eval "$(zoxide init zsh)"
