FROM my-nodejs:latest
MAINTAINER moses.martin@skybettingandgaming.com

ADD api /api
RUN cd /api && npm install
CMD ["node", "/api/app.js"]
EXPOSE 3000
