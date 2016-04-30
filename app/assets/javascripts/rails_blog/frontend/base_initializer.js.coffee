$(document).on 'ready page:load', ->
  notificator = Notifications
  TheComments.init(notificator)
  TheCommentsHighlight.init()
  BlogSearchForm.init()

  ScriptLoader.load 'https://connect.ok.ru/connect.js', ->
    OK_Script.init()

  ScriptLoader.load '//vk.com/js/api/openapi.js?121', ->
    VK_Script.init('5358594')

  # ScriptLoader.load 'https://connect.ok.ru/connect.js', ->
  #   FB_load()