#!/bin/bash

#Variables
dir_bashrc="$HOME/.bashrc"
dir_epik00=$(pwd | rev | cut -c10- | rev)
dir_pass="$dir_epik00/comandos/pass.sh"
dir_act00="$dir_epik00/servicios/act.sh"
dir_epop="$dir_epik00/servicios/epop.sh"
dir_hist="$dir_epik00/servicios/hist.sh"
dir_epik00sh="$dir_epik00/comandos/epik00.sh"
dir_epck="$dir_epik00/comandos/epck.sh"
dir_epon="$dir_epik00/comandos/epon.sh"
dir_epoff="$dir_epik00/comandos/epoff.sh"
dir_unlog="$dir_epik00/comandos/unlog.sh"
dir_god="$dir_epik00/comandos/god.sh"
existe_bashrc=$(find ~/.bashrc 2>/dev/null)
#Si no existe .bashrc se crea
if [[ $existe_bashrc != ".bashrc" ]]; then
    touch ~/.bashrc
fi

# Generacion de alias
lineaini=$(cat -n "$dir_bashrc" | grep "#Epik00 Aliases" | head -n1 | awk '{print $1}')
lineaini2=$(("$lineaini" - 1))
lineafin=$(cat -n "$dir_bashrc" | tail -1 | awk '{print $1}')
sed -i "$lineaini2","$lineafin""d" "$dir_bashrc" 2>/dev/null

#Crear nuevo sed para cada variable
sed -i '/alias pass/d' "$dir_bashrc"
sed -i '/dir_epik00/d' "$dir_bashrc"
sed -i '/act00/d' "$dir_bashrc"
sed -i '/epop/d' "$dir_bashrc"
sed -i '/hist/d' "$dir_bashrc"
sed -i '/epik00/d' "$dir_bashrc"
sed -i '/epck/d' "$dir_bashrc"
sed -i '/epon/d' "$dir_bashrc"
sed -i '/epoff/d' "$dir_bashrc"
sed -i '/unlog/d' "$dir_bashrc"

#Añadir aqui cada variable
{
    echo
    echo "#Epik00 Aliases"
    echo "dir_epik00=$dir_epik00"
    echo "alias pass='$dir_pass'"
    echo "alias act00='pkill act.sh; $dir_act00 & exit ; konsole -e 'epik00' "
    echo "alias epop='pkill epop.sh; $dir_epop &'"
    echo "alias hist='pkill hist.sh; $dir_hist &'"
    echo "alias epik00='$dir_epik00sh'"
    echo "alias epck='$dir_epck'"
    echo "alias epon='$dir_epon'"
    echo "alias epoff='$dir_epoff'"
    echo "alias unlog='$dir_unlog'"
    echo "alias god='$dir_god'"

} >>"$dir_bashrc"
exec bash

