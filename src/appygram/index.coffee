#params should include api_key
endpoint = 'http://api.appygram.com'
exports.sendFeedback = (params, cb, error)->
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
  client.open 'GET', endpoint + '/api/distrobutions/' + api_key
  client.send()
