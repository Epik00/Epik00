#!/bin/bash

####Epoff Module####
#Variables
Dir_principal=$(cat $HOME/.bashrc | grep dir_epik00 | cut -c12-)
Config=$(echo "$Dir_principal/config.txt" 2>/dev/null)
bucle=bucle
Brillo_Alerta=$(cat "$Config" | grep epopbrilloalerta= | awk '{print $2}')
Brillo_Normal=$(cat "$Config" | grep epopbrillo= | awk '{print $2}')
display=$(cat "$Config" | grep epopdisplay= | awk '{print $2}')

#Loop
while [[ $bucle == bucle ]]; do
  #Scanear thumbshot.py
  python3=$(ps aux | grep thumbshot.py | grep -v grep | grep -o python3 | tail -1)

  #Si es detectado entonces:
  if [[ $python3 = python3 ]]; then

    #Cambiar Escritorio
    echo a
    export DISPLAY=:0
    qdbus org.kde.KWin /KWin setCurrentDesktop "$display" 2>/dev/null

    #Y cambiar el brillo al configurado
    output=$(xrandr | grep primary | awk '{print $1}' | tr -d "[:space:]")
    xrandr --output "$output" --brightness "$Brillo_Alerta" 2>/dev/null

    ####Epon Module####

    timer=195
    epon=true
    #Loop
    while [[ $epon == true ]]; do
      #Scanear thumbshot.py
      p=$(ps aux | grep thumbshot.py | grep -v grep | grep -o python3 | tail -1)
      # Si es detectado entonces:
      if [[ $p = python3 ]]; then
        #Reiniciar cuenta atras
        timer=195
      #Sino quitar 1 punto al contador
      else
        timer=$(("$timer" - 1))
      fi
      # Si la cuenta atras acaba entonces:
      if [[ $timer -lt 1 ]]; then
        #Cambiar el brillo al Normal
        export DISPLAY=:0
        xrandr --output "$output" --brightness "$Brillo_Normal" 2>/dev/null
        #Terminar bucle
        epon=false
      fi
      #Tiempo Entre bucle (para ahorrar cpu)
      sleep 0.2

    done
  fi
  #Final del bucle#
  #Tiempo Entre bucle (para ahorrar cpu)
  sleep 0.05
done

