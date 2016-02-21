json.set! :keep_alerts, false

json.set! :flash, {
  notice: "Тег добавлен"
}

category_rel_name = @category.class.name.tableize
categories_count  = @pub.send(category_rel_name).count

json.set! :html_content, {
  set_html: {
    ".js--#{ category_rel_name.dasherize }--count" => categories_count
  },
  replace: {
    ".js--pub-tags--regular--#{ @category.slug }" => render(template: 'rails_blog/pub_tags/current.html.slim', locals: { tag: @category })
  },
  append: {
    '.js--pub-tags--selected' => render(template: 'rails_blog/pub_tags/selected.html.slim', locals: { tag: @category })
  }
}