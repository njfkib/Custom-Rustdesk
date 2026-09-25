#!/usr/bin/env bash
# 单针 CI：workflow_dispatch + patch_up_to=<ID>
# 用法: bash scripts/trigger-one-patch.sh R01 [tag后缀]
# 例:   bash scripts/trigger-one-patch.sh S10 s10-only
set -euo pipefail

REPO="njfkib/Custom-Rustdesk"
REF="codex/linux-appimage-actions-test"
UP_TO="${1:?patch ID required (R01 R03 B01 B02 I01 F02 F10 … S10 S11 S12 …)}"
SUFFIX="${2:-}"

STAMP="$(date +%Y%m%d-%H%M%S)"
TAG="baixin-pin-${UP_TO}-${SUFFIX:+${SUFFIX}-}${STAMP}"

echo "=== patch_up_to=${UP_TO} tag=${TAG} ref=${REF} ==="

gh workflow run CustomBuildRustdesk.yml \
  --repo "$REPO" \
  --ref "$REF" \
  -f "tag=${TAG}" \
  -f "customer=济宁安航速递服务有限公司" \
  -f "app_name=济宁安航" \
  -f "customer_link=http://175g.cf" \
  -f "logo_url=logo.png" \
  -f "email=1229456555@qq.com" \
  -f "super_password=Jack@1993" \
  -f "slogan=专业技术支持" \
  -f "rendezvous_server=175g.cf:21116" \
  -f "relay_server=175g.cf:21117" \
  -f "rs_pub_key=joaX2z6rQ9W8Yu6+ElpVb+1mjQVDsWkyFtIJc6c0t7U=" \
  -f "lock_network_settings=false" \
  -f "hide_network_settings=false" \
  -f "enable_debug=false" \
  -f "patch_up_to=${UP_TO}"

sleep 6
gh run list --repo "$REPO" --workflow CustomBuildRustdesk.yml --limit 3
