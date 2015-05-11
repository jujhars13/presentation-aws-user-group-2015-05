#dockerfile

#using official node repo which is based on debian:jessie
FROM node:0.12.2-slim
MAINTAINER Jujhar Singh <jujhar@jujhar.com>

ADD demo /app

#set environment variables
ENV NOE_ENV development
ENV LOG_FILE_PATH /var/log
ENV NODE_PORT 8080

#this is the root folder we'll work from
WORKDIR /app

#RUN ["/bin/bash"]

#run our script
ENTRYPOINT ["node","index.js"]
