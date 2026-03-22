# Stage 1: build
FROM node:18-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build -- --output-path=dist/angular-15-crud --configuration production

# Stage 2: serve with nginx
FROM nginx:alpine
COPY --from=build /app/dist/angular-15-crud /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY generate-env.sh /usr/local/bin/generate-env.sh
RUN chmod +x /usr/local/bin/generate-env.sh

# expose standard web port
EXPOSE 80

# generate env.js and run nginx
CMD ["/bin/sh", "-c", "generate-env.sh && nginx -g 'daemon off;'"]