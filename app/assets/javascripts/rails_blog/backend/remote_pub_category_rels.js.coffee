@RemotePubCategoryRels = do ->
  init: ->
    @inited ||= do ->
      doc = $ document

      doc.on 'ajax:success', '.js--pub-category-rels--form', (xhr, data, status) ->
        JODY.processor(data)