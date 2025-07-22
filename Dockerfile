FROM node:lts-buster

# Fix for Debian Buster EOL by using archive repositories
RUN sed -i 's|http://deb.debian.org/debian|http://archive.debian.org/debian|g' /etc/apt/sources.list && \
    sed -i '/security.debian.org/d' /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y \
    ffmpeg \
    imagemagick \
    webp && \
    apt-get upgrade -y && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/app
COPY package.json .
RUN npm install && npm install -g qrcode-terminal pm2
COPY . .
EXPOSE 5000
CMD ["npm", "start"]
