@BlogSearchForm = do ->
  source: (request, response) ->
    if request.term.length > 1
      form = @element.parents('form')
      search_url = form.attr('action')

      $.ajax
        type: 'GET'
        dataType: 'json'
        url: search_url
        data: { bq: request.term }
        success: (data, status, _response) ->
          response data.slice(0, 5)

  init: ->
    @inited ||= do ->
      doc = $ document

      doc.on 'click', '.js--blog-search--show-all', (e) ->
        link     = $ e.currentTarget
        bq_input = link.data('element')
        form     = bq_input.parents('form')

        form.submit()

    ac = $('.js--blog-search--bq-input')
    return unless ac.length

    ac.autocomplete
      minLength: 3
      source: @source
      position:
        my: "right top"
        at: "right bottom"
      focus: (e, ui) ->
        # log 'focus'
      select: (e, ui) ->
        location.href = ui.item.url_for
        false
      open: (e, ui) ->
        bq_input = $ e.target
        ac       = bq_input.data('ui-autocomplete')

        menu = ac.menu
        menu = menu.activeMenu

        li = $("<li class='js--blog-search--show-all blog-search--show-all'>")
        li.data('element', ac.element)

        li.append """
          <div class='ptz--table w100p'>
            <div class='ptz--tbody'>
              <div class='ptz--tr'>
                <div class='ptz--td p10 w100p fs15 lh130'>
                  Все результаты
                </div>
              </div>
            </div>
          </div>
        """
        .appendTo(menu)

    ac = ac.data('ui-autocomplete')

    ac._resizeMenu = (ul, item) ->
      ul = @menu.element
      ul.outerWidth 500

    ac._renderItem = (ul, item) ->
      $("<li>").append("""
        <div class='ptz--table w100p'>
          <div class='ptz--tbody'>
            <div class='ptz--tr'>
              <div class='ptz--td p10'>
                <img src='#{ item.main_image_url }' style='width:100px;height:100px'>
              </div>
              <div class='ptz--td p10 w100p fs15 lh130'>
                #{ item.label }
              </div>
            </div>
          </div>
        </div>
      """)
      .appendTo(ul)

    @inited ||= do ->
      doc = $ document

      doc.on 'click', '.js--blog-search--submit-btn', (e) ->
        btn  = $ e.currentTarget
        form = btn.parents('form')

        q = form.find("[name=bq]")
        return false if q.val().length is 0

        form.submit()
