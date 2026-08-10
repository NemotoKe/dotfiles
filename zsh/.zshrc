# ~/.zshrc is sourced by all interactive zsh shells (login and non-login).
# ~/.zprofile is login-only, so PATH additions live here to also cover
# non-login terminals such as the VS Code integrated terminal.

export PATH="/Users/nemotokenta/.local/bin:$PATH"

# Neon prompt
PROMPT='%F{cyan}%n%f%F{8}@%f%F{magenta}%m%f %F{blue}%1~%f %F{magenta}❯%f '

# lsにも色を付ける
export CLICOLOR=1
alias ls='ls -G'

PROMPT='%B%F{cyan}%1~%f%b %F{magenta}❯%f '
RPROMPT=''

eval "$(zoxide init zsh)"

source <(fzf --zsh)

alias ll='eza -la --git --group-directories-first'
alias tree='eza --tree --level=2'

alias cat='bat --paging=never'

alias vim='nvim'
alias vi='nvim'

export EDITOR=nvim
export VISUAL=nvim

bindkey -v

export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
  --bind='ctrl-j:down,ctrl-k:up,ctrl-h:backward-char,ctrl-l:forward-char'"

autoload -Uz compinit && compinit

export JAVA_HOME="$(brew --prefix openjdk@21)/libexec/openjdk.jdk/Contents/Home"
export PATH="$JAVA_HOME/bin:$PATH"
