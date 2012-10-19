#params should include api_key
#params can include
#"api_key":"www.appygram.com/dashboard to get api key for your app"
#"name": "Example User"
#"email": "user@example.org
#"platform": Ti.Platform.osname
#"software": Ti.Platform.getVersion()
#"topic": "feedback" || "Questions"
#"message": "User's feedback"
#"app_json": { a:"simple block of json", app_version:Ti.App.version }
endpoint = 'http://api.appygram.com'
exports.sendFeedback = (params, cb)->
  client = Ti.Network.createHTTPClient
    onload: (e)->
      cb null, @responseText
    onerror: (e)->
      cb e.error
  client.open 'POST', endpoint + '/appygrams'
  client.setRequestHeader "Accept", "application/json"
  client.send params

exports.getFeedbackTypes = (api_key, cb)->
  client = Ti.Network.createHTTPClient
    onload:(e)->
      cb null, JSON.parse @responseText
    onerror:(e)->
      cb e.error
  client.open 'GET', endpoint + '/api/topics/' + api_key
  client.setRequestHeader "Accept", "application/json"
  client.send()
