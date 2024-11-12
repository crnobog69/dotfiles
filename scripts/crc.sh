#!/bin/bash

# Боје
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
BLUE='\033[0;34m'
RESET='\033[0m'

# Проверимо да ли је аргумент прослеђен
if [ -z "$1" ]; then
    echo -e "${RED}Унесите име датотеке са .c на крају!${RESET}"
    echo "Пример коришћења: ./crc.sh program.c -lm"
    echo -e "${YELLOW}За помоћ укуцати ./crc.sh --help${RESET}"
    exit 1
fi

# Ако је корисник унео --help, приказујемо помоћ
if [ "$1" == "--help" ]; then
    echo "==================================================================="
    echo
    echo -e "${RED}Алат за једноставно компајлирање програма написаних у 'C'.${RESET}"
    echo
    echo -e "${CYAN}'crc.sh' Скрипта / Помоћ (Compile, Run, C)${RESET}"
    echo
    echo "==================================================================="    
    echo
    echo -e "${YELLOW}Коришћење:${RESET}"
    echo -e "${BLUE}  ./crc.sh ime_datoteke.c додатне_опције${RESET}"
    echo
    echo -e "${YELLOW}Опис:${RESET}"
    echo "  Овај алат компајлира програме написане у C и поседује опцију"
    echo "  додавања библиотеке ако је потребно."
    echo -e "${RED}  Пример 1:${RESET} ${BLUE}./crc.sh program.c${RESET}"
    echo -e "${RED}  Пример 2:${RESET} ${BLUE}./crc.sh program.c -lm -lncurses${RESET}"
    echo -e "${RED}  Пример 3:${RESET} ${BLUE}./crc.sh program.c -lm${RESET}"
    echo
    echo "==================================================================="
    echo
    echo -e "${YELLOW}Додатне опције:${RESET}"
    echo "  --help        Приказује ову помоћ."
    echo "  -lm           Додаје математичку библиотеку."
    echo "  -lncurses     Додаје библиотеку за рад са терминалом."
    echo "  -lpthread     Додаје библиотеку за рад са нитима."
    echo "  Или нека друга библиотека, исто као 'gcc'."
    echo
    echo "==================================================================="
    exit 0
fi

# Име датотеке са екстензијом
FILE=$1

# Проверимо да ли датотека има .c екстензију
if [[ "$FILE" != *.c ]]; then
    echo -e "${RED}Унесите име датотеке са .c на крају!${RESET}"
    echo -e "${YELLOW}За помоћ укуцати ./crc.sh --help${RESET}"
    exit 1
fi

# Уклонити .c екстензију да добијемо име извршне датотеке
FILENAME=${FILE%.c}

# Додатне библиотеке (ако постоје)
shift # Уклонити први аргумент (име фајла)
LIBRARIES=$@

# Компилација са додатним библиотекама
echo -e "${CYAN}Компајлирање...${RESET}"
gcc "$FILE" -o "$FILENAME" $LIBRARIES
if [ $? -ne 0 ]; then
    echo -e "${RED}Грешка приликом компајлирања!${RESET}"
    echo -e "${YELLOW}За помоћ укуцати ./crc.sh --help${RESET}"
    exit 1
fi

# Покретање извршне датотеке
echo -e "${GREEN}Покретање извршне датотеке: ./${FILENAME}${RESET}"
echo "--------------------------" 
echo
./"$FILENAME"
