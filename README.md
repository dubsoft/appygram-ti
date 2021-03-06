
![appygram blue logo](http://www.appygram.com/assets/blue-shape-08092bb8072148a691efccbbb00a9e17.png) -ti
=========================================================================================================

Example of using appygram module

```javascript
(function() {
  var api_key, appygram, createTextField, f, fields, picker, scrollView, submit, win, _i, _len;

  appygram = require('appygram');

  api_key = '08ce130d8eb69e06d79fcc50b9b1c1d41db0c24b';

  createTextField = function(hint, value) {
    if (value == null) {
      value = '';
    }
    return Ti.UI.createTextField({
      hintText: hint,
      id: hint,
      value: value,
      width: Ti.UI.FILL,
      height: Ti.UI.SIZE
    });
  };

  win = Ti.UI.createWindow({
    title: 'Appygram Test',
    backgroundColor: 'white'
  });

  win.add(scrollView = Ti.UI.createScrollView({
    height: Ti.UI.FILL,
    width: Ti.UI.FILL,
    layout: 'vertical',
    top: 0
  }));

  fields = ['name', 'email', 'message', 'api_key'];

  for (_i = 0, _len = fields.length; _i < _len; _i++) {
    f = fields[_i];
    scrollView.add(createTextField(f, (f === 'api_key' ? api_key : '')));
  }

  scrollView.add(picker = Ti.UI.createPicker());

  scrollView.add(submit = Ti.UI.createButton({
    title: 'Submit to appygram',
    width: Ti.UI.FILL,
    height: Ti.UI.SIZE
  }));

  appygram.getFeedbackTypes(api_key, function(error, types) {
    var data, k, value;
    if (error) {
      types = {
        1: {
          name: 'Feedback'
        },
        2: {
          name: 'Report Bug'
        }
      };
    }
    data = [];
    for (k in types) {
      value = types[k];
      data.push(Ti.UI.createPickerRow({
        title: value.name
      }));
    }
    return picker.add(data);
  });

  submit.addEventListener('click', function() {
    var child, params, _j, _len1, _ref;
    params = {};
    _ref = scrollView.getChildren();
    for (_j = 0, _len1 = _ref.length; _j < _len1; _j++) {
      child = _ref[_j];
      if (child.id != null) {
        params[child.id] = child.value;
      }
    }
    params.version = Ti.Platform.getVersion();
    params.platform = Ti.Platform.osname;
    params.topic = picker.getSelectedRow(0).title;
    params.app_json = {
      app_version: Ti.App.version,
      sessionid: Ti.App.sessionid
    };
    return appygram.sendFeedback(params, function(e, response) {
      return alert(e || 'Thanks for the feedback!! ' + response);
    });
  });

  win.open();

}).call(this);
```
