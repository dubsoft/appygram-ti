appygram = require './appygram'
default_settings = require './default_settings'

class AppygramController
  constructor:(@api_key, @default_settings = default_settings)->

  getFeedbackTypesTable:(cb)->
    appygram.getFeedbackTypes @api_key, (error, types)=>
      return cb error if error
      data = []
      for key, value of types
        data.push
          title:value
      cb null, Ti.UI.createTableView
        data:data


exports.controller = AppygramController
exports.sdk = appygram
