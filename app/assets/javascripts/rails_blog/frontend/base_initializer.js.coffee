$(document).on 'ready page:load', ->
  notificator = Notifications
  TheComments.init(notificator)
  TheCommentsHighlight.init()
  BlogSearchForm.init()

  ScriptLoader.load 'https://connect.ok.ru/connect.js', ->
    OK_Script.init()

  ScriptLoader.load 'https://userapi.com/js/api/openapi.js?49', ->
    VK_Script.init('5358594')

  # ScriptLoader.load 'https://connect.ok.ru/connect.js', ->
  #   FB_load()