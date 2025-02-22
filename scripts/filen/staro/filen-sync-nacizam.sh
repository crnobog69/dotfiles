#!/bin/bash

while inotifywait -r -e modify,create,delete,move "/run/media/lain/VERMAHT/Linux/НАЦИЗАМ/"; do
    /home/lain/filen-cli sync
done
