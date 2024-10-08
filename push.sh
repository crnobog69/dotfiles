#!/bin/bash

# Скрипта која аутоматизује `git add`, `git commit` и `git push`

git pull
git add .
git commit -m "❄️"
git push origin main
git push codeberg main
git push gitlab main
