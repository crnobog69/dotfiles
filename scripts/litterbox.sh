#!/bin/bash

RED="\e[31m"
GREEN="\e[32m"
LAVANDER="\033[38;2;180;191;254m"
PEACH='\033[38;2;250;183;135m'
NC="\e[0m"

echo -e "${RED}"
echo =============================================
echo "[  _     _  _    _                          ]"
echo "[ | |   (_)| |  | |                         ]"
echo "[ | |    _ | |_ | |_  ___  _ __             ]"
echo "[ | |   | || __|| __|/ _ \| '__|            ]"
echo "[ | |___| || |_ | |_|  __/| |               ]"
echo "[ \_____/_| \__| \__|\___||_|               ]"
echo =============================================
echo -e "${RED}[${NC}===${LAVANDER} 󰁯 | Скрипта за litterbox.catbox.moe ${NC}===${RED}]${NC}"
echo -e "${RED}=============================================${NC}"
echo -e "${RED}[${NC}=== ${LAVANDER}--help | за помоћ${NC} =====================${RED}]${NC}"
echo -e "${RED}=============================================${NC}"
echo -e "${NC}"

# Провера интернет конекције
if ! ping -c 1 8.8.8.8 >/dev/null 2>&1; then
    echo -e "${RED}Нема интернет конекције${NC}"
    exit 1
fi

# Функција за проверу грешака
check_error() {
    if [ $? -ne 0 ]; then
        echo -e "${RED}Грешка: $1${NC}"
        return 1
    fi
    return 0
}

# Функција за приказ величине датотеке
format_size() {
    local size=$1
    if [ $size -ge 1073741824 ]; then
        echo "$(awk "BEGIN {printf \"%.2f\", $size/1073741824}") GB"
    elif [ $size -ge 1048576 ]; then
        echo "$(awk "BEGIN {printf \"%.2f\", $size/1048576}") MB"
    elif [ $size -ge 1024 ]; then
        echo "$(awk "BEGIN {printf \"%.2f\", $size/1024}") KB"
    else
        echo "$size B"
    fi
}

# Дозвољена времена чувања
ALLOWED_TIMES=("1h" "12h" "24h" "72h")

# Провера времена
check_time() {
    if [ $# -eq 0 ]; then
        echo "1h"
        return
    fi
    val=$1
    if [[ $val != *h ]]; then
        val+="h"
    fi
    if [[ " ${ALLOWED_TIMES[@]} " =~ " ${val} " ]]; then
        echo $val
    else
        echo -e "${RED}Неисправно време${NC}" >&2
        echo -1
    fi
}

# Помоћ
if [[ "$1" == "--help" || "$1" == "-h" ]]; then
    echo -e "${GREEN}  Коришћење${NC}: ${RED}./litterbox.sh${NC} ${GREEN}[опције] датотека(е)${NC}"
    echo
    echo -e "${RED} Доступне опције:${NC}"
    echo -e "  --help, -h      Прикажи ову помоћ"
    echo -e "  -t, --time      Постави време чувања (1h, 12h, 24h, 72h)"
    echo
    echo -e "${RED} Ова скрипта служи за привремено складиштење датотека.${NC}"
    echo
    echo -e "=== ${PEACH}Подржана времена чувања${NC}:"
    echo -e "${PEACH}󰃢 ${NC}1 сат (1h) | -t 1h | --time 1h"
    echo -e "${PEACH}󰃢 ${NC}12 сати (12h) | -t 12h | --time 12h"
    echo -e "${PEACH}󰃢 ${NC}24 сата (24h) | -t 24h | --time 24h"
    echo -e "${PEACH}󰃢 ${NC}72 сата (72h) | -t 72h | --time 72h"
    echo
    echo -e "${RED} Примери:${NC}"
    echo -e "  ./litterbox.sh slika.png"
    echo -e "  ./litterbox.sh -t 24h video.mp4"
    echo -e "  ./litterbox.sh --time 72h dokument.pdf slika.jpg"
    echo
    exit 0
fi

# Провера да ли је curl инсталиран
if ! command -v curl &> /dev/null; then
    echo -e "${RED}cURL није пронађен!${NC}"
    echo "Молимо инсталирајте cURL"
    exit 1
fi

HOST="https://litterbox.catbox.moe/resources/internals/api.php"

# Обрада аргумената
files=""
expiry="1h"
tn=0

for f in "$@"; do
    if [ $tn -eq 1 ]; then
        expiry=$(check_time $f)
        tn=0
    elif [ $f == "-t" ] || [ $f == "--time" ]; then
        tn=1
    elif [[ $f == --time=* ]]; then
        expiry=$(check_time $(echo $f | cut -d'=' -f 2))
    else
        if [ "$files" == "" ]; then
            files=$f
        else 
            files+=" $f"
        fi
    fi
done

# Провера грешака и отпремање
if [ "$expiry" == "-1" ]; then
    exit 1
elif [ "$files" == "" ]; then
    echo -e "${RED}Користите --help за помоћ.${NC}"
    echo -e "${RED}Нису задате датотеке${NC}" >&2
    exit 1
fi

# Питање за потврду
total_size=0
echo -e "\n${PEACH}Датотеке за отпремање:${NC}"
for file in $files; do
    if [ -f "$file" ] || [ -L "$file" ]; then
        size=$(stat -f%z "$file" 2>/dev/null || stat -c%s "$file")
        formatted_size=$(format_size $size)
        echo -e "${PEACH}󰈔 ${NC}$(basename "$file") ${PEACH}(${formatted_size})${NC}"
        total_size=$((total_size + size))
    fi
done
formatted_total=$(format_size $total_size)
echo -e "${PEACH}Укупна величина: ${formatted_total}${NC}"
echo -e "${PEACH}Време чувања: ${expiry}${NC}\n"

read -p "Да ли желите да наставите са отпремањем? (Y/n): " answer
if [[ "$answer" =~ ^[Nn]$ ]]; then
    echo -e "${RED}Отпремање је отказано.${NC}"
    exit 0
fi

echo -e "\n${PEACH}Отпремање...${NC}"
for file in $files; do
    if [ -f "$file" ] || [ -L "$file" ]; then
        name=$(basename -- "$file")
        size=$(stat -f%z "$file" 2>/dev/null || stat -c%s "$file")
        formatted_size=$(format_size $size)
        echo -e "${PEACH}$name${NC} ${PEACH}(${formatted_size})${NC}:"
        
        # Приказ прогреса
        link=$(curl --progress-bar -F "reqtype=fileupload" -F "time=$expiry" -F "fileToUpload=@$file" $HOST)
        check_error "Отпремање није успело"
        echo -e "Отпремљено на: ${GREEN}$link${NC}"
        echo -n $link | xclip -selection clipboard
    else
        echo -e "${RED}Датотека $file не постоји!${NC}"
    fi
done

echo -e "\n${GREEN}Отпремање је завршено!${NC}"
