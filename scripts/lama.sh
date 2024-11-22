#!/bin/bash

# Add color variables at the top
PEACH='\033[38;2;250;183;135m'
LAVENDER='\033[38;2;180;191;254m'
RED='\033[0;31m'
RESET='\033[0m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# Function to check if Ollama is running
check_ollama_status() {
  if pgrep -x "ollama" >/dev/null; then
    return 0 # Running
  else
    return 1 # Not running
  fi
}

# Function to display status with color
show_status() {
  if check_ollama_status; then
    echo -e "\033[0;32mОлама је покренута\033[0m"
  else
    echo -e "\033[0;31mОлама није покренута\033[0m"
  fi
}

# Function to start Ollama
start_ollama() {
  if check_ollama_status; then
    echo -e "\033[0;31mОлама је већ покренута\033[0m"
  else
    PEACH='\033[38;2;250;183;135m'
    LAVENDER='\033[38;2;180;191;254m'
    RED='\033[0;31m'
    RESET='\033[0m'
    echo -e "${PEACH}Изаберите модел:${RESET}"
    echo
    echo -e "${RED}1)${RESET} ${LAVENDER}dolphin-llama3${RESET}"
    echo -e "${RED}2)${RESET} ${LAVENDER}qwen2.5-coder:1.5b${RESET}"
    echo
    read -p $'\033[38;2;250;183;135mУнесите број (1-2): \033[0m' model_choice

    case $model_choice in
    1)
      MODEL="dolphin-llama3"
      ;;
    2)
      MODEL="qwen2.5-coder:1.5b"
      ;;
    *)
      echo -e "\033[0;31mНеисправан избор. Прекидам...\033[0m"
      return 1
      ;;
    esac

    echo "Покретање Оламе..."
    sudo systemctl start ollama.service
    sleep 2

    if check_ollama_status; then
      echo "Покретање модела $MODEL..."
      ollama run $MODEL
    else
      echo -e "\033[0;31mНеуспешно покретање Оламе\033[0m"
    fi
  fi
}

# Function to stop Ollama
stop_ollama() {
  if check_ollama_status; then
    echo "Заустављање Оламе..."
    sudo killall ollama
    sudo systemctl stop ollama.service
    sleep 2
    if ! check_ollama_status; then
      echo -e "\033[0;32mОлама је успешно заустављена\033[0m"
    else
      echo -e "\033[0;31mНеуспешно заустављање Оламе\033[0m"
    fi
  else
    echo -e "\033[0;31mОлама није покренута\033[0m"
  fi
}

# Function to restart Ollama
restart_ollama() {
  echo "Поновно покретање Оламе..."
  stop_ollama
  sleep 2
  start_ollama
}

# Function to list available models
list_models() {
  if check_ollama_status; then
    echo "Доступни модели:"
    ollama list
  else
    echo -e "\033[0;31mОлама мора бити покренута да би се приказали модели\033[0m"
  fi
}

# Add help function
show_help() {
  echo "==================================================================="
  echo
  echo -e "${PEACH}     лама | lama - скрипта за контролу Оламе${NC}"
  echo
  echo -e "${LAVENDER}Употреба:${NC} ${YELLOW}./lama.sh${NC} ${PEACH}[команда]${NC} ${RED}[опција]${NC}"
  echo
  echo "==================================================================="
  echo
  echo -e "${LAVENDER}Команде:${NC}"
  echo
  echo -e "  ${PEACH}start${NC}    Покрени Оламу"
  echo -e "           ${RED}  1${NC}) ${LAVENDER}llama2-uncensored${NC}"
  echo -e "           ${RED}  2${NC}) ${LAVENDER}qwen2.5-coder:1.5b${NC}"
  echo -e "  ${PEACH}stop${NC}     Заустави Оламу"
  echo -e "  ${PEACH}restart${NC}  Поново покрени Оламу"
  echo -e "  ${PEACH}status${NC}   Прикажи статус Оламе"
  echo -e "  ${PEACH}list${NC}     Прикажи доступне моделе"
  echo
  echo "==================================================================="
  exit 0
}

# Update the usage sections to use show_help
if [ $# -eq 0 ]; then
  show_help
fi

# Process command line arguments
case "$1" in
start)
  if [ -n "$2" ]; then
    case "$2" in
    1)
      MODEL="dolphin-llama3"
      if check_ollama_status; then
        echo -e "${PEACH}Олама је већ покренута${RESET}"
      else
        echo -e "${PEACH}Покретање Оламе са моделом ${LAVENDER}$MODEL${RESET}..."
        sudo systemctl start ollama.service
        sleep 2
        if check_ollama_status; then
          ollama run $MODEL
        else
          echo -e "${PEACH}Неуспешно покретање Оламе${RESET}"
        fi
      fi
      ;;
    2)
      MODEL="qwen2.5-coder:1.5b"
      if check_ollama_status; then
        echo -e "${PEACH}Олама је већ покренута${RESET}"
      else
        echo -e "${PEACH}Покретање Оламе са моделом ${LAVENDER}$MODEL${RESET}..."
        sudo systemctl start ollama.service
        sleep 2
        if check_ollama_status; then
          ollama run $MODEL
        else
          echo -e "${PEACH}Неуспешно покретање Оламе${RESET}"
        fi
      fi
      ;;
    *)
      start_ollama
      ;;
    esac
  else
    start_ollama
  fi
  ;;
stop)
  stop_ollama
  ;;
restart)
  restart_ollama
  ;;
status)
  show_status
  ;;
list)
  list_models
  ;;
*)
  show_help
  ;;
esac

exit 0

