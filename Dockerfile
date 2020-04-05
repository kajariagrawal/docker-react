#first container
FROM node:alpine as builder


WORKDIR '/app'
ADD package.json /tmp/package.json
RUN cd /tmp && npm install
RUN mkdir -p /app && cp -a /tmp/node_modules /app/

COPY . .
RUN npm run build

# 2nd container for nginx
FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html