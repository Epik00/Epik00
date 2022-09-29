#!/bin/bash
verde="\033[32m"
normal="\033[0;39m"
rojo="\033[31m"
ifon=$(top -b -n 1 | grep -o asks.sh)



#Directorios (No se recomienda usar fuera de /tmp/)
Dir_log=$(cat ~/.epk/asks.sh | grep Dir_log | head -n1 | cut -c 9-100 | tr -d [:space:])
Dir_iplist=$(cat ~/.epk/asks.sh | grep Dir_iplist | head -n1 | cut -c 12-100 | tr -d [:space:])
Dir_pidlist=$(cat ~/.epk/asks.sh | grep Dir_pidlist | head -n1 | cut -c 13-100 | tr -d [:space:])


dir1=$(ls -a $Dir_log 2>/dev/null)
dir2=$(ls -a $Dir_iplist 2>/dev/null)
dir3=$(ls -a $Dir_pidlist 2>/dev/null)

if [[ $dir1 != $Dir_log ]]; then
echo
echo -e $rojo "Debes tener AskSSH en ejecucion para usar este comando" $normal
echo
echo 1 Iniciar ArkSSH
echo 2 Cerrar
read error
fi
if [[ $error = 1 ]]; then
~/.epk/asks.sh &
exit
fi
if [[ $dir2 != $Dir_iplist ]]; then
echo
echo -e $rojo "Debes tener AskSSH en ejecucion para usar este comando" $normal
echo
echo 1 Iniciar ArkSSH
echo 2 Cerrar
read error
fi
if [[ $error = 1 ]]; then
~/.epk/asks.sh &
exit
fi
if [[ $dir3 != $Dir_pidlist ]]; then
echo
echo -e $rojo "Debes tener AskSSH en ejecucion para usar este comando" $normal
echo
echo 1 Iniciar ArkSSH
echo 2 Cerrar
read error
if [[ $error = 1 ]]; then
~/.epk/asks.sh &
exit
fi
fi
echo -e $verde "Bienvenido a AskSSH" $normal

echo
echo 1 Encender AskSSH
echo 2 Permitir una conexion
echo 3 Quitar permiso de conexion
echo 4 Encender SSH
echo 5 Apagar SSH
echo 6 Eliminar cache
echo 0 Salir
echo -n "Menu: "
read type

if [[ $type = 1 ]]; then
pkill asks.sh
~/.epk/asks.sh &
exit
fi


if [[ $type = 2 ]]; then
echo ;echo  "Pulse el numero para permitir conexion"; echo
echo -e $verde "       IP                  PID" $normal
cat -n $Dir_log
echo "     0 Cancelar"
echo -n "Selecciona una session: "
read num

if [[ $num = 0 ]]; then
exit
fi

seleccion=$(cat $Dir_log | head -n$num | tail -1)
echo -e $verde "IP                PID" $normal
cat $Dir_log | head -n$num | tail -1
echo
echo "     1 Permitir IP"
echo "     2 Permitir PID"
echo "     0 Cancelar"
echo
echo -n "Selecciona una opcion: "

read entrada
echo
fi

if [[ $entrada = 1 ]]; then
ip=$(cat $Dir_log | head -n$num | tail -1 | cut -c 1-3)
echo $ip >> $Dir_iplist
fi
if [[ $entrada = 2 ]]; then
pid=$(cat $Dir_log | head -n$num | tail -1 | tail -c 10 | tr -d [:space:])
echo $pid >> $Dir_pidlist
fi

if [[ $type = 3 ]]; then
echo
echo "IP"
cat $Dir_iplist
echo
echo "PID"
cat $Dir_pidlist
echo
echo
echo 1 Quitar IP
echo 2 Quitar PID
echo 0 Cancelar
echo
read -s entrada2
fi

if [[ $entrada2 = 1 ]]; then
echo -e $verde "       IP" $normal
cat -n $Dir_iplist
echo
echo -n "Selecciona una opcion: "
read num2
ip2=$(cat $Dir_iplist | head -n$num2 | tail -1)
del_ip2=$(cat $Dir_iplist | grep -v "$ip2")
cat "$del_ip" > $Dir_iplist 2>/dev/null
fi


if [[ $entrada2 = 2 ]]; then
echo -e $verde "       PID" $normal
cat -n $Dir_pidlist
echo
echo -n "Selecciona una opcion: "
read num3
pid2=$(cat $Dir_pidlist | head -n$num3 | tail -1 | tail -c 10 | tr -d [:space:])
del_pid2=$(cat $Dir_pidlist | grep -v "$pid2")
cat "$del_pid" > $Dir_pidlist 2>/dev/null
fi


if [[ $type = 4 ]]; then
pkill switchs.sh 2>/dev/null
fi

if [[ $type = 5 ]]; then
pkill switchs.sh 2>/dev/null
~/.epk/switchs.sh &
exit
fi

if [[ $type = 6 ]]; then
rm $Dir_log 2>/dev/null
rm $Dir_iplist 2>/dev/null
rm $Dir_pidlist 2>/dev/null
exit
fi

