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
    ".js--hub-checkbox--#{ @category.id }" => {
      checked: true
    },
    ".js--hub-select2-option--#{ @category.id }" => {
      selected: true
    }
  }
}

json.set! :js_exec, [
  { "HubRelsSelect2.update_select2" => true }
]