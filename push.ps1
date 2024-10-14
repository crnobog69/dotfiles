# Скрипта која аутоматизује `git add`, `git commit` и `git push` за Windows
# Покретање: отворите PowerShell и покрените ову скрипту

# Изврши git pull
git pull

# Додај све промене
git add .

# Направи commit са стандардном поруком
git commit -m "❄️"

# Пошаљи промене на GitHub (или други remote)
git push origin main

# Пошаљи промене на Codeberg
git push codeberg main

# Пошаљи промене на GitLab
git push gitlab main
