# noVNC Desktop - Docker Edition

Un entorno de escritorio Ubuntu completo accesible desde el navegador usando noVNC, optimizado para GitHub Codespaces.

## 🚀 Inicio Rápido

### Descargar el Proyecto

```bash
git clone https://github.com/prbinu/novnc-desktop.git
cd novnc-desktop
```

### Construir la Imagen Docker

```bash
docker build --squash -t prbinu/novnc-desktop -f Dockerfile .
```

> **Nota**: Si `--squash` no funciona en tu versión de Docker, puedes omitir esa opción:
> ```bash
> docker build -t prbinu/novnc-desktop -f Dockerfile .
> ```

### Ejecutar el Contenedor

```bash
docker run -p 5000:5000 -e "TZ=America/Los_Angeles" prbinu/novnc-desktop
```

O en modo detached (segundo plano):

```bash
docker run -d -p 5000:5000 --name novnc-desktop prbinu/novnc-desktop
```

### Acceder al Escritorio

Abre tu navegador y ve a: **http://localhost:5000**

Verás una animación de bienvenida tipo HackTheBox y luego se conectará automáticamente al escritorio VNC.

## 🐳 GitHub Codespaces

Si estás usando GitHub Codespaces:

1. Abre el proyecto en Codespaces
2. Ejecuta:
   ```bash
   docker build -t novnc-desktop .
   docker run -p 5000:5000 novnc-desktop
   ```
3. GitHub Codespaces te mostrará automáticamente un enlace para acceder al puerto 5000

## 📦 Aplicaciones Incluidas

- **Navegador**: Firefox
- **Terminal**: XTerm
- **Editor**: NeoVim
- **Accesorios**: Calculadora
- **Multimedia**: MPlayer
- **Gestor de Archivos**: KDE Dolphin
- **Lenguajes**: Python 3, Java 21, Java 8

## 🔒 Usuario y Permisos

- **Usuario**: `user`
- **Directorio home**: `/home/user/`
- **Comando sudo**: Contraseña: `linuxx`

## ⚙️ Configuración

### Variables de Entorno

- `TZ`: Zona horaria (default: `America/Los_Angeles`)

### Puertos

- `5000`: noVNC web interface
- `5900`: VNC server (localhost only)

## 🛠️ Desarrollo

### Personalizar el Menú

Edita `menu.xml` para modificar las aplicaciones disponibles en el menú de Openbox.

### Cambiar el Fondo

Dentro del escritorio VNC, abre XTerm y ejecuta:

```bash
feh --bg-scale /ruta/a/tu/imagen.jpg
```

## 📝 Notas

- El escritorio se redimensiona automáticamente al tamaño de tu ventana del navegador
- Las ventanas se abren centradas automáticamente
- Java está preconfigurado con JAVA_HOME

## 🐛 Solución de Problemas

Si el contenedor no inicia:

```bash
# Ver logs del contenedor
docker logs novnc-desktop

# Reiniciar el contenedor
docker restart novnc-desktop

# Eliminar y recrear
docker rm -f novnc-desktop
docker run -p 5000:5000 --name novnc-desktop prbinu/novnc-desktop
```

## 📄 Licencia

Ver archivo [LICENSE](LICENSE)
