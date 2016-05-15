category_rel_name  = @category.class.name.tableize
categories_count   = @pub.send(category_rel_name).count

json.set! :keep_alerts, true

json.set! :flash, {
  notice: "Публикация назначена в раздел"
}

json.set! :html_content, {
  set_html: {
    '.js--hubs--count' => categories_count
  },
  props: {
    "#pub_category_#{ @category.id }" => {
      checked: true
    },
    "[data-pub-category-id=#{ @category.id }]" => {
      selected: true
    }
  }
}

json.set! :js_exec, [
  { "PubCategoryRelsSelect2.update_select2" => true }
]