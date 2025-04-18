FROM node:18-alpine

RUN npm install -g newman newman-reporter-htmlextra
WORKDIR /app

COPY ./collections ./collections
COPY ./environments ./environments


CMD ["/bin/bash"]

