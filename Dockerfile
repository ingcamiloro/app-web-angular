#Build Steps
FROM node:19-alpine3.15 as build-step

RUN mkdir /app-web-angular
WORKDIR /app-web-angular
RUN npm install -g @angular/cli
COPY package.json /app
RUN npm install
COPY . /app-web-angular

RUN npm run build

#Run Steps
FROM nginxinc/nginx-unprivileged  
COPY --from=build-step /app/dist .
