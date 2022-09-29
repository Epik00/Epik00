#!/bin/bash

######Ajustes#####
#Directorios (No se recomienda usar fuera de /tmp/)
Dir_log=/tmp/.asks.txt
Dir_iplist=/tmp/.alwip.txt
Dir_pidlist=/tmp/.alwpid.txt

#Altamente Recomendable
Excluir_servidor=true
##################
rm $Dir_log 2>/dev/null


verde="\033[32m"
normal="\033[0;39m"
echo
echo
echo -e $verde "AskSSH Server" $normal
echo


#Start Variables
loop=true
line=1

#Excluir servidor
 if [[ "$Excluir_servidor" = true ]]; then
  echo 254 >> $Dir_iplist
  else
  cat $Dir_iplist | grep -v 254 > $Dir_iplist 2>/dev/null
 fi


#Loop
while [[ $loop = true ]]; do

#Info variables
 pid=$( top -b -n 1 | grep sshd | grep -v root | head -n$line | tail -1 | cut -c 1-7 | tr -d [:space:] 2>/dev/null )
 ip=$( who | grep 10.2.1. | head -n$line | tail -1 | tail -c 6 | tr -d ".() " 2>/dev/null )
 line=$(( $line + 1 ))

#Reset
 if [[ "$line" = 15 ]]; then
 line=1
 fi

#Log File Preparations
 checklogfile=$( ls -a $Dir_log 2>/dev/null)
 if [[ $Dir_log != $checklogfile  ]]; then
 touch $Dir_log
 fi
 checkipfile=$( ls -a $Dir_iplist 2>/dev/null)
 if [[ $Dir_iplist != $checkipfile  ]]; then
 touch $Dir_iplist
 fi
 checkpidfile=$( ls -a $Dir_pidlist 2>/dev/null)
 if [[ $Dir_pidlist != $checkpidfile  ]]; then
 touch $Dir_pidlist
 fi
 #Log Creation
 ipx=$(cat $Dir_log | grep "$pid" | grep -o "$ip" | head -n1 2>/dev/null )
 if [[ $ipx != $ip ]]; then
 echo "$ip                $pid" >> $Dir_log
 fi

#IP

whitelist=$( cat $Dir_iplist | grep -o $ip 2>/dev/null )

if [[ $whitelist = $ip ]]; then
kill -CONT $pid 2>/dev/null
else

#PID
getpid=$( cat $Dir_pidlist | grep $pid | grep -o $pid | tr -d [:space:] 2>/dev/null )
if [[ "$getpid" == "$pid" ]]; then
kill -CONT $pid 2>/dev/null
else
kill -STOP $pid 2>/dev/null
fi
fi

#DE CHILL
sleep 0.2
done

