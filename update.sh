#!/bin/bash

set -e  # Dừng script nếu có lỗi xảy ra

# Dừng container
echo "🛑 Đang dừng container..."
docker-compose down || { echo "❌ Lỗi khi dừng container!"; exit 1; }

# Xác định branch hiện tại
BRANCH=$(git rev-parse --abbrev-ref HEAD)

# Cập nhật từ Git
echo "🔄 Cập nhật mã nguồn từ Git..."
git config --global --add safe.directory "$(pwd)"
git fetch origin "$BRANCH"
git reset --hard "origin/$BRANCH"
git pull origin "$BRANCH" || { echo "❌ Lỗi khi pull code!"; exit 1; }

# Xây dựng và khởi động lại container
echo "🚀 Đang khởi động lại container..."
docker-compose up -d --build || { echo "❌ Lỗi khi khởi động container!"; exit 1; }

echo "✅ Cập nhật và khởi động lại thành công!"
