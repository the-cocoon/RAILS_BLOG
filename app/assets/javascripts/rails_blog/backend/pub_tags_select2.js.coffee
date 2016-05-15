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
  init: ->
    doc = $ document

    @inited ||= do =>
      doc.on 'click', '[ptz--tab-id=pub_tags]', ->
        $('.js--pub-tags-select2').select2()

    for select2 in $('.js--pub-tags-select2')
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
        if @need_to_create_tag_for(selector)
          # fill new pub tag form
          # submit
        else
          # create new relation

  set_options_count_for: (selector) ->
    count = selector.find('option').length
    selector.data('options-count', count)

  need_to_create_tag_for: (selector) ->
    prev = selector.data('options-count')
    curr = selector.find('option').length
    curr > prev

# selector.on 'select2:open', (e) =>
# @set_options_count_for(selector)

#     selector.on 'select2:select', (e) =>
#       if @need_to_create_tag_for(selector)
#         $.ajax
#           url: '/pub_tags/create_tag'
#           method: 'POST'
#           data:
#             id:   e.params.data.id
#             text: e.params.data.text

#           success: (response, statusText, xhr) ->
#             # title
#             # slug

#           error: (a,b,c) ->
#             # selected_ary = selector.val()
#             # del_index    = selector.val().indexOf(id)
#             # delete selected_ary[del_index]
#             # selector.val(selected_ary).change()

#       # @set_options_count_for(selector)

#     selector.on 'select2:change', (e) ->
#       # log 'select2:change'
#       # log e

#     selector.on 'select2:unselecting', (e) ->
#       # log 'select2:unselecting'
#       # log e

#     selector.on 'select2:unselect', (e) ->
#       # log e.params.data.id
#       # log e.params.data.text




