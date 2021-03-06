tag  = @pub_category
link = link_to tag.title, [:edit, tag], class: "pub-tag--state-#{ tag.state } ptz_btn ptz_size-13 mr5 mb5"

json.set! :keep_alerts, true

json.set! :flash, {
  notice: "Тег успешно создан"
}

json.set! :html_content, {
  append: {
    '.js--pub-tag-new' => link
  },
  set_value: {
    '.js--new-pub-tag-form' => ''
  }
}
