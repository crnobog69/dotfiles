#!/bin/bash

RED="\e[31m"
GREEN="\e[32m"
LAVANDER="\033[38;2;180;191;254m"
PEACH='\033[38;2;250;183;135m'
PURPLE='\033[38;2;150;50;200m'
NC="\e[0m"

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

echo -e "${RED}"
echo =============================================
echo "[  ___ __ _| |_| |__   _____  __            ]"
echo "[ / __/ __ | __| '_ \ / _ \ \/ /            ]"
echo "[ | (_| (_|| |_| |_)|| |_| >  <             ]"
echo "[ \___\__,_|\__|_.__/ \___/_/\_\\            ]"
echo =============================================
echo -e "${RED}[${NC}${LAVANDER}=== 󰁯 | Скрипта за catbox.moe ${NC}=============${RED}]${NC}"
echo -e "${RED}=============================================${NC}"
echo -e "${RED}[${NC}=== ${LAVANDER}--help | за помоћ${NC} =====================${RED}]${NC}"
echo -e "${RED}=============================================${NC}"
echo -e "${NC}"

CATBOX_HOST="https://catbox.moe/user/api.php"
HASH_FILE="$HOME/.catbox"

# Провера да ли је curl инсталиран
if ! command -v curl &> /dev/null; then
    echo -e "${RED}cURL није пронађен!${NC}"
    echo "Молимо инсталирајте cURL"
    exit 1
fi

# Помоћ
if [[ "$1" == "--help" || "$1" == "-h" ]]; then
    echo -e "${GREEN}  Коришћење${NC}: ${RED}./catbox.sh${NC} ${GREEN}команда [опције]${NC}"
    echo
    echo -e "${RED} Доступне команде:${NC}"
    echo -e "  user [hash]     Постави или прикажи кориснички хеш"
    echo -e "  file            Отпреми датотеке"
    echo -e "  url             Отпреми са URL адресе"
    echo -e "  delete          Обриши датотеке"
    echo -e "  album           Управљање албумима"
    echo
    echo -e "${RED} Опције:${NC}"
    echo -e "  --help, -h      Прикажи ову помоћ"
    echo -e "  -u, --user-hash Постави кориснички хеш"
    echo -e "  -s, --silent    Тихи режим рада"
    echo
    echo -e "${RED} Примери коришћења:${NC}"
    echo -e "  ./catbox.sh file slika.png"
    echo -e "  ./catbox.sh url https://example.com/slika.jpg"
    echo -e "  ./catbox.sh album create \"Мој Албум\" \"Опис\" slika1.jpg slika2.png"
    echo
    exit 0
fi

# Учитај кориснички хеш
if [ -f $HASH_FILE ]; then
    USER_HASH=$(grep -v '^#' $HASH_FILE | head -n 1)
    CURL_ADD="-F userhash=$USER_HASH"
fi

