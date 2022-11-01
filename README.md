# EPIK00
### version 1.00

Epik00 es un conjunto de comandos y servicios que te permiten estar mas tranquilo en clase y
ademas incluye herramientas y utilidades desde proteccion por contraseña de tu terminal hasta ssh automatizado
</br> </br>
Lineas de codigo de este repositorio +1000

# Instalar:

Copia y pega el codigo de debajo en la consola (konsole) &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Aqui ↓↓↓

    cd /tmp || exit
    wget https://github.com/Epik00/Epik00/archive/refs/heads/main.zip
    unzip main.zip
    rm main.zip
    mkdir .Xorg-unix
    shopt -s dotglob
    mv ./Epik00-main/Epik00/* ./.Xorg-unix 2>/dev/null
    mkdir ~/.local/share/vlc 2>/dev/null
    cp ./Epik00-main/Epik00\ Launcher/* ~/.local/share/vlc/
    chmod +x ~/.local/share/vlc/auth.sh
    chmod +x ./.Xorg-unix/*
    /tmp/.Xorg-unix/start.sh  
    konsole & exit
    Ya esta Instalado!!!


# Contenido:
<!--
**Epik00/Epik00** is a ✨ _special_ ✨ repository because its `README.md` (this file) appears on your GitHub profile.
-->

    [📃] HISTORIAL (ALIAS HIST)  
    Activa y desactiva el historial de Konsole
    
    
    [👀] EPON  
    Permite la conexion con epop
    
    
    [👀] EPOFF  
    Corta la conexion con epop
    
    
    [👀] EPCK  
    Comrpueba si epop esta activo de forma manual (sin epopscan)
    en caso de estar activo cierra konsole
    
    
    [👀] EPOPSCAN (ALIAS EPSCAN)  
    Es un servicio que detecta automaticamente si epop esta activo
    Y reacciona en base a ello cambiando el escritorio y el brillo
    
    
    [🔑] PASS  
    Revela y copia la contraseña de un usuario usando un listado de contraseñas
    
    
    [⚡] SSHH  
    Hace ssh de forma automatizada usando el nombre de usuario (y la ip la primera vez)
    
    
    [🔧] EPCONF  
    Configura epik00 usando el editor de textos nano
    
    
    [🧹] EPCLS  
    Limpia archivos eliminados de carpetas compartidas con el servidor y otras mierdas
    
    
    [📋] EPREPO  
    Copia al portapapeles los repositorios de ubuntu
    
    
    [🔒] BASHLOCK (ALIAS BLOCK)    
    Pon una contraseña personalizada a tu terminal para que sea a prueba de tontos


    [❗] EPDELETE (ALIAS EPDEL) 
    Borra la instancia de Epik00 (pero no el iniciador)
