#!/bin/zsh

echo "💾 SSH Key Backup Tool"
echo "====================="

if [[ ! -d "$HOME/.ssh" ]]; then
    echo "❌ No .ssh directory found in home folder"
    exit 1
fi

BACKUP_DEST="/Volumes/external-0/0_Backup/Mac/SSH_$USER/"
echo "📁 Creating backup directory..."
mkdir -p "$BACKUP_DEST"

echo "📋 Backing up SSH keys and configs..."
for file in "$HOME/.ssh"/*; do
    [[ -f "$file" ]] && cp -p "$file" "$BACKUP_DEST"
done

echo "📋 Backing up this script..."
cp -p "$0" "$BACKUP_DEST"

echo "✅ SSH keys and script backed up successfully!"
echo "📍 Location: $BACKUP_DEST"