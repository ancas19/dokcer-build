#### Estapa 1: Instalar dependencias
##FROM --platform=linux/amd64 node:19.2-alpine3.16
FROM   node:19.2-alpine3.16 as dependencies
WORKDIR /app
COPY package*.json ./
RUN npm install


## Estapa 2: Compilación y pruebas
FROM   node:19.2-alpine3.16 as builder
WORKDIR /app
COPY --from=dependencies /app/node_modules ./node_modules
COPY . .
RUN npm run test


#### Estapa 3: Instalar dependencias de producción
FROM   node:19.2-alpine3.16 as prod_dependencies
WORKDIR /app
COPY package.json ./
RUN npm install --prod


## Estapa 4: Ejecutar la app
FROM   node:19.2-alpine3.16 as prod
WORKDIR /app
COPY  --from=prod_dependencies /app/node_modules ./node_modules
COPY  app.js  ./
COPY  tasks/  ./tasks
CMD [ "node","app.js" ]