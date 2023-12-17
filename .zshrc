# Originally a oh-my-zsh setup
#
# Load all stock functions (from $fpath files) called below.
autoload -U compaudit compinit

# Load zsh settings
source "$HOME/src/dotfiles/zsh/history.zsh"

# Add gitfast plugin
#fpath=($HOME/src/dotfiles/zsh/plugins/gitfast $fpath)
#source "$HOME/src/dotfiles/zsh/plugins/gitfast/gitfast.plugin.zsh"

# Load theme
setopt prompt_subst
source "$HOME/src/dotfiles/zsh/themes/sunrise-w-job-count.zsh-theme"

alias tt='tmux attach'
alias l='eza --long'
alias ll='eza --binary --header --long'
alias la='eza --all --long'
alias lg='eza --all --long --git-ignore'
alias sayweather="curl http://dd.weather.gc.ca/citypage_weather/mp3/ON/s0000430_sa_e.mp3 | mpv -"
alias trimclip="pbpaste | perl -pe 's/^-[0-9]- .* » (.*?) +(\\d+ ↵|$)/\\$ \\1/' | pbcopy"
alias lock="pmset displaysleepnow"
alias gctags="git ls-files | /usr/local/opt/universal-ctags/bin/ctags --extras=+f -L-"

alias gpsup='git push --set-upstream origin $(git_current_branch)'
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'

# Function
plexc () {cp --recursive --link "$*" /bigdata/plexmas/}
plexm () {cp --recursive --link "$*" /bigdata/plexmovies/}
plext () {cp --recursive --link "$*" /bigdata/plextv/}
sus () {sort $* | uniq -c | sort -nr}
jql () {jq -C "." <$* | less}
got () {cowsay "got $*?"}
reddit () {
  curl --silent --url "https://www.reddit.com/r/"$1"/.json" \
  --user-agent "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_3) AppleWebKit/537.75.14 (KHTML, like Gecko) Version/7.0.3 Safari/7046A194A" |
  jq --raw-output '.data.children[].data| select(.stickied == false) | [.title, .url, .score, .created] | @tsv'
}
msay () {say "$*" -o output && ffmpeg -i output.aiff -y ~/Desktop/output.mp3 && rm output.aiff}
grab () {cd ~/grabbed && git clone "$1"}
gpr () {git fetch origin "pull/$1/head:pr$1" && git checkout "pr$1"}

# Enable direnv
eval "$(direnv hook zsh)"

# Enable alt+. in other terminals
bindkey '\e.' insert-last-word

# FZF setup
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Work setup if present
[ -f ~/.workrc ] && source ~/.workrc
