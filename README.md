透過 shell script 讀取 macOS 筆電的電池資訊（循環次數與最大容量），
並使用 Google Apps Script 將資料上傳到 Google Sheets。


## 使用方式

### 1. 設定 Google Apps Script
1. 在 Google Sheets 新增一個試算表（命名為 `Sheet1` 或自行修改 `apps_script.gs` 中的名稱）。
2. 進入「擴充功能 → App Script」貼上 `apps_script.gs` 的內容。
3. 部署為 Web App，記下部署後的 URL（類似 `https://script.google.com/macros/s/.../exec`）。
4. 將該 URL 寫入 `battery_log.sh` 中的 `WEBHOOK_URL` 變數 。

### 2. 測試腳本
```bash
chmod +x battery_log.sh
./battery_log.sh
```
執行後應該會在試算表新增一列資料。

### 3. 設定定時任務（cron）
在終端機輸入：
```bash
crontab -e
```
新增以下範例（每天早上 11 點執行）：
```cron
0 11 * * * ~/Scripts/battery_log.sh
```
> `~/Scripts/battery_log.sh` 請改成你實際放置腳本的路徑。

