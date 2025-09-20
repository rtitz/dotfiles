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
git clone git@github.com:rtitz/ansible-collection-go.git
git clone git@github.com:rtitz/ansible-rpi.git
git clone git@github.com:rtitz/ansible-rpi-desktop.git
git clone git@github.com:rtitz/aws.git
git clone git@github.com:rtitz/aws-ec2.git
git clone git@github.com:rtitz/aws-iam-key-rotator.git
git clone git@github.com:rtitz/aws-s3-backup.git
git clone git@github.com:rtitz/aws-s3-backup-cdk.git
git clone git@github.com:soypat/cyw43439.git
git clone git@github.com:xsalazar/emoji-kitchen.git
git clone git@github.com:rtitz/go-notify.git
git clone git@github.com:rtitz/go-r53-dyndns.git
git clone https://github.com/geerlingguy/mac-dev-playbook.git
git clone git@github.com:rtitz/network.git
git clone git@github.com:rtitz/photo-copy.git
git clone git@github.com:rtitz/private.git
git clone git@github.com:elulcao/progress-bar.git
git clone git@github.com:svalouch/python-rctclient.git
git clone git@github.com:rtitz/rpi-fan-control.git
git clone git@github.com:rtitz/shaky-ghost.git
git clone git@github.com:rtitz/solar-monitor.git
git clone git@github.com:rtitz/time.git
git clone git@github.com:rtitz/time-ios.git
git clone git@github.com:rtitz/uscalc.git
git clone git@github.com:rtitz/webserver-go.git
git clone git@github.com:rtitz/webview.git
git clone git@github.com:rtitz/wiki.git
```
