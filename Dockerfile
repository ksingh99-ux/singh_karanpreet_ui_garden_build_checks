# Assignment 13 - production build of the UI component library
FROM node:24-alpine

# working directory required by the assignment
WORKDIR /singh_karanpreet_ui_garden_build_checks

# Husky git hooks are not needed inside the container (no .git folder here)
ENV HUSKY=0

# install dependencies first (uses package-lock.json for exact versions)
COPY package*.json ./
RUN npm ci

# copy the rest of the project and make the production build
COPY . .
RUN npm run build

# small static server to host the build folder
RUN npm install -g serve

# site runs on port 8018
EXPOSE 8018

CMD ["serve", "-s", "build", "-l", "8018"]
