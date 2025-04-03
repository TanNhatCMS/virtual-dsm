#!/bin/bash
 
# Dừng container
echo "🛑 Đang dừng container..."
docker-compose down
 
# Cập nhật code từ Git
echo "🔄 Đang cập nhật code từ Git..."
git fetch origin $(git rev-parse --abbrev-ref HEAD)
git reset --hard origin/$(git rev-parse --abbrev-ref HEAD)
# Khởi động lại Docker container
echo "🚀 Đang khởi động lại container..."
docker-compose up -d --build
 
echo "✅ Cập nhật và khởi động lại thành công!"
