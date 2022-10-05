#!/bin/bash
x=x
while [[ $x = x ]]; do
   clear

   #Colores
   verde="\033[32m"
   normal="\033[0;39m"
   rojo="\033[31m"
   azul='\033[0;34m'

   #Variables
   Dir_principal=$(cat "$HOME"/.bashrc | grep dir_epik00 | cut -c12-)
   Dir_config="$Dir_principal/config.txt"
   dir_epop="$Dir_principal/servicios/epop.sh"
   dir_hist="$Dir_principal/servicios/hist.sh"
   dir_act="$Dir_principal/servicios/act.sh"

   ##Epop
   pid_epop=$(top -b -n 1 | grep epop.sh | head -n1 | awk '{print $1}' | tr -d "[:space:]")
   name_epop=$(top -b -n 1 | grep epop.sh | head -n1 | rev | awk '{print $1}' | rev | tr -d "[:space:]")
   start_epop=$(cat "$Dir_config" | grep startepop= | awk '{print $2}' | tr -d "[:space:]")
   if [[ $name_epop = "epop.sh" ]]; then
      status_epop_m="  Activo"
      status_epop=$(echo -e "$verde" "  Activo" "$normal")
   else
      status_epop_m="InActivo"
      status_epop=$(echo -e "$rojo" "InActivo" "$normal")
   fi
   if [[ $start_epop = "true" ]]; then
      start_epop_h=$(echo -e "$verde" "Activado   " "$normal")
   else
      start_epop_h=$(echo -e "$rojo" "Desactivado" "$normal")
   fi
   if [[ $pid_epop = "" ]]; then
      pid_epop="    "
   fi

   ##Hist
   pid_hist=$(top -b -n 1 | grep hist.sh | head -n1 | awk '{print $1}' | tr -d "[:space:]")
   name_hist=$(top -b -n 1 | grep hist.sh | head -n1 | rev | awk '{print $1}' | rev | tr -d "[:space:]")
   start_hist=$(cat "$Dir_config" | grep starthistorial= | awk '{print $2}' | tr -d "[:space:]")
   if [[ $name_hist = "hist.sh" ]]; then
      status_hist=$(echo -e "$verde" "  Activo" "$normal")
      status_hist_m="  Activo"
   else
      status_hist_m="InActivo"
      status_hist=$(echo -e "$rojo" "InActivo" "$normal")
   fi
   if [[ $start_hist = "true" ]]; then
      start_hist_h=$(echo -e "$verde" "Activado   " "$normal")
   else
      start_hist_h=$(echo -e "$rojo" "Desactivado" "$normal")
   fi
   if [[ $pid_hist = "" ]]; then
      pid_hist="    "
   fi
   ##Actualizador
   pid_act=$(top -b -n 1 | grep act.sh | head -n1 | awk '{print $1}' | tr -d "[:space:]")
   name_act=$(top -b -n 1 | grep act.sh | head -n1 | rev | awk '{print $1}' | rev | tr -d "[:space:]")
   start_act=$(cat "$Dir_config" | grep act00= | awk '{print $2}' | tr -d "[:space:]")
   if [[ $name_act = "act.sh" ]]; then
      status_act=$(echo -e "$verde" "  Activo" "$normal")
      status_act_m="  Activo"
   else
      status_act=$(echo -e "$rojo" "InActivo" "$normal")
      status_act_m="InActivo"
   fi
   if [[ $start_act = "true" ]]; then
      start_act_h=$(echo -e "$verde" "Activado   " "$normal")
   else
      start_act_h=$(echo -e "$rojo" "Desactivado" "$normal")
   fi
   if [[ $pid_act = "" ]]; then
      pid_act="   "
   fi

   ##Lista
   echo
   echo -e "$azul" "  #####   #####   #    #   #    ###     ###" "$normal"
   echo -e "$azul" "  #       #   #   #    #  #    #   #   #   #" "$normal"
   echo -e "$azul" "  #####   #####   #    ###     #   #   #   #" "$normal"
   echo -e "$azul" "  #       #       #    #  #    #   #   #   #" "$normal"
   echo -e "$azul" "  #####   #       #    #   #    ###     ###" "$normal"
   echo
   echo " Num   Procesos   Estado      Inicio           Pid"
   echo
   printf "  1)   epop.sh  "
   printf "$status_epop  "
   printf "$start_epop_h     "
   printf "$pid_epop"
   echo
   printf "  2)   hist.sh  "
   printf "$status_hist  "
   printf "$start_hist_h     "
   printf "$pid_hist"
   echo
   printf "  3)   act.sh   "
   printf "$status_act  "
   printf "$start_act_h     "
   printf "$pid_act"
   echo
   printf "  0)   Salir"
   #Input
   echo
   echo
   echo -n " Menu: "
   read -r menu_principal
   echo

   if [[ $menu_principal = 0 ]]; then
      clear
      exit
   fi

   #Epop
   if [[ $menu_principal = 1 ]]; then

      if [[ $status_epop_m = "  Activo" ]]; then
         echo "  1)" Apagar
         if [[ $start_epop = true ]]; then
            echo "  2)" Desactivar AutoInicio
            echo "  3)" Cancelar
            echo
            echo -n "Menu: "
            read -r ep1

            if [[ $ep1 = 1 ]]; then
               pkill epop.sh
            fi

            if [[ $ep1 = 2 ]]; then
               sed -i 's/startepop=( true )/startepop=( false )/' "$Dir_config"
            fi

         else

            echo "  2)" Activar AutoInicio
            echo "  0)" Cancelar
            echo
            echo -n "Menu: "
            read -r ep1

            if [[ $ep1 = 1 ]]; then
               pkill epop.sh
            fi

            if [[ $ep1 = 2 ]]; then
               sed -i 's/startepop=( false )/startepop=( true )/' "$Dir_config"
            fi

         fi

      else

         if [[ $status_epop_m = "InActivo" ]]; then
            echo "  1)" Encender
            if [[ $start_epop = false ]]; then
               echo "  2)" Activar AutoInicio
               echo "  0)" Cancelar
               echo
               echo -n "Menu: "
               read -r ep1

               if [[ $ep1 = 1 ]]; then
                  $dir_epop &
               fi

               if [[ $ep1 = 2 ]]; then
                  sed -i 's/startepop=( false )/startepop=( true )/' "$Dir_config"
               fi

            else

               echo " 2)" Desactivar AutoInicio
               echo " 0)" Cancelar
               echo
               echo -n "Menu: "
               read -r ep1
               if [[ $ep1 = 1 ]]; then
                  $dir_epop &
               fi

               if [[ $ep1 = 2 ]]; then
                  sed -i 's/startepop=( true )/startepop=( false )/' "$Dir_config"
               fi

            fi
         fi
      fi

   fi

   #Hist
   if [[ $menu_principal = 2 ]]; then

      if [[ $status_hist_m = "  Activo" ]]; then
         echo " 1)" Apagar
         if [[ $start_hist = true ]]; then
            echo " 2)" Desactivar AutoInicio
            echo " 0)" Cancelar
            echo
            echo -n "Menu: "
            read -r ep1

            if [[ $ep1 = 1 ]]; then
               pkill hist.sh
            fi

            if [[ $ep1 = 2 ]]; then
               sed -i 's/starthistorial=( true )/starthistorial=( false )/' "$Dir_config"
            fi

         else

            echo " 2)" Activar AutoInicio
            echo " 0)" Cancelar
            echo
            echo -n "Menu: "
            read -r ep1

            if [[ $ep1 = 1 ]]; then
               pkill hist.sh
            fi

            if [[ $ep1 = 2 ]]; then
               sed -i 's/starthistorial=( false )/starthistorial=( true )/' "$Dir_config"
            fi

         fi


      else

         if [[ $status_hist_m = "InActivo" ]]; then
            echo " 1)" Encender
            if [[ $start_hist = false ]]; then
               echo " 2)" Activar AutoInicio
               echo " 0)" Cancelar
               echo
               echo -n "Menu: "
               read -r ep1

               if [[ $ep1 = 1 ]]; then
                  $dir_hist &
               fi

               if [[ $ep1 = 2 ]]; then
                  sed -i 's/starthistorial=( false )/starthistorial=( true )/' "$Dir_config"
               fi

            else

               echo " 2)" Desactivar AutoInicio
               echo " 0)" Cancelar
               echo
               echo -n "Menu: "
               read -r ep1
               if [[ $ep1 = 1 ]]; then
                  $dir_hist &
               fi

               if [[ $ep1 = 2 ]]; then
                  sed -i 's/starthistorial=( true )/starthistorial=( false )/' "$Dir_config"
               fi

            fi
         fi
      fi

   fi

   #ACT
   if [[ $menu_principal = 3 ]]; then

      if [[ $status_act_m = "  Activo" ]]; then
         echo " 1)" Apagar
         if [[ $start_act = true ]]; then
            echo " 2)" Desactivar AutoInicio
            echo " 0)" Cancelar
            echo
            echo -n "Menu: "
            read -r ep1

            if [[ $ep1 = 1 ]]; then
               pkill act.sh
            fi

            if [[ $ep1 = 2 ]]; then
               sed -i 's/act00=( true )/act00=( false )/' "$Dir_config"
            fi

         else

            echo " 2)" Activar AutoInicio
            echo " 0)" Cancelar
            echo
            echo -n "Menu: "
            read -r ep1

            if [[ $ep1 = 1 ]]; then
               pkill act.sh
            fi

            if [[ $ep1 = 2 ]]; then
               sed -i 's/act00=( false )/act00=( true )/' "$Dir_config"
            fi

         fi

      else

         if [[ $status_act_m = "InActivo" ]]; then
            echo " 1)" Encender
            if [[ $start_act = false ]]; then
               echo " 2)" Activar AutoInicio
               echo " 0)" Cancelar
               echo
               echo -n "Menu: "
               read -r ep1

               if [[ $ep1 = 1 ]]; then
                  $dir_act &
                  clear
               fi

               if [[ $ep1 = 2 ]]; then
                  sed -i 's/act00=( false )/act00=( true )/' "$Dir_config"
               fi

            else

               echo " 2)" Desactivar AutoInicio
               echo " 0)" Cancelar
               echo
               echo -n "Menu: "
               read -r ep1
               if [[ $ep1 = 1 ]]; then
                  $dir_act &
                  clear
               fi

               if [[ $ep1 = 2 ]]; then
                  sed -i 's/act00=( true )/act00=( false )/' "$Dir_config"
               fi

            fi
         fi
      fi

   fi

   clear
done
