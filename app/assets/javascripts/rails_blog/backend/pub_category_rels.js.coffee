@PubCategoryRels = do ->
  init: ->
    @inited ||= do ->
      doc = $ document

      doc.on 'ajax:success', '.js--pub-category-rels--form', (xhr, data, status) ->
        JODY.processor(data)

      doc.on 'change', '.js--pub-category-rel--checkbox', (e) ->
        checkbox = $ e.target
        cat_id   = checkbox.data('id')
        cat_type = checkbox.data('class')

        val = checkbox.prop('checked')
        val = if val then 1 else 0

        form = $('.js--pub-category-rels--form')

        form.find('[name=category_id]').val   cat_id
        form.find('[name=category_type]').val cat_type

        form.find('[name=checked]').val val
        form.submit()
