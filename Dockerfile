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
FROM nginx:1.15
#Copy ci-dashboard-dist
COPY --from=build-stage /app/dist/out/ /usr/share/nginx/html
#Copy default nginx configuration
COPY ./nginx-custom.conf /etc/nginx/conf.d/default.conf
COPY --from=build-step /app/dist/app-web-angular /usr/share/nginx/html
