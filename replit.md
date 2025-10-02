# noVNC Desktop en Replit

## Descripción del Proyecto
Este es un entorno de escritorio Ubuntu completo que se ejecuta en tu navegador usando noVNC. Puedes ejecutar aplicaciones gráficas, programar en Java y Python, y personalizar tu entorno de escritorio.

## Características Instaladas

### Lenguajes de Programación
- **Python 3.11** - Intérprete Python incluido
- **Java 21** - JDK 21 instalado y configurado
- **Java 8** - JDK 8 disponible

### Aplicaciones Instaladas
- **Firefox** - Navegador web
- **Terminales**: LXTerminal, Terminator, XTerm
- **NeoVim** - Editor de texto avanzado
- **Htop** - Monitor del sistema
- **Neofetch** - Información del sistema
- **Git, wget, curl** - Herramientas de desarrollo

### Herramientas de Sistema
- **Gestor de ventanas**: Openbox (ligero y personalizable)
- **Panel**: Tint2
- **Gestor de fondos**: feh + hsetroot

## Cómo Usar

1. **Conectarse al Escritorio**: 
   - Cuando abras el proyecto, verás una pantalla con un botón "Connect"
   - Haz clic en "Connect" para acceder al escritorio VNC

2. **Acceder al Menú de Aplicaciones**:
   - Haz clic derecho en cualquier lugar del escritorio
   - Verás el menú con todas las aplicaciones organizadas por categorías

3. **Abrir una Terminal**:
   - Menú → Terminales → LXTerminal (o la que prefieras)

4. **Ejecutar Java**:
   - Abre una terminal
   - Escribe `java -version` para verificar Java 21
   - El JAVA_HOME está configurado automáticamente

5. **Ejecutar Python**:
   - Abre una terminal
   - Escribe `python` o `python3`

## Personalización

### Cambiar el Fondo de Pantalla
```bash
# En una terminal, ejecuta:
feh --bg-scale /ruta/a/tu/imagen.jpg
```

### Ventanas Centradas
Las aplicaciones se configuraron para abrirse siempre en el centro de la pantalla automáticamente.

## Arquitectura Técnica

### Componentes
- **Xvnc**: Servidor VNC (puerto 5900)
- **easy-novnc**: Cliente noVNC web (puerto 5000)
- **Openbox**: Gestor de ventanas
- **Supervisor**: Gestor de procesos

### Archivos de Configuración
- `supervisord.conf` - Configuración de servicios
- `rc.xml` - Configuración de Openbox (centrado de ventanas, temas)
- `menu.xml` - Menú de aplicaciones personalizado
- `tint2rc` - Configuración del panel
- `autostart.sh` - Script de inicio automático
- `setup_environment.sh` - Script de configuración del entorno

## Notas
- Este proyecto está optimizado para funcionar en el entorno Replit
- El escritorio se redimensiona automáticamente al tamaño de tu ventana del navegador
- Puedes instalar más aplicaciones usando los gestores de paquetes (pip para Python, etc.)

## Estado Actual
✅ Todos los servicios funcionando correctamente
✅ Escritorio VNC accesible en puerto 5000
✅ Java, Python y todas las aplicaciones instaladas
✅ Menú personalizado en español
✅ Ventanas configuradas para abrirse centradas
✅ Fondo personalizable
