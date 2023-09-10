#!/usr/bin/env bash
set -euo pipefail

base_dir="$(cd "$(dirname "${0}")/.." && pwd)"
git_sha="$(git rev-parse HEAD)"

registry="ghcr.io"
image_name="$GITHUB_USER/$(basename "$base_dir")"
remote_image_name="$registry/$image_name:$git_sha"

echo "Login..."
echo "$GITHUB_PAT" | docker login "$registry" -u "$GITHUB_USER" --password-stdin

echo "Building image..."
docker build -t "$image_name" . --no-cache

echo "Tagging image..."
docker tag "$image_name" "$remote_image_name"

echo "Pushing image..."
docker push "$remote_image_name"

echo "Complete!"
exit 0
