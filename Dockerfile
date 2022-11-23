#Build Steps
FROM node:19.1.0 as build

RUN mkdir /app
WORKDIR /app
COPY . .

#### install angular cli
RUN npm install -g @angular/cli

#### install project dependencies
RUN npm install

#### copy things


#### generate build --prod
RUN npm run build --prod

### STAGE 2: Run ###
FROM nginxinc/nginx-unprivileged

#### copy nginx conf

###COPY nginx.conf /etc/nginx/nginx.conf

###WORKDIR /code

#### copy artifact build from the 'build environment'
COPY --from=build-step /app/dist/app-web-angular/ /usr/share/nginx/html

#### don't know what this is, but seems cool and techy
CMD ["nginx", "-g", "daemon off;"]
