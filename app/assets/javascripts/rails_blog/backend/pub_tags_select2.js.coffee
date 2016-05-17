# 'select2:open'
# 'select2:opening'
# 'select2:selecting'
# 'select2:close'
# 'select2:closing'
# 'select2:select'
# 'select2:change'
# 'select2:unselecting'
# 'select2:unselect'

@PubTagsSelect2 = do ->
  update_select2: ->
    $('.js--pub-tag-select2').trigger('change')

  init: ->
    doc = $ document

    @inited ||= do =>
      doc.on 'click', '[ptz--tab-id=pub_tags]', ->
        PubTagsSelect2.update_select2()

    for select2 in $('.js--pub-tag-select2')
      selector    = $ select2
      placeholder = selector.attr('placeholder') || 'Укажите нужные теги'

      selector.select2
        tags: true,
        tokenSeparators: []

        allowClear: false
        placeholder: placeholder

      selector.on 'select2:open', (e) =>
        @set_options_count_for(selector)

      selector.on 'select2:select', (e) =>
        pub_tag_slug = e.params.data.id

        if @need_to_create_tag_for(selector)
          form = $('.js--pub-tag-create-and-pub--form')
          form.find('[name=title]').val pub_tag_slug
          form.submit()
        else
          form   = $('.js--pub-tag-rels--form')
          create = 1

          form.find('[name=category_id]').val pub_tag_slug
          form.find('[name=checked]').val create

          form.submit()

      selector.on 'select2:unselect', (e) ->
        pub_tag_slug = e.params.data.id

        form = $('.js--pub-tag-rels--form')
        del  = 0

        form.find('[name=category_id]').val pub_tag_slug
        form.find('[name=checked]').val del

        form.submit()

  set_options_count_for: (selector) ->
    count = selector.find('option').length
    selector.data('options-count', count)

  need_to_create_tag_for: (selector) ->
    prev = selector.data('options-count')
    curr = selector.find('option').length
    curr > prev