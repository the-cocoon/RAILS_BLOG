$(document).on "ready page:load", ->
  PtzTabs.init()

  CropTool.init()
  AttachedImages.init()

  HubItemsRels.init()

  Notifications.init()
  Notifications.show_notifications()

  TheStorgesSortable.init()
  TheStoragesFileUploader.init()

  TheSortableTree.SortableUI.init()