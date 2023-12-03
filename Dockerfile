# ----------------------------
# build from source
# ----------------------------
FROM node:18 AS build

WORKDIR /angular-app

COPY package*.json .

#install all application dependencies
RUN npm i

RUN npm install -g @angular/cli

#add curl
#RUN apk update && apk add curl

COPY . .
RUN npm run build

# ----------------------------
# run with nginx
# ----------------------------
FROM nginx

#RUN rm /etc/nginx/conf.d/default.conf
#COPY /nginx.conf  /etc/nginx/conf.d/default.conf
COPY --from=build /angular-app/dist/app1/browser /usr/share/nginx/html
COPY /nginx.conf /etc/nginx/conf.d
RUN rm /etc/nginx/conf.d/default.conf

#Expose the application container on port
EXPOSE 80

#CMD ng serve --host 0.0.0.0 --port 4200
