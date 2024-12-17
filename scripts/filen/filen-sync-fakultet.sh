#!/bin/bash

while inotifywait -r -e modify,create,delete,move "/run/media/lain/VERMAHT/Факултет/"; do
    /home/lain/filen-cli sync
done
