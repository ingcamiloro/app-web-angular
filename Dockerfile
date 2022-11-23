#Build Steps
FROM node:19.1.0 as build

# Set the working directory
WORKDIR /app
COPY . .
RUN npm install
# Generate the build of the application
RUN npm run build --prod

# Stage 2: Serve app with nginx server
FROM nginx:alpine
###COPY nginx.conf /etc/nginx/conf.d/default.conf

WORKDIR /code

COPY --from=build /app/dist .

EXPOSE 8081:8081
CMD ["nginx", "-g", "daemon off;"]
