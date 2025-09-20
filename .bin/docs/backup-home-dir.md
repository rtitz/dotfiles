# Backup home dir

**[BACK](../../README.md)**

```zsh
cd /Users
homedir="rene"
dstdir="/Volumes/external-0/tmp"
sudo tar cfvz ${dstdir}/$(date +%Z_%Y-%m-%d_%H.%M.%S)_${homedir}.tar.gz --exclude="${homedir}/Library/Mobile\ Documents" --exclude="${homedir}/Library/Caches" --exclude="${homedir}/Containers/com.docker.docker" --exclude="${homedir}/Library/Containers/com.utmapp.UTM/*" --exclude="${homedir}/Library/Containers/com.apple.PressAndHold/Data/Library" --exclude="${homedir}/Library/Group Containers/group.com.apple.CoreSpeech" --exclude="${homedir}/Library/Containers/net.whatsapp.WhatsApp" --exclude="${homedir}/.config/iterm2/sockets" --exclude="${homedir}/Library/Containers/com.apple.photoanalysisd" --exclude="${homedir}/Library/Metadata/CoreSpotlight" --exclude="${homedir}/Applications/go" --exclude="${homedir}/tmp/*" --exclude="${homedir}/Downloads/*" --exclude="${homedir}/Music/*" --exclude="${homedir}/Movies/*" ${homedir}/

sudo rsync -avP --delete /Users/ /Volumes/external-0/tmp
```

**[BACK](../../README.md)**homedir}