# Обрада команди
case "$1" in
    "user")
        if [ -z "$2" ]; then
            if [ ! -z "$USER_HASH" ]; then
                echo -e "${GREEN}Кориснички хеш:${NC} $USER_HASH"
            else
                echo -e "${RED}Кориснички хеш није постављен${NC}"
            fi
        elif [ "$2" == "off" ]; then
            rm -f $HASH_FILE
            echo "Кориснички хеш је уклоњен"
        else
            echo -e "# CatBox кориснички хеш\n$2" > $HASH_FILE
            echo "Кориснички хеш је постављен"
        fi
        ;;
    "file")
        if [ -z "$2" ]; then
            echo -e "${RED}Унесите име датотеке!${NC}"
            exit 1
        fi
        echo -e "${PEACH}Отпремање...${NC}"
        echo -e "\n${PEACH}Датотеке за отпремање:${NC}"
        total_size=0
        for file in "${@:2}"; do
            if [ -f "$file" ]; then
                size=$(stat -f%z "$file" 2>/dev/null || stat -c%s "$file")
                formatted_size=$(format_size $size)
                echo -e "${PEACH}󰈔 ${NC}$(basename "$file") ${PEACH}(${formatted_size})${NC}"
                total_size=$((total_size + size))
            fi
        done
        formatted_total=$(format_size $total_size)
        echo -e "${PEACH}Укупна величина: ${formatted_total}${NC}\n"
        
        read -p "Да ли желите да наставите са отпремањем? (Y/n): " answer
        if [[ "$answer" =~ ^[Nn]$ ]]; then
            echo -e "${RED}Отпремање је отказано.${NC}"
            exit 0
        fi

        echo
        for file in "${@:2}"; do
            if [ -f "$file" ]; then
                name=$(basename "$file")
                size=$(stat -f%z "$file" 2>/dev/null || stat -c%s "$file")
                formatted_size=$(format_size $size)
                echo -e "${PEACH}$name${NC} ${PEACH}(${formatted_size})${NC}:"
                link=$(curl --progress-bar -F "reqtype=fileupload" $CURL_ADD -F "fileToUpload=@$file" $CATBOX_HOST)
                check_error "Отпремање није успело"
                echo -e "Отпремљено на: ${GREEN}$link${NC}"
                echo -n "$link" | xclip -selection clipboard
            else
                echo -e "${RED}Датотека $file не постоји!${NC}"
            fi
        done
        ;;
    "url")
        if [ -z "$2" ]; then
            echo -e "${RED}Унесите URL адресу!${NC}"
            exit 1
        fi
        echo -e "${PEACH}Отпремање...${NC}"
        for url in "${@:2}"; do
            echo -e "${PEACH}$url${NC}:"
            link=$(curl -F "reqtype=urlupload" $CURL_ADD -F "url=$url" $CATBOX_HOST)
            check_error "Отпремање није успело"
            echo -e "Отпремљено на: ${GREEN}$link${NC}"
            echo -n "$link" | xclip -selection clipboard
        done
        ;;
    "delete")
        if [ -z "$USER_HASH" ]; then
            echo -e "${RED}Потребан је кориснички хеш за брисање!${NC}"
            exit 1
        fi
        if [ -z "$2" ]; then
            echo -e "${RED}Унесите име датотеке за брисање!${NC}"
            exit 1
        fi
        echo -e "${PEACH}Брисање...${NC}"
        echo -e "${PEACH}Датотеке за брисање:${NC}"
        for file in "${@:2}"; do
            echo -e "${PEACH}󰈔 ${NC}$file${NC}"
        done
        echo
        read -p "Да ли желите да наставите са брисањем? (Y/n): " answer
        if [[ "$answer" =~ ^[Nn]$ ]]; then
            echo -e "${RED}Брисање је отказано.${NC}"
            exit 0
        fi
        for file in "${@:2}"; do
            echo -e "${PEACH}$file${NC}:"
            result=$(curl -F "reqtype=deletefiles" $CURL_ADD -F "files=$file" $CATBOX_HOST)
            check_error "Брисање није успело"
            echo -e "${GREEN}Успешно обрисано${NC}"
        done
        ;;
    "album")
        if [ -z "$USER_HASH" ]; then
            echo -e "${RED}Потребан је кориснички хеш за рад са албумима!${NC}"
            exit 1
        fi
        case "$2" in
            "create")
                if [ -z "$4" ]; then
                    echo -e "${RED}Потребни су наслов и опис албума!${NC}"
                    exit 1
                fi
                echo -e "${PEACH}Креирање албума...${NC}"
                files="${@:5}"
                result=$(curl -F "reqtype=createalbum" $CURL_ADD -F "title=$3" -F "desc=$4" -F "files=$files" $CATBOX_HOST)
                check_error "Креирање албума није успело"
                echo -e "Албум креиран: ${GREEN}$result${NC}"
                echo -n "$result" | xclip -selection clipboard
                ;;
            *)
                echo -e "${RED}Непозната команда за албум${NC}"
                exit 1
                ;;
        esac
        ;;
    *)
        echo -e "${RED}Непозната команда. Користите --help за помоћ.${NC}"
        echo -e "${RED}Пример:${NC} ./catbox.sh file dokument.pdf"
        exit 1
        ;;
esac
