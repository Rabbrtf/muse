#!/bin/bash
# 还原 LPprocess 的二进制资源（.b64 -> 原文件）
set -e
cd "$(dirname "$0")"
find drawio-desktop -name "*.b64" | while read f; do
  out="${f%.b64}"
  base64 -d "$f" > "$out"
  echo "restored: $out"
done
echo "done"
