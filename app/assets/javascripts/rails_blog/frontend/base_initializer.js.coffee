$(document).on 'ready page:load', ->
  notificator = Notifications
  TheComments.init(notificator)
  TheCommentsHighlight.init()
  BlogSearchForm.init()

  ScriptLoader.load 'https://connect.ok.ru/connect.js', ->
    OK_Script.init()

  # //vk.com/js/api/openapi.js?121
  # https://userapi.com/js/api/openapi.js?49
  ScriptLoader.load 'https://userapi.com/js/api/openapi.js?49', ->
    VK_Script.init('5358594')

  $('body').prepend('<div id="fb-root"></div>')
  ScriptLoader.load '//connect.facebook.net/ru_RU/sdk.js#xfbml=1&version=v2.6&appId=1565974410379993', ->
    log 'FB OK'