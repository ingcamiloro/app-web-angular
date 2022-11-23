#Build Steps
FROM node:19-alpine3.15 as build-step

RUN mkdir /app
WORKDIR /app
RUN npm install -g @angular/cli
COPY package.json /app
RUN npm install
COPY . /app

RUN npm run build

#Run Steps
FROM nginxinc/nginx-unprivileged  
COPY --from=build-step /app/dist/app-web-angular /usr/share/nginx/html
COPY ["nginx.conf", "/etc/nginx/conf.d/default.conf"]
EXPOSE 8081:8081
CMD ["nginx", "-g", "daemon off;"]
