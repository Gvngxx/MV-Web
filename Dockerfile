FROM golang:bullseye AS easy-novnc-build
WORKDIR /src
RUN go mod init build && \
    go get github.com/geek1011/easy-novnc@v1.1.0 && \
    go build -o /bin/easy-novnc github.com/geek1011/easy-novnc

FROM ubuntu:focal
ENV DEBIAN_FRONTEND=noninteractive 

# Install base packages
RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
    openbox tint2 xdg-utils xterm hsetroot \
    tigervnc-standalone-server supervisor sudo \
    dbus-x11 && \
    rm -rf /var/lib/apt/lists

# Install applications
RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
    neovim firefox htop neofetch \
    wget curl git ca-certificates \
    galculator mplayer dolphin feh \
    openjdk-21-jdk openjdk-8-jdk \
    python3 python3-pip \
    tar gzip bzip2 zip unzip && \
    rm -rf /var/lib/apt/lists

# Copy easy-novnc binary and custom files
COPY --from=easy-novnc-build /bin/easy-novnc /usr/local/bin/
COPY intro.html /usr/local/share/
COPY novnc-proxy.py /usr/local/bin/
COPY supervisord.docker.conf /etc/supervisor/conf.d/supervisord.conf
RUN chmod +x /usr/local/bin/novnc-proxy.py

# Create user with home directory and sudo access
RUN useradd -m -s /bin/bash -G sudo user && \
    echo 'user:linuxx' | chpasswd && \
    mkdir -p /home/user && \
    chown -R user:user /home/user

# Copy configuration files
COPY menu.xml /etc/xdg/openbox/
COPY rc.xml /etc/xdg/openbox/
RUN mkdir -p /root/.config/tint2 /home/user/.config/tint2 /etc/xdg/openbox
COPY tint2rc /root/.config/tint2/
COPY tint2rc /home/user/.config/tint2/
COPY autostart.sh /etc/xdg/openbox/autostart

# Make scripts executable
RUN chmod +x /etc/xdg/openbox/autostart && \
    chown -R user:user /home/user/.config

# Set up Java environment
ENV JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64
ENV PATH=$JAVA_HOME/bin:$PATH

# Firefox preferences
RUN mkdir -p /etc/firefox && \
    echo 'pref("browser.tabs.remote.autostart", false);' >> /etc/firefox/syspref.js

# Set default wallpaper
RUN echo 'hsetroot -solid "#2c3e50" &' >> /etc/xdg/openbox/autostart

EXPOSE 5000
WORKDIR /home/user
USER root
ENTRYPOINT ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
