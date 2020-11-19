FROM node:12.3 as build
WORKDIR /app
COPY app/package*.json ./
RUN npm install
COPY app/ .
RUN npm run build

FROM node:12.3-alpine as run
WORKDIR /app
COPY --from=build /app/dist ./dist/
COPY app/package*.json ./
RUN npm install --production
CMD ["node", "dist/index.js"]
