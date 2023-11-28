FROM --platform=$BUILDPLATFORM node:17.0.1-bullseye-slim as builder

WORKDIR /angular-app

#install all application dependencies
RUN npm i

RUN npm install -g @angular/cli@13

#add curl
RUN apk update && apk add curl

#Copy the application dependencies from the package.json to the app working directory.
COPY package.json .

COPY package-lock.json .

#Copy the remaining application folders and files from the local src folder to the Docker app working directory
COPY . .

#Expose the application container on port
EXPOSE 4200

#The command to start the application container
#CMD ls .
#CD /angular-app
#RUN ng build
CMD ng serve --host 0.0.0.0 --port 4200
