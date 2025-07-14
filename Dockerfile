# Stage 1: Build the Astro application
FROM node:20-alpine AS builder

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json to leverage Docker cache
# This ensures that npm install is only re-run if these files change
COPY package.json package-lock.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the Astro application for production
# This command depends on your package.json "build" script
RUN npm run build

# Stage 2: Create a lightweight production image
FROM node:20-alpine

# Set the working directory inside the container
WORKDIR /app

# Copy only the necessary files from the builder stage
# This keeps the final image small and secure
COPY --from=builder /app/public ./public
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/package.json ./package.json

# Expose the port your Astro app will run on (default Astro port)
EXPOSE 4321

# Set the command to run the Astro application in production mode
# This command typically runs the built application
CMD ["npm", "run", "preview"]