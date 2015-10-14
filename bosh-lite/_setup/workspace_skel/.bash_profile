source ~/.profile

export EDITOR=vim

GREEN="\[\e[0;32m\]"
BLUE="\[\e[0;34m\]"
RED="\[\e[0;31m\]"
BRED="\e[1;31m\]"
YELLOW="\[\e[0;33m\]"
WHITE="\e[0;37m\]"
BWHITE="\e[1;37m\]"
COLOREND="\[\e[00m\]"

alias tree='tree --dirsfirst -C'
alias ls='ls -G'
alias ll='ls -lh'
alias l='ll'
alias lla='ll -A'
alias la='lla'
alias vi='vim'
alias gtop='cd $(git rev-parse --show-toplevel || echo ".")'
alias sub='subl'

..() {
  for i in $(seq $1); do cd ..; done;
}

tgz() {
  tar -zcvf "$1.tar.gz" "$1"
}

untgz() {
  tar -zxvf $1
}

src() {
  if [ "$2" != "" ]; then
    prj_path=~/Source/`ls -1 ~/Source | grep -i -m 1 "$1"`
    vim "$prj_path/`ls -1 $prj_path | grep -i -m 1 "$2"`" -c "Git pull"
  else
    cd ~/Source
    if [ "$1" != "" ]; then
      cd `ls -1 | grep -i -m 1 "$1"`
    fi
  fi
}

# more PATH adjustments
export PATH=$PATH:$HOME/bin # user bin directory

parse_git_branch() {
  if [[ -f "$BASH_COMPLETION_DIR/git-completion.bash" ]]; then
    branch=`__git_ps1 "%s"`
  else
    ref=$(git symbolic-ref HEAD 2> /dev/null) || return
    branch="${ref#refs/heads/}"
  fi

  if [[ `tput cols` -lt 110 ]]; then
    branch=`echo $branch | sed s/feature/f/1`
    branch=`echo $branch | sed s/hotfix/h/1`
    branch=`echo $branch | sed s/release/\r/1`

    branch=`echo $branch | sed s/master/mstr/1`
    branch=`echo $branch | sed s/develop/dev/1`
  fi

  if [[ $branch != "" ]]; then
    if [[ $(git status 2> /dev/null | tail -n1) == "nothing to commit, working directory clean" ]]; then
      echo "${GREEN}($branch)${COLOREND} "
    else
      echo "${RED}($branch)${COLROEND} "
    fi
  fi
}

working_directory() {
  dir=`pwd`
  in_home=0
  if [[ `pwd` =~ ^"$HOME"(/|$) ]]; then
    dir="~${dir#$HOME}"
    in_home=1
  fi

  workingdir=""
  if [[ `tput cols` -lt 110 ]]; then
    first="/`echo $dir | cut -d / -f 2`"
    letter=${first:0:2}
    if [[ $in_home == 1 ]]; then
      letter="~$letter"
    fi
    proj=`echo $dir | cut -d / -f 3`
    beginning="$letter/$proj"
    end=`echo "$dir" | rev | cut -d / -f1 | rev`

    if [[ $proj == "" ]]; then
      workingdir="$dir"
    elif [[ $proj == "~" ]]; then
      workingdir="$dir"
    elif [[ $dir =~ "$first/$proj"$ ]]; then
      workingdir="$beginning"
    elif [[ $dir =~ "$first/$proj/$end"$ ]]; then
      workingdir="$beginning/$end"
    else
      workingdir="$beginning/…/$end"
    fi
  else
    workingdir="$dir"
  fi

  echo -e "${YELLOW}$workingdir${COLOREND} "
}

parse_remote_state() {
  remote_state=$(git status -sb 2> /dev/null | grep -oh "\[.*\]")
  if [[ "$remote_state" != "" ]]; then
    out="${BLUE}[${COLOREND}"

    if [[ "$remote_state" == *ahead* ]] && [[ "$remote_state" == *behind* ]]; then
      behind_num=$(echo "$remote_state" | grep -oh "behind \d*" | grep -oh "\d*$")
      ahead_num=$(echo "$remote_state" | grep -oh "ahead \d*" | grep -oh "\d*$")
      out="$out${RED}$behind_num${COLOREND},${GREEN}$ahead_num${COLOREND}"
    elif [[ "$remote_state" == *ahead* ]]; then
      ahead_num=$(echo "$remote_state" | grep -oh "ahead \d*" | grep -oh "\d*$")
      out="$out${GREEN}$ahead_num${COLOREND}"
    elif [[ "$remote_state" == *behind* ]]; then
      behind_num=$(echo "$remote_state" | grep -oh "behind \d*" | grep -oh "\d*$")
      out="$out${RED}$behind_num${COLOREND}"
    fi

    out="$out${BLUE}]${COLOREND}"
    echo "$out "
  fi
}

prompt() {
  if [[ $? -eq 0 ]]; then
    exit_status="${BLUE}▸${COLOREND} "
  else
    exit_status="${RED}▸${COLOREND} "
  fi

  PS1="[BOSH-lite] $(working_directory)$(parse_git_branch)$(parse_remote_state)$exit_status"
}

#Ensure SSH private key exists
if [ ! -f ~/.ssh/id_rsa ]; then
  echo "Generating local SSH key"
  ssh-keygen -f ~/.ssh/id_rsa -t rsa -N '' > /dev/null
fi

#Set up the interactive prompt
PROMPT_COMMAND=prompt

#Configure environment variables
warn_if_env_missing() {
 eval ENV_VALUE=\$$1
 if [ "$ENV_VALUE" == "" ]; then
   echo -e "\x1B[01;33m WARNING: Environment var: $1 is not set.  You won't be able to $2. \x1B[0m"
 fi
}
#Configure environment variables
export BOSH_CONFIG=~/.bosh_config
if [ -f ~/.env ]; then
 echo "Loading ENV variables from ~/.env"
 source ~/.env
fi

#Validate that the required values are set
warn_if_env_missing GIT_AUTHOR_NAME "commit changes to Git"
warn_if_env_missing GIT_AUTHOR_EMAIL "commit changes to Git"
export GIT_COMMITTER_NAME="${GIT_COMMITTER_NAME:-"$GIT_AUTHOR_NAME"}"
export GIT_COMMITTER_EMAIL="${GIT_COMMITTER_EMAIL:-"$GIT_AUTHOR_EMAIL"}"

#Turn on the credential helper so that Git will save your credentials in memory 1 hour.
git config --global credential.helper 'cache --timeout=3600'

#Enable command completions
complete -C '/usr/local/bin/aws_completer' aws
