#zmodload zsh/zprof

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
#if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
#fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.

eval "$(keychain --quiet --eval --agents ssh id_rsa)"

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

# Локација проширења 
# /home/lain/.local/share/zinit/plugins/

# Add in Powerlevel10k
# zinit ice depth=1; zinit light romkatv/powerlevel10k

# Add in zsh plugins
# Load completions first

zinit light zsh-users/zsh-syntax-highlighting

zinit light zsh-users/zsh-completions

zinit light zsh-users/zsh-autosuggestions

zinit light Aloxaf/fzf-tab

zinit light "atuinsh/atuin"

# zinit light arzzen/calc.plugin.zsh

autoload -Uz compinit
compinit
zinit cdreplay -q


#zinit ice as"command" from"gh-r" \
#          atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
#          atpull"%atclone" src"init.zsh"
#zinit light starship/starship

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
zstyle ':fzf-tab:complete:z:*' fzf-preview 'ls --color $realpath'

# Ажурирање -------------------------------------------------

# ================================

# EndeavourOS - ONLY

alias azu-eos='eos-update --aur'

# ================================

# Garuda Linux - ONLY

alias azu-gar='garuda-update'

# ================================

# Универзало ажурирање

alias up='~/dotfiles/scripts/up.sh'

# ALIAS -----------------------------------------------------

alias linutil="curl -fsSL https://christitus.com/linux | sh"
alias ftn="~/dotfiles/scripts/ftn.sh"
alias cmd='bat ~/dotfiles/cmd/cmd.md'
alias catgit='brave https://github.com/catppuccin'
alias pasters="cd ~/dotfiles/scripts/pasters && python pasters.py"
alias ls='ls --color'
alias neovim='nvim'
alias vim='nvim'
alias kolo='~/dotfiles/scripts/kolo.sh'
alias zed='zeditor'
alias crc='~/dotfiles/scripts/crc.sh'
alias entropy='~/dotfiles/scripts/entropy.sh'
alias trash='~/dotfiles/scripts/trash.sh'
alias catbox='~/dotfiles/scripts/catbox.sh'
alias litterbox='~/dotfiles/scripts/litterbox.sh'
alias cursor='~/Applications/Cursor/cursor.appimage'
alias cgit='~/dotfiles/scripts/cgit.sh'
alias cspicetify='~/dotfiles/scripts/cspicetify.sh'
alias togcop='~/dotfiles/scripts/togcop.sh'
alias y='yazi'
alias py='python'
alias refresh='source ~/.zshrc'

# https://filen.io ------------------------------------------
# alias filen-cli="~/filen-cli"

# alias fzf='fzf --preview 'bat --style=numbers --color=always {}''

# DOOM / Eternal

alias corrax='~/dotfiles/scripts/corrax'
alias doom='~/dotfiles/scripts/doom'

# ls | lsd
# alias ls='lsd -1'
alias ls='lsd --group-directories-first'

# OLLAMA ----------------------------------------------------

alias lama='~/dotfiles/scripts/lama.sh'

alias ollamastop="sudo systemctl stop ollama.service"
alias ollamastart="sudo systemctl start ollama.service"
alias ollamastatus="sudo systemctl status ollama.service"

alias ollamallama="ollama run dolphin-llama3"
alias ollamaqwen="ollama run qwen2.5-coder:1.5b"

# ALIAS -----------------------------------------------------

export "MICRO_TRUECOLOR=1"

export EDITOR="micro"

export VISUAL=micro

# Shell integrations
eval "$(starship init zsh)"

eval "$(fzf --zsh)"

eval "$(zoxide init zsh)"

# eval $(thefuck --alias fk)

# eval $(thefuck --alias)

#zprof

export FZF_DEFAULT_OPTS=" \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
--color=selected-bg:#45475a \
--multi"

# bun completions
[ -s "/home/lain/.bun/_bun" ] && source "/home/lain/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

export PATH=$PATH:/home/lain/.spicetify
export PATH="${HOME}/.local/bin":${PATH}

export PATH="/home/lain/.bun/bin:$PATH"

eval "$(atuin init zsh)"


# filen-cli
PATH=$PATH:~/.filen-cli/bin
