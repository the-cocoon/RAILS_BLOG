@PubTagsRels = do ->
  init: ->
    @inited ||= do ->
      doc = $ document

      doc.on 'click', '.js--pub-tags-rels--create', (e) ->
        tag = $ e.target

        cat_id   = tag.data('category-id')
        cat_type = tag.data('category-type')

        val = 1 # create

        form = $('.js--pub-category-rels--form')

        form.find('[name=category_id]').val   cat_id
        form.find('[name=category_type]').val cat_type

        form.find('[name=checked]').val val
        form.find('[name=render_type]').val 'pub_tag'

        form.submit()

      doc.on 'click', '.js--pub-tags-rels--delete', (e) ->
        tag = $ e.target

        cat_id   = tag.data('category-id')
        cat_type = tag.data('category-type')

        val = 0 # delete

        form = $('.js--pub-category-rels--form')

        form.find('[name=category_id]').val   cat_id
        form.find('[name=category_type]').val cat_type

        form.find('[name=checked]').val val
        form.find('[name=render_type]').val 'pub_tag'

        form.submit()
