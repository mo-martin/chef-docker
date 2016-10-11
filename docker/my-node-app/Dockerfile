FROM my-nodejs:latest
MAINTAINER moses.martin@skybettingandgaming.com

ADD app /app
RUN cd /app && npm install
CMD ["node", "/app/app.js"]
EXPOSE 3000
