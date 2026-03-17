# Git

## # GitHub Authentication
```zsh
gh auth login
```

## Pull all repos

```zsh
cd $HOME/git/ && for repo in $(ls | grep -v \.md); do echo "$repo"; cd $repo && git pull; git status; cd ..; echo; done
```

## All repo remotes

```zsh
cd $HOME/git/ && for repo in $(ls | grep -v \.md); do cd $repo && git remote -v|grep fetch|sed 's/origin//g' | sed 's/(fetch)//g' | sed 's/[[:space:]]//g' | sed 's/^/git clone /g' ; cd ..;  done
```

## Clone all repos
```zsh
mkdir -p $HOME/git && cd $HOME/git || exit 1
pwd; ls
git clone git@github.com:soypat/cyw43439.git
git clone git@github.com:xsalazar/emoji-kitchen.git
git clone https://github.com/MariaLetta/free-gophers-pack.git
git clone https://github.com/geerlingguy/mac-dev-playbook.git

for repo in $(gh repo list --limit 1000 --json nameWithOwner,sshUrl,url -q '.[].url');
do
  echo $repo
  git clone $repo
done
```

