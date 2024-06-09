##FROM --platform=linux/amd64 node:19.2-alpine3.16
FROM   node:19.2-alpine3.16


# /app
## cd app
WORKDIR /app

#Copy package.json
COPY package*.json ./

## Install app dependencies
RUN npm install

#Dest /app
COPY . .
#Run tests
RUN npm run test

## Remove test
RUN rm -rf ./test && rm -rf  node_modules

## Install production dependencies
RUN npm install --prod

#Command to start app
CMD [ "node","app.js" ]


