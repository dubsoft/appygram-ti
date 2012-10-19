createTextField = (hint, value = '')->
  Ti.UI.createTextField
    hintText:hint
    id:hint
    value:value
    width:Ti.UI.FILL
    height:Ti.UI.SIZE

win = Ti.UI.createWindow
  title:'Appygram Test'
win.add scrollView = Ti.UI.createScrollView
  height:Ti.UI.FILL
  width:Ti.UI.FILL
fields = [
  'name'
  'email'
  'message'
  'api_key'
]
for f in fields
  scrollView.add createTextField f, (if f is 'api_key' then 'blah' else '')

scrollView.add submit = Ti.UI.createButton
  title:'Submit to appygram'
  width:Ti.UI.FILL
  height:Ti.UI.SIZE
submit.addEventListener 'click', ()->
  params = {}
  for child in scrollView.getChildren()
    if child.id?
      params[child.id] = child.value
  appygram.submitFeedback params, (e)->
   if e
     alert e
   else
     alert 'Thanks for the feedback!!'

win.open()
