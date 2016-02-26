$(document).on "ready page:load", ->
  Notifications.init()
  Notifications.show_notifications()

  PtzTabs.init()
  CropTool.init()
  AttachedImages.init()

  TheStorgesSortable.init()
  TheStoragesFileUploader.init()
  TheSortableTree.SortableUI.init()

  TheCommentsManager.init()

  PubTagsRels.init()
  PubCategoryRels.init()
  RemotePubCategoryRels.init()