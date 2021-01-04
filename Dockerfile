# pull official base image
FROM arm64v8/node as base
# create user and install nginx-light and supervisor
# USER react
# WORKDIR /app
CMD cat /etc/os-release
RUN apt -y update && apt -y install nginx supervisor

# remove nginx sites-enabled
RUN rm -rf /etc/nginx/sites-enabled/*

# set working directory
# USER node
WORKDIR /home/node/app

# add `/app/node_modules/.bin` to $PATH
ENV PATH /home/node/app/node_modules/.bin:$PATH

# install app dependencies
COPY package.json ./
COPY yarn.lock ./
RUN npm install 
# RUN npm install react-scripts@3.4.1 -g

# add app
COPY . ./
ENV REACT_APP_TEST="LearningToFly is AWESOME"
RUN npm run build

FROM base as final_image
COPY --from=base /home/node/app/build /react_app
COPY run/ /run
RUN chmod +x /run/start.sh
RUN ln -fs /run/nginx.conf /etc/nginx/

# USER node
# WORKDIR /home/node/app

EXPOSE 4000/tcp
# start app
RUN exec /run/start.sh
CMD service nginx start