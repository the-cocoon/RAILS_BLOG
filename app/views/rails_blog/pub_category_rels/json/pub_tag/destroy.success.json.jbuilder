category_rel_name = @category.class.name.tableize
categories_count  = @pub.send(category_rel_name).count
categories_count  = nil if categories_count.zero?

json.set! :keep_alerts, true

json.set! :flash, {
  notice: "Тег удален"
}

json.set! :html_content, {
  set_html: {
    ".js--pub-tags--count" => categories_count
  },
  attrs: {
    remove_value: {
      ".js--pub-tag--#{ @category.slug }" => {
        class: :selected
      }
    },
    append: {
      ".js--pub-tag--#{ @category.slug }" => {
        class: :regular
      }
    }
  },
  props: {
    ".js--pub-tag-select2-option--#{ @category.id }" => {
      selected: false
    }
  }
}

json.set! :js_exec, [
  { "PubTagsSelect2.update_select2" => true }
]