ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg[green]%}("
ZSH_THEME_GIT_PROMPT_SUFFIX=")%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN=""

PROMPT='
[%*] %{$fg_bold[blue]%}%d%{$reset_color%}$(git_prompt_info)
%{$fg[yellow]%}%m%{$reset_color%} %(?:%{$fg_bold[green]%}➜ %{$reset_color%}:%{$fg_bold[red]%}➜ %{$reset_color%}) '

