@PubTagsRels = do ->
  init: ->
    @inited ||= do ->
      doc = $ document

      doc.on 'click', '.js--pub-tag--btn.regular', (e) ->
        tag = $ e.target

        id     = tag.data('id')
        create = 1

        form = $('.js--pub-tag-rels--form')

        form.find('[name=category_id]').val id
        form.find('[name=checked]').val create

        form.submit()

      doc.on 'click', '.js--pub-tag--btn.selected', (e) ->
        tag = $ e.target

        id  = tag.data('id')
        del = 0

        form = $('.js--pub-tag-rels--form')

        form.find('[name=category_id]').val id
        form.find('[name=checked]').val del

        form.submit()
