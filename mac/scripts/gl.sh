#!/bin/sh
#
# Opens the GitLab page for a repo/branch in your browser.
#
# gl [remote] [branch]

git rev-parse 2>/dev/null

if [[ $? != 0 ]]
then
    echo "Not a git repository."
    exit 1
fi

remote="origin"
if [ ! -z "$1" ]
then
    remote="$1"
fi

remote_url="remote.${remote}.url"

gitlaburl=$(git config --get $remote_url)
if [ -z "$gitlaburl" ]
then
    echo "$remote_url not set."
    exit 1
fi

# Convert either git@host:owner/repo.git or ssh://git@host/owner/repo.git to HTTPS.
case "$gitlaburl" in
  git@*)
    hostpath=${gitlaburl#git@}
    hostpath=${hostpath/:/\/}
    gitlaburl="https://$hostpath"
    ;;
  ssh://*)
    hostpath=${gitlaburl#ssh://}
    hostpath=${hostpath#*@}
    gitlaburl="https://$hostpath"
    ;;
esac
gitlaburl=${gitlaburl%\.git}

if [ -z "$2" ]
then
    branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
else
    branch="$2"
fi

if [ ! -z "$branch" ]
then
    gitlaburl="${gitlaburl}/compare/master...${branch}"
fi

open $gitlaburl
exit 0
