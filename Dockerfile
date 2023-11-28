#It will use node:19-alpine3.16 as the parent image for building the Docker image
FROM node:19-alpine3.16

#add curl
RUN apk update && apk add curl

#It will create a working directory for Docker. The Docker image will be created in this working directory.
WORKDIR /angular-app

#Copy the application dependencies from the package.json to the app working directory.
COPY package.json .

COPY package-lock.json .

#install all application dependencies
RUN npm i
RUN npm install -g @angular/cli

#Copy the remaining application folders and files from the local src folder to the Docker app working directory
COPY . .

#Expose the application container on port
EXPOSE 4200

#The command to start the application container
RUN ng build
CMD ng serve --host 0.0.0.0 --port 4200
