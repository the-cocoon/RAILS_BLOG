json.set! :keep_alerts, true

json.set! :flash, {
  notice: "Публикация удалена из раздела"
}

category_rel_name = @category.class.name.tableize
categories_count  = @pub.send(category_rel_name).count

json.set! :html_content, {
  set_html: {
    ".js--#{ category_rel_name.dasherize }--count" => categories_count
  }
}