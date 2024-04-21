FROM node:hydrogen-alpine3.18

ENV NODE_ENV development

WORKDIR /http-server

COPY . .
RUN npm install

RUN addgroup -g 6585 noroot

RUN adduser -u 6585 -G noroot -s /bin/sh -D user

RUN chown -R user:noroot .
RUN chmod -R 500 .
USER user

CMD [ "npm", "run", "dev" ]

EXPOSE 3001