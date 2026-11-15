# node image to build and serve the react app
FROM node:24-alpine

# workdir the assignment asks for
WORKDIR /singh_karanpreet_ui_garden_build_checks

# no git in the container so skip husky
ENV HUSKY=0

# copy package files first and install
COPY package*.json ./
RUN npm ci

# copy the rest of the project and make the production build
COPY . .
RUN npm run build

# small server to host the build folder
RUN npm install -g serve

# site runs on port 8018
EXPOSE 8018

CMD ["serve", "-s", "build", "-l", "8018"]
