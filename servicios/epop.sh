#!/bin/bash

####Epoff Module####
#Variables
Dir_principal=$(grep dir_epik00 "$HOME"/.bashrc | cut -c12-)
Config="$Dir_principal"/config.txt
bucle=bucle
Brillo_Alerta=$(grep epopbrilloalerta= "$Config" | awk '{print $2}')
Brillo_Normal=$(grep epopbrillo= "$Config" | awk '{print $2}')
display=$(grep epopdisplay= "$Config" | awk '{print $2}')

#Loop
while [[ $bucle == bucle ]]; do
  #Scanear thumbshot.py
  python3=$(pgrep thumbshot.py | grep -v grep | grep -o python3 | tail -1)

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
      p=$(pgrep thumbshot.py | grep -v grep | grep -o python3 | tail -1)
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
