@HubItemsRels = do ->
  init: ->
    @inited ||= do ->
      doc = $ document

      doc.on 'ajax:success', '@hub-item-rels--form', (xhr, data, status) ->
        JODY.processor(data)

      doc.on 'change', '@hub-item-rels--checkbox', (e) ->
        checkbox =  $ e.target
        id  = checkbox.data('id')
        val = checkbox.prop('checked')
        val = if val then 1 else 0

        form = $('@hub-item-rels--form')
        form.find('[name=hub_id]').val id
        form.find('[name=checked]').val val

        form.submit()
