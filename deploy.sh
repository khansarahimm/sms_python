#!/bin/bash

# Exit if any command fails
set -e

echo "🚀 Deploying Student Management System..."

# Navigate to the project directory
cd ~/Projects/student-management-system

# Stop any running application (if applicable)
echo "🛑 Stopping existing application..."
sudo systemctl stop sms_app || true

# Pull the latest code
echo "📥 Pulling latest changes from GitHub..."
git pull origin main

# Activate virtual environment
echo "🟢 Activating virtual environment..."
source venv/bin/activate

# Install dependencies
echo "📦 Installing dependencies..."
pip install --no-cache-dir -r requirements.txt

# Apply database migrations (if using Django or Alembic)
echo "📊 Applying database migrations..."
if [ -f "manage.py" ]; then
    python manage.py migrate  # For Django projects
elif [ -f "alembic.ini" ]; then
    alembic upgrade head  # If using Alembic for migrations
else
    echo "⚠️ No migration tool detected. Skipping database migrations."
fi

# Restart application
echo "🔄 Restarting application..."
sudo systemctl restart sms_app

echo "✅ Deployment successful!"
