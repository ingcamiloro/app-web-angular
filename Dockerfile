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
FROM nginx:1.23.2  
COPY nginx/ /etc/nginx/conf.d/
COPY --from=build-step /app/dist/app-web-angular /usr/share/nginx/html
EXPOSE 8080:8080
CMD ["nginx", "-g", "daemon off;"]
