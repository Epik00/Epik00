#!/bin/bash
ifhtml=$( ls -a /tmp | grep .*.html | tr -d [:space:] | tail -c 4 )
if [[ $ifhtml = "html" ]]; then
rm ~/.epk/.*.html 2>/dev/null
fi
html2=$( ls -a -t /tmp | grep .*.html | head -n1 | tr -d [:space:] );
mv /tmp/$html2 ~/.epk 2>/dev/null
html=$( ls -a -t ~/.epk | grep .*.html | head -n1 | tr -d [:space:] );
if [[ $html == "" ]]; then
echo
echo Listado no encontrado
echo
exit
fi

read -p "Nombre de Usuario: " busqueda


usuario=$(cat ~/.epk/"$html" | grep "$busqueda" | tail -1)

if [[ ""$busqueda"" == ""$usuario"" ]]; then
line=$(cat ~/.epk/$html | nl | grep "$usuario" | tail -1 | cut -c 1-7 | tr -d "A-Za-z ")
passwdline=$( echo $(( $line + 2 )) )

pass=$(cat ~/.epk/$html | nl | grep "$passwdline" | head -n1 | cut -c 7-30 )
echo La contraseña es $pass
echo $pass | xclip -sel c
exit
fi


#EN MINUSCULA Y MAYUSCULA

busquedamin=$( echo "$busqueda" | tr [:upper:] [:lower:] )
busquedamay=$( echo "$busqueda" | tr [:lower:] [:upper:] )

usuariomin=$(cat ~/.epk/"$html" | grep "$busquedamin" | tail -1 | tr [:upper:] [:lower:] )
usuariomay=$(cat ~/.epk/"$html" | grep "$busquedamay" | tail -1 | tr [:lower:] [:upper:] )

if [[ ""$busquedamin"" == ""$usuariomin"" ]]; then
line=$(cat ~/.epk/$html | nl | grep "$usuariomin" | tail -1 | tr -d [:space:] | cut -c 1-3 | tr -d "A-Za-z ")
passwdline=$( echo $(( $line + 2 )) )

pass=$(cat ~/.epk/$html | nl | grep "$passwdline" | head -n1 | cut -c 7-30 )
echo La contraseña es $pass
echo $pass | xclip -sel c
exit
fi

if [[ ""$busquedamay"" == ""$usuariomay"" ]]; then
line=$(cat ~/.epk/$html | nl | grep "$usuariomay" | tail -1 | tr -d [:space:] | cut -c 1-3 | tr -d "A-Za-z ")
passwdline=$( echo $(( $line + 2 )) )

pass=$(cat ~/.epk/$html | nl | grep "$passwdline" | head -n1 | cut -c 7-30 )
echo La contraseña es $pass
echo $pass | xclip -sel c
exit
fi


echo
echo Usuario no encontrado
echo
exit
