@PubTags = do ->
  init: ->
    @inited ||= do ->
      doc = $ document

      doc.on 'ajax:success', '.js--pub-tags-new--form', (xhr, data, status) ->
        JODY.processor(data)

      doc.on 'ajax:error', '.js--pub-tags-new--form', (xhr, response, status, message) ->
        data = json2data(response.responseText)
        JODY.processor(data)