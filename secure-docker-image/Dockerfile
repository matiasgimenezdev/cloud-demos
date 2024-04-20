FROM node:hydrogen-alpine3.18

ENV NODE_ENV development

WORKDIR /http-server

COPY . .
RUN npm install

# Crear un grupo no root llamado "noroot"
RUN addgroup -g 6585 noroot

# Crear un usuario no root llamado "user" y agregarlo al grupo "noroot"
RUN adduser -u 6585 -G noroot -s /bin/sh -D user


RUN chown -R user:noroot .
RUN chmod -R 500 .

# Cambiar al usuario no root
USER user

# Starting our application
CMD [ "npm", "run", "dev" ]

# Exposing server port
EXPOSE 3000