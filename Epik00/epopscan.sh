#!/bin/bash
while true; do
    i=0
    while true; do
        #////////////////////////////////////////////////
        #Si epop esta apagado: detecta cuando se enciende
        #////////////////////////////////////////////////

        python3=$(pgrep thumbshot.py 2>/dev/null)
        if [[ -n $python3 ]]; then

            #////////////////////////////
            #Acciones cuando epop se abre
            #////////////////////////////

            export DISPLAY=:0
            qdbus org.kde.KWin /KWin setCurrentDesktop 1 >/dev/null
            output=$(xrandr | grep primary | awk '{print $1}' | tr -d "[:space:]")
            xrandr --output "$output" --brightness 1.3 2>/dev/null
            break #pasa al segundo loop (que detecta cuando se cierra ep)
        fi
        sleep 0.05
    done

    while true; do
        #///////////////////////////////////////////////
        #Si epop esta encendido; detecta cuando se apaga
        #///////////////////////////////////////////////

        python3=$(pgrep thumbshot.py 2>/dev/null)
        if [[ -n $python3 ]]; then
            i=0
            sleep 4
        fi
        if [[ $i -eq 50 ]]; then

            #//////////////////////////////
            #Acciones cuando epop se cierra
            #//////////////////////////////

            export DISPLAY=:0
            xrandr --output "$output" --brightness 1 2>/dev/null
            break #Vuelve al primer loop (que detecta cuando se abre ep)

        else
            i=$((i + 1))
            sleep 0.05
        fi
    done
done
