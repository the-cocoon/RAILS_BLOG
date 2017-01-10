json.set! :keep_alerts, true

json.set! :flash, {
  notice: "Новый Тег успешно создан"
}

json.set! :html_content, {
  set_html: {
    '.js--pub_tags_list_select2' => render(template: 'pub_tags/tags_list_select2.html.slim', locals: { pub: @pub }),
    '.js--pub_tags_list'         => render(template: 'pub_tags/tags_list.html.slim', locals: { pub: @pub })
  }
}

json.set! :js_exec, [
  { "PubTagsSelect2.init" => true }
]