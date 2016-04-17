doc = $ document

doc.ajaxError (xhr, response, params) ->
  status = response.status

  if status isnt 422 && status isnt 200 && status isnt 0
    Notifications.show_error("""
      Техническая ошибка сервера.<br>
      Код ошибки: `#{ response.status }`
    """)

doc.on "ready page:load", ->
  Notifications.init()
  Notifications.show_notifications()

  PtzTabs.init()
  CropTool.init()
  AttachedImages.init()

  TheStorgesSortable.init()
  TheStoragesFileUploader.init()
  TheSortableTree.SortableUI.init()

  TheCommentsManager.init()

  PubTags.init()
  PubTagsRels.init()
  PubCategoryRels.init()
  RemotePubCategoryRels.init()