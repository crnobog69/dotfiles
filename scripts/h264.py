import os
import subprocess

def convert_videos_to_h264(input_folder):
    output_folder = os.path.join(input_folder, 'h264')
    if not os.path.exists(output_folder):
        os.makedirs(output_folder)

    for filename in os.listdir(input_folder):
        file_path = os.path.join(input_folder, filename)

        if os.path.isfile(file_path) and filename.lower().endswith((".mp4", ".mkv", ".avi", ".mov", ".flv")):
            output_file = os.path.join(output_folder, os.path.splitext(filename)[0] + '_h264.mp4')

            command = [
                'ffmpeg', '-i', file_path, '-c:v', 'libx264', '-c:a', 'aac', output_file
            ]

            print(f"Processing {filename}...")
            try:
                subprocess.run(command, check=True)
                print(f"Successfully converted: {filename}")
            except subprocess.CalledProcessError as e:
                print(f"Error processing {filename}: {e}")

if __name__ == "__main__":
    input_folder = input("Унесите путању до фасцикле са видео датотекама (притисните Enter за тренутни директоријум): ").strip()
    
    if not input_folder:
        input_folder = os.path.dirname(os.path.abspath(__file__))
    
    if os.path.exists(input_folder) and os.path.isdir(input_folder):
        convert_videos_to_h264(input_folder)
    else:
        print("Неважећа путања до фасцикле!")
