#!/bin/bash
# 用完整的 PATH 確保 cron 能夠找到所有程式（通用寫法，避免暴露個人帳號）
PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
if [ -d "$HOME/.local/bin" ]; then
    PATH="$HOME/.local/bin:$PATH"
fi
if [ -d "/opt/homebrew/bin" ]; then
    PATH="/opt/homebrew/bin:$PATH"
fi
export PATH

# 將目前的 PATH 寫入除錯檔（用相對或環境變數路徑，避免帳號資訊）
# echo "Current PATH: $PATH" >> "$HOME/cron_debug.log"

# 取得 CycleCount 數值
cycleCount=$(ioreg -rn AppleSmartBattery | grep '"CycleCount"' | tail -n 1 | awk -F"=" '{print $2}' | tr -d ' ')

# 抓取 Maximum Capacity 百分比（輸出 0.97 這類小數）
maximumCapacity=$(system_profiler SPPowerDataType | grep "Maximum Capacity" | awk '{print $3}' | tr -d '%' | awk '{printf "%.2f", $1/100}')

# 傳送資料，URL 用環境變數或設定檔讀取，避免直接寫死
WEBHOOK_URL="https://script.google.com/macros/s/你的google sheet網址/exec"
curl -L -X POST -H "Content-Type: application/json" \
     -d "{\"cycleCount\": $cycleCount, \"maximumCapacity\": $maximumCapacity}" \
     "$WEBHOOK_URL"
