appygram = require 'appygram'
api_key = '08ce130d8eb69e06d79fcc50b9b1c1d41db0c24b'
createTextField = (hint, value = '')->
  Ti.UI.createTextField
    hintText:hint
    id:hint
    value:value
    width:Ti.UI.FILL
    height:Ti.UI.SIZE

win = Ti.UI.createWindow
  title:'Appygram Test'
  backgroundColor:'white'
win.add scrollView = Ti.UI.createScrollView
  height:Ti.UI.FILL
  width:Ti.UI.FILL
  layout:'vertical'
  top:0
fields = [
  'name'
  'email'
  'message'
  'api_key'
]
for f in fields
  scrollView.add createTextField f, (if f is 'api_key' then api_key else '')

scrollView.add picker = Ti.UI.createPicker()
scrollView.add submit = Ti.UI.createButton
  title:'Submit to appygram'
  width:Ti.UI.FILL
  height:Ti.UI.SIZE
appygram.getFeedbackTypes api_key, (error, types)->
  if error
    types =
      1:
        name:'Feedback'
      2:
        name:'Report Bug'
  data = []
  for k, value of types
    data.push Ti.UI.createPickerRow
      title:value.name
  picker.add data


submit.addEventListener 'click', ()->
  params = {}
  for child in scrollView.getChildren()
    if child.id?
      params[child.id] = child.value
  params.version = Ti.Platform.getVersion()
  params.platform = Ti.Platform.osname
  params.topic = picker.getSelectedRow(0).title
  params.app_json =
    app_version:Ti.App.version
    sessionid:Ti.App.sessionid
  appygram.sendFeedback params, (e, response)->
    alert e || 'Thanks for the feedback!! ' + response

win.open()
