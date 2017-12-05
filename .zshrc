# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
ZSH_THEME="sunrise-w-job-count"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(gitfast pip)

source $ZSH/oh-my-zsh.sh

# User configuration

export PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin"
export PERSONALPATH="/Users/$(whoami)/bin"
export PATH="$PATH:$PERSONALPATH"

# export MANPATH="/usr/local/man:$MANPATH"

export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#

# Aliases
alias zshconfig="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"

alias sayweather="curl http://dd.weather.gc.ca/citypage_weather/mp3/ON/s0000430_sa_e.mp3 | mpv -"
alias trimclip="pbpaste | perl -pe 's/^-[0-9]- .* » (.*?) +(\\d+ ↵|$)/\\$ \\1/' | pbcopy"
alias lock="pmset displaysleepnow"
alias gctags="git ls-files | /usr/local/opt/universal-ctags/bin/ctags --extras=+f -L-"

alias gpsup='git push --set-upstream origin $(git_current_branch)'

# Function
sus () {sort $* | uniq -c | sort -nr}
jql () {jq -C "." <$* | less}
got () {cowsay "got $*?"}
reddit () {
  curl --silent --url "https://www.reddit.com/r/"$1"/.json" \
  --user-agent "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_3) AppleWebKit/537.75.14 (KHTML, like Gecko) Version/7.0.3 Safari/7046A194A" |
  jq --raw-output '.data.children[].data| select(.stickied == false) | [.title, .url, .score, .created] | @tsv'
}
msay () {say "$*" -o output && ffmpeg -i output.aiff -y ~/Desktop/output.mp3 && rm output.aiff}

# Enable alt+. in other terminals
bindkey '\e.' insert-last-word

# Starting directory
cd ~/projects/

# FZF setup
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# golang setup
export GOPATH=$HOME/golang
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOPATH/bin

[ -f ~/.workrc ] && source ~/.workrc
