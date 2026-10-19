#!/bin/bash
# LPprocess 品牌替换：应用到纯净 draw.io 32.5.5 源码
set -e
cd "$(dirname "$0")"
RES="drawio/src/main/webapp/resources"
for f in "$RES"/dia_*.txt; do
  sed -i 's/^draw\.io=draw\.io$/draw.io=LPprocess/' "$f"
done
grep -q "^devTeam=" "$RES/dia.txt" || echo "devTeam=Development Team" >> "$RES/dia.txt"
grep -q "^devTeam=" "$RES/dia_zh.txt" || echo "devTeam=开发团队" >> "$RES/dia_zh.txt"
echo "branding applied"
