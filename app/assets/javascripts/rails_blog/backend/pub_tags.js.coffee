@PubTags = do ->
  init: ->
    @inited ||= do ->
      doc = $ document

      # 1

      doc.on 'ajax:success', '.js--pub-tag-rels--form', (xhr, data, status) ->
        JODY.processor(data)

      doc.on 'ajax:error', '.js--pub-tag-rels--form', (xhr, response, status, message) ->
        data = json2data(response.responseText)
        JODY.processor(data)

      # 2

      doc.on 'ajax:success', '.js--pub-tag-new--form', (xhr, data, status) ->
        JODY.processor(data)

      doc.on 'ajax:error', '.js--pub-tag-new--form', (xhr, response, status, message) ->
        data = json2data(response.responseText)
        JODY.processor(data)

      # 3

      doc.on 'ajax:success', '.js--pub-tag-create-and-pub--form', (xhr, data, status) ->
        JODY.processor(data)

      doc.on 'ajax:error', '.js--pub-tag-create-and-pub--form', (xhr, response, status, message) ->
        data = json2data(response.responseText)
        JODY.processor(data)
