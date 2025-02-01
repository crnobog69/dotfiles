import os

def list_files_and_dirs(directory, script_name):
    for root, dirs, files in os.walk(directory):
        print(f'## Директоријум: `{root}`')
        for dir_name in dirs:
            print(f'- **Поддиректоријум:** `{dir_name}`')
        for file_name in files:
            if file_name != script_name:
                print(f'- *Датотека:* `{file_name}`')
        print()

if __name__ == "__main__":
    putanja = os.path.abspath(os.path.dirname(__file__))  # Добија тренутни директоријум
    script_name = os.path.basename(__file__)  # Добија име скрипте
    
    print(f'# Проверавам: `{putanja}`')
    list_files_and_dirs(putanja, script_name)