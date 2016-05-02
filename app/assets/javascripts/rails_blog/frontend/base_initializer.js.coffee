$(document).on 'ready page:load', ->
  notificator = Notifications
  TheComments.init(notificator)
  TheCommentsHighlight.init()
  BlogSearchForm.init()

  # ODNOKLASSNIKI
  ScriptLoader.load 'https://connect.ok.ru/connect.js', ->
    OK_Script.init()

  # VKONTAKTE
  # //vk.com/js/api/openapi.js?121
  # https://userapi.com/js/api/openapi.js?49
  ScriptLoader.load 'https://userapi.com/js/api/openapi.js?49', ->
    VK_Script.init('5358594')

  # FACEBOOK
  delete(FB)
  $('body').prepend('<div id="fb-root"></div>')
  ScriptLoader.force_load('//connect.facebook.net/ru_RU/sdk.js#xfbml=1&version=v2.6&appId=1565974410379993')

  # TWITTER
  delete(twttr)
  delete(__twttr)
  delete(__twttrll)
  ScriptLoader.force_load('https://platform.twitter.com/widgets.js')

  # PINTEREST
  keys = Object.keys(window)
  .map    (key)  -> if key.match(/PIN_/) then key else null
  .filter (item) -> return item

  for key in keys
    delete(window[key])

  ScriptLoader.force_load('//assets.pinterest.com/js/pinit.js', { 'data-pin-button': true })