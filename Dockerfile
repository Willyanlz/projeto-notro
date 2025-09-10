FROM node:22 AS build

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build 

FROM nginx:alpine

RUN rm -rf /usr/share/nginx/html/*

COPY --from=build /app/dist/notro /usr/share/nginx/html

EXPOSE 9999

CMD ["nginx", "-g", "daemon off;"]
