#!/bin/bash

#Directorios (No se recomienda usar fuera de /tmp/)
 Dir_log=$(cat ~/.epk/asks.sh | grep Dir_log | head -n1 | cut -c 9-100 | tr -d [:space:])
 Dir_iplist=$(cat ~/.epk/asks.sh | grep Dir_iplist | head -n1 | cut -c 12-100 | tr -d [:space:])
 Dir_pidlist=$(cat ~/.epk/asks.sh | grep Dir_pidlist | head -n1 | cut -c 13-100 | tr -d [:space:])

 loop=true
 line=1
 excluir_servidor=true
#Loop
while [[ $loop = true ]]; do

#Info variables
 pid=$( top -b -n 1 | grep sshd | grep -v root | head -n$line | tail -1 | cut -c 1-7 | tr -d [:space:] 2>/dev/null )
 line=$(( $line + 1 ))
 ifip=cat $Dir_log | grep $pid | head -n1 | cut -c 1-5 | tr -d [:space:]
if [[ $excluir_servidor = true ]]; then
if [[ $ifip != 254 ]]; then
#Kill
kill -CONT $pid 2>/dev/null
kill $pid 2>/dev/null

fi
else
#Kill
kill -CONT $pid 2>/dev/null
kill $pid 2>/dev/null

fi
#Reset
if [[ "$line" = 20 ]]; then
 line=1
fi
done
