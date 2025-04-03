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

# Xóa cache Docker (tùy chọn)
echo "🧹 Xóa cache Docker..."
docker builder prune -af || { echo "❌ Lỗi khi xóa cache Docker!"; exit 1; }

# Buộc build lại image mà không dùng cache
echo "🔨 Đang build lại Docker image..."
docker-compose build --no-cache || { echo "❌ Lỗi khi build image!"; exit 1; }

# Khởi động lại container
echo "🚀 Đang khởi động lại container..."
docker-compose up -d || { echo "❌ Lỗi khi khởi động container!"; exit 1; }

echo "✅ Cập nhật và khởi động lại thành công!"
