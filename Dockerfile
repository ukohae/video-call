# base image from Docker Hub
FROM node:14

# create app directory
WORKDIR /app

# install app dependencies
COPY [ "package.json", "package-lock.json*"], "./"]

RUN npm init -y

RUN npm i express ejs socket.io

RUN npm i uuid

RUN npm i --save-dev nodemon

# bundle app source
COPY . .

# tell the port number the container should expose
EXPOSE 4000

# run the application
CMD [ "nodemon", "server.js" ]