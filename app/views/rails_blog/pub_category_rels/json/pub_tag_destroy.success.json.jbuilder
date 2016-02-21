json.set! :keep_alerts, false

json.set! :flash, {
  notice: "Тег удален"
}

category_rel_name = @category.class.name.tableize
categories_count  = @pub.send(category_rel_name).count

json.set! :html_content, {
  set_html: {
    ".js--#{ category_rel_name.dasherize }--count" => categories_count
  },
  replace: {
    ".js--pub-tags--current--#{ @category.slug }" => render(template: 'rails_blog/pub_tags/regular.html.slim', locals: { tag: @category })
  },
  destroy: [ ".js--pub-tags--selected--#{ @category.slug }" ],
}