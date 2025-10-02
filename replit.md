# noVNC Desktop - Docker Edition

## Descripción del Proyecto
Entorno de escritorio Ubuntu completo accesible desde el navegador usando noVNC, optimizado para GitHub Codespaces y Docker.

## Características

### Animación de Inicio
- Animación tipo HackTheBox/PwnBox con logo de Docker
- Efecto Matrix rain en el fondo
- Transición automática al escritorio VNC después de 3 segundos

### Aplicaciones Instaladas
- **Internet**: Firefox
- **Terminal**: XTerm
- **Editor**: NeoVim
- **Accesorios**: Calculadora (galculator)
- **Multimedia**: MPlayer
- **Gestor de Archivos**: Dolphin (KDE)
- **Lenguajes**: Python 3, Java 21, Java 8
- **Herramientas**: Git, wget, curl, htop, neofetch

### Configuración de Usuario
- **Usuario**: `user`
- **Home**: `/home/user/`
- **Sudo password**: `linuxx`
- **Shell**: bash

## Uso en GitHub Codespaces

```bash
# Construir la imagen
docker build -t novnc-desktop .

# Ejecutar el contenedor
docker run -p 5000:5000 novnc-desktop

# Acceder en: http://localhost:5000
```

## Arquitectura Técnica

### Componentes
- **Xvnc**: Servidor VNC (puerto 5900 local)
- **easy-novnc**: Cliente noVNC web (puerto 5001 local)
- **Python Proxy**: Servidor proxy que muestra intro y redirige (puerto 5000)
- **Openbox**: Gestor de ventanas ligero
- **Supervisor**: Gestor de procesos

### Archivos de Configuración
- `Dockerfile` - Configuración de construcción de Docker
- `supervisord.conf` - Configuración de servicios
- `rc.xml` - Configuración de Openbox (centrado de ventanas)
- `menu.xml` - Menú de aplicaciones personalizado
- `intro.html` - Página de animación de inicio
- `novnc-proxy.py` - Servidor proxy que sirve intro y redirige a noVNC
- `tint2rc` - Configuración del panel
- `autostart.sh` - Script de inicio automático

## Personalización

### Cambiar Fondo
```bash
# Dentro del escritorio VNC, en XTerm:
feh --bg-scale /ruta/a/imagen.jpg
```

### Agregar Aplicaciones al Menú
Editar `menu.xml` y reconstruir la imagen Docker.

## Estado Actual
✅ Dockerfile configurado para GitHub Codespaces
✅ Animación de inicio tipo HackTheBox con logo Docker
✅ Menú limpio con solo las apps solicitadas
✅ Usuario configurado en /home/user/ con sudo
✅ Ventanas centradas automáticamente
✅ Sistema completo de proxy para servir intro + VNC
