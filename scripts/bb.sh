#!/bin/sh
#
# Opens the bitbucket page for a repo/branch in your browser.
#
# bb [remote] [branch]

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

bitbucketurl=$(git config --get $remote_url)
if [ -z "$bitbucketurl" ]
then
    echo "$remote_url not set."
    exit 1
fi

bitbucketurl=${bitbucketurl/git\@bitbucket\.org\:/https://bitbucket.org/}
bitbucketurl=${bitbucketurl%\.git}

if [ -z "$2" ]
then
    branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
else
    branch="$2"
fi

if [ ! -z "$branch" ]
then
    bitbucketurl="${bitbucketurl}/branch/${branch}"
fi

open $bitbucketurl
exit 0
