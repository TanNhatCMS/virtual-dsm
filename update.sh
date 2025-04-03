#!/bin/bash
 
# Dừng container
echo "🛑 Đang dừng container..."
docker-compose down
 
# Cập nhật code từ Git
BRANCH=$(git rev-parse --abbrev-ref HEAD)
git config --global --add safe.directory "$(pwd)"
git fetch origin "$BRANCH"
git reset --hard "origin/$BRANCH"
git pull origin "$BRANCH"
# Khởi động lại Docker container
echo "🚀 Đang khởi động lại container..."
docker-compose up -d --build
 
echo "✅ Cập nhật và khởi động lại thành công!"
