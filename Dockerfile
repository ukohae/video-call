# base image from Docker Hub
FROM node:slim

RUN mkdir -p /user/src/app

WORKDIR /user/src/app

COPY ./package*.json ./

RUN npm init -y

RUN npm i express ejs socket.io

RUN npm i uuid

RUN npm i --save-dev nodemon

COPY . ./

EXPOSE 3000
# ENTRYPOINT ["node", "nodemon server.js"]
ENTRYPOINT ["npm", "start"]
