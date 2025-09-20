# Encrypt files with macOS

**[BACK](../../README.md)**


```zsh
tar cfz - folder/ | openssl enc -e -aes-256-cbc -salt -md sha256 -out folder.tar.gz -pass pass:PASSWORD
openssl enc -d -aes-256-cbc -salt -md sha256 -in folder.tar.gz | tar xvz

zip -r -e folder.zip folder/ -x "*.venv*" "*cdk.out*" # -x only for excludes
```

**[BACK](../../README.md)**