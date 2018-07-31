# my own git aliases
alias gpp='git pull --prune'
alias get-git-branch-name='git rev-parse --abbrev-ref HEAD'
alias ggbn='get-git-branch-name'
alias gib='git branch -v'
alias gip='git branch --merged master | grep -v "master$" | xargs git branch -d'
alias gis='git status -sb'
alias gid='git diff'
alias gids='git diff --staged'
alias getlastcommit='git show --oneline | awk NR==1'
alias glc='getlastcommit'
alias push-current-branch-to-justinwoo='git push -u justinwoo $(git rev-parse --abbrev-ref HEAD)'
alias push-current-branch-to-origin='git push -u origin $(git rev-parse --abbrev-ref HEAD)'
alias gpj='push-current-branch-to-justinwoo'
alias gpo='push-current-branch-to-origin'
alias gfo='git fetch origin'
alias gfu='git fetch upstream'
alias gfj='git fetch justinwoo'
alias hey-mom-i-fixed-it='echo fixed in $(ggbn): $(glc)'
alias hmifi='hey-mom-i-fixed-it'
alias delete-merged-branches='git delete-merged-branches'
alias dmb='delete-merged-branches';
alias gcd='git co dev'
alias gc='git commit'
alias gcm='git commit -m'
alias gca='git commit --amend'
alias gcane='git commit --amend --no-edit'
alias gcanera='git commit --amend --no-edit --reset-author'
alias ga='git add'
alias gap='git add -p'
alias gac='ga . ; gc'
alias gr='git remote'
alias grs='git remote show'
alias gic='git checkout'

# hub
alias hc='hub clone'
alias hpr='hub pull-request'
alias hb='hub browse'
alias hrr='hub remote rename'

# pretty colors
alias gl='git log --graph --pretty=format:'\''%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'\'' --abbrev-commit'
alias gil='git log --decorate=full --stat --graph'
alias gild='git log --decorate'

# hell fuckin yeah get that fuckin shit done
alias gu='git fetch origin master && git rebase origin/master'
alias gudev='git fetch origin dev && git rebase origin/dev'
alias gupdate='git fetch origin master && git rebase origin/master'
alias gbupdate='git fetch origin $(ggbn) && git rebase FETCH_HEAD'
alias gbupstream='git fetch upstream $(ggbn) && git rebase FETCH_HEAD'
alias gupstream='git fetch upstream master && git rebase FETCH_HEAD'
alias greset='git fetch origin $(ggbn) && git reset --hard FETCH_HEAD'
alias gureset='git fetch upstream $(ggbn) && git reset --hard FETCH_HEAD'
alias gjreset='git fetch justinwoo $(ggbn) && git reset --hard FETCH_HEAD'
# update children
alias gpullallchildren='ls -d */ | xargs -P10 -I{} git -C {} pull'
alias gpac='gpullallchildren'
