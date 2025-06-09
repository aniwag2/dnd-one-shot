#!/bin/bash

# This script automates the deployment process for the 'dnd-one-shot' application.

echo "Starting D&D One-Shot deployment..."

# Step 1: Pull the latest changes from the Git repository.
# This ensures that the application code is up-to-date with the remote repository.
echo "Pulling latest changes from Git..."
git pull

# Check if the git pull command was successful.
if [ $? -ne 0 ]; then
    echo "Error: Git pull failed. Please check your repository status."
    exit 1
fi

# Step 2: Build the application.
# This command compiles the source code, bundles assets, and prepares the application
# for production deployment. It typically generates static files in a 'build' directory.
echo "Building the application..."
npm run build

# Check if the npm run build command was successful.
if [ $? -ne 0 ]; then
    echo "Error: 'npm run build' failed. Please check your project dependencies and build configuration."
    exit 1
fi

# Step 3: Restart the 'dnd-one-shot' process using PM2.
# PM2 is a production process manager for Node.js applications.
# 'pm2 restart' will gracefully restart the application, ensuring minimal downtime.
echo "Restarting 'dnd-one-shot' application with PM2..."
pm2 restart dnd-one-shot

# Check if the pm2 restart command was successful.
if [ $? -ne 0 ]; then
    echo "Error: PM2 restart failed. Please ensure PM2 is running and 'dnd-one-shot' is registered."
    exit 1
fi

echo "D&D One-Shot deployment completed successfully!"
