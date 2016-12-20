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

export PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/texbin:/Users/andrew/bin:/Users/andrew/anaconda3/bin"
# export MANPATH="/usr/local/man:$MANPATH"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#

# Aliases
alias zshconfig="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"

# Function
sus () {sort $* | uniq -c | sort -nr}
jql () {jq -C "." <$* | less}
got () {cowsay "got $*?"}
reddit () {
  curl --silent --url "https://www.reddit.com/r/"$1"/.json" \
  --user-agent "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_3) AppleWebKit/537.75.14 (KHTML, like Gecko) Version/7.0.3 Safari/7046A194A" |
  jq --raw-output '.data.children[].data| select(.stickied == false) | [.title, .url, .score, .created] | @tsv'
}

# Enable alt+. in other terminals
bindkey '\e.' insert-last-word

# Python Virtual Environment setup
VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3.5
source /usr/local/bin/virtualenvwrapper_lazy.sh

# Starting directory
cd ~/affinio

# FZF setup
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# golang setup
export GOPATH=$HOME/golang
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOPATH/bin
