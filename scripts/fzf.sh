_gen_fzf_default_opts() {
  local base03="234"
  local base02="235"
  local base01="240"
  local base00="241"
  local base0="244"
  local base1="245"
  local base2="254"
  local base3="230"
  local yellow="136"
  local orange="166"
  local red="160"
  local magenta="125"
  local violet="61"
  local blue="33"
  local cyan="37"
  local green="64"

  export FZF_DEFAULT_OPTS="
    --color fg:-1,bg:-1,hl:$blue,fg+:$base2,bg+:$base02,hl+:$blue
    --color info:$yellow,prompt:$yellow,pointer:$base3,marker:$base3,spinner:$yellow
  "
}

kex() {
  local POD=$(kubectl get pods --no-headers | fzf-tmux --reverse --multi | awk -F'[ ]' '{print $1}')
  local CONTEXT=$(kubectl config current-context | tr -d '\n')
  local NAMESPACE=$(kubectl config view | grep namespace: | cut -d ':' -f 2 | tr -d '[:space:]' | tr -d '\n')
  if [[ $POD != '' ]]; then
    echo  "\n  \033[1mContext:\033[0m" $CONTEXT
    echo  "  \033[1mNamespace:\033[0m" $NAMESPACE
    echo  "  \033[1mPod:\033[0m" $POD
    OPTIONS="-it"
    vared -p $'  \033[1mOptions:\033[0m ' OPTIONS
    if [[ $@ == '' ]]; then
      CMD="bash"
      vared -p $'  \033[1mCommand:\033[0m ' CMD
    else
      CMD="$@"
    fi
    echo ''
    print -s kex "$@"
    print -s kubectl exec $OPTIONS $POD $CMD
    zsh -c "kubectl exec $OPTIONS $POD $CMD"
  fi
  export FZF_DEFAULT_OPTS=""
}

_gen_fzf_default_opts
