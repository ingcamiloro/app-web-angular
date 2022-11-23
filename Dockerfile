#Build Steps
FROM node:19.1.0 as build

RUN mkdir /app
WORKDIR /app

COPY package.json /app
RUN npm install -g @angular/cli
RUN npm install
COPY . /app
RUN npm run build

#Run Steps
FROM nginxinc/nginx-unprivileged  
COPY --from=build-step /app/dist/app-web-angular /usr/share/nginx/html
