# noVNC Desktop - Docker Edition

## Descripción del Proyecto
Entorno de escritorio Ubuntu completo accesible desde el navegador usando noVNC, optimizado para GitHub Codespaces y Docker.

## Características

### Animación de Inicio
- Animación tipo HackTheBox/PwnBox con logo de Docker
- Efecto Matrix rain en el fondo
- Transición automática al escritorio VNC después de 3 segundos
- Sistema de proxy Python que sirve la animación antes de conectar al VNC

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
- **Openbox**: Gestor de ventanas ligero con dbus-x11
- **Supervisor**: Gestor de procesos

### Archivos de Configuración

#### Para Docker (Producción)
- `Dockerfile` - Configuración de construcción de Docker
- `supervisord.docker.conf` - Configuración de servicios para Docker
- `novnc-proxy.py` - Servidor proxy que sirve intro y redirige a noVNC
- `intro.html` - Página de animación de inicio

#### Para Replit (Desarrollo)
- `supervisord.conf` - Configuración simplificada para Replit
- `.replit` - Configuración del entorno Replit

#### Compartidos
- `rc.xml` - Configuración de Openbox (centrado de ventanas)
- `menu.xml` - Menú de aplicaciones personalizado (solo apps solicitadas)
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
✅ Dockerfile configurado para GitHub Codespaces con dbus-x11
✅ Animación de inicio tipo HackTheBox con logo Docker
✅ Menú limpio con solo las apps solicitadas (sin Htop, sin System Info)
✅ Usuario configurado en /home/user/ con sudo password "linuxx"
✅ Ventanas centradas automáticamente
✅ Sistema completo de proxy para servir intro + VNC
✅ Supervisord separado para Docker y Replit

## Notas de Desarrollo
- El proyecto funciona tanto en Replit como en Docker
- Replit usa `supervisord.conf` con rutas locales
- Docker usa `supervisord.docker.conf` con rutas absolutas de sistema
- El proxy Python solo está activo en Docker (intro animation)
