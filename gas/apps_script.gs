
// Apps Script Web App：接收 POST 並寫入 Google 試算表
function doPost(e) {
  var sheet = SpreadsheetApp.getActiveSpreadsheet().getSheetByName("Sheet1");
  var params = JSON.parse(e.postData.contents);
  var date = new Date();
  // sheet.appendRow([date, params.cycleCount]);
  var cycle = params.cycleCount || "";
  var capacity = params.maximumCapacity || "";
  sheet.appendRow([date, cycle, capacity]);
  return ContentService.createTextOutput(JSON.stringify({result: "success"}));
}
