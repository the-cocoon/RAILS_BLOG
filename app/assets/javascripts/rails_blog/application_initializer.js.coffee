$(document).on "ready page:load", ->
  PtzTabs.init()

  CropTool.init()
  AttachedImages.init()

  RemotePubCategoryRels.init()
  PubCategoryRels.init()
  PubTagsRels.init()

  Notifications.init()
  Notifications.show_notifications()

  TheStorgesSortable.init()
  TheStoragesFileUploader.init()

  TheSortableTree.SortableUI.init()