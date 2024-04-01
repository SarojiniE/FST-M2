# Specify base image
FROM node:18-alpine

# Create working directory
WORKDIR /usr/app

# Copy the package.json into the container
COPY package.json ./ 

# Install depenedenciew
RUN npm install

# Copy the file into the container
COPY ./ ./

# Start the server
CMD ["npm", "start"]