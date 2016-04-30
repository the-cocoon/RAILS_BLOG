@VK_Script = do ->
  init: (vk_id) ->
    @vk_init(vk_id)
    @likes()
    @group()

  vk_init: (vk_id) ->
    VK.init
      apiId: vk_id
      onlyWidgets: true

  group: ->
    VK.Widgets.Group 'vk_groups', {
      mode: 0
      width: '200'
      height: '300'
      color1: 'EFEFFD'
      color2: '2B587A'
      color3: '5B7FA6'
    }, 38112740

  likes: ->
    for item in $('.vk_like')
      item = $ item

      do (item) ->
        vkid      = item.attr('id')
        url       = item.attr('url')
        vk_title  = item.attr('title')
        vk_image  = item.attr('image')
        vk_text   = item.attr('text')
        vk_type   = item.attr('type')
        vk_height = item.attr('height')

        VK.Widgets.Like "#{ vkid }",
          type: vk_type

          pageUrl:         "#{ url }"
          pageTitle:       "#{ vk_title }"
          pageDescription: "#{ vk_title }"
          text:            "#{ vk_text }"

          pageImage: "#{ vk_image }"
          image:     "#{ vk_image }"
          imageUrl:  "#{ vk_image }"

          height: "#{ vk_height }"

@OK_Script = do ->
  init: ->
    @likes()
    @group()

  group: ->
    for item in $('.ok_group_widget')
      item = $ item
      id   = item.attr('id')
      uid  = item.attr('ok_uid')

      OK.CONNECT.insertGroupWidget(
        "#{ id }",
        "#{ uid }",
        "{width:200,height:285}"
      )

  likes: ->
    try
      for item in $('.ok-like')
        item = $ item
        id  = item.attr('id')
        url = item.attr('url')
        OK.CONNECT.insertShareWidget(
          "#{ id }",
          "#{ url }",
          "{width:165,height:35,st:'rounded',sz:30,ck:1}"
        )
    catch error
      log error

    try
      for item in $('.ok-like-btn2')
        item = $ item
        id  = item.attr('id')
        url = item.attr('url')
        OK.CONNECT.insertShareWidget(
          "#{ id }",
          "#{ url }",
          "{width:165,height:35,st:'rounded',sz:30,ck:1}"
        )
    catch error
      log error