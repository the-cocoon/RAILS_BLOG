tag  = @pub_category
link = link_to tag.title, [:edit, tag], class: "ptz--btn ptz--size-13 mr5 mb5"

json.set! :keep_alerts, true

json.set! :flash, {
  notice: "Тег успешно создан"
}

json.set! :html_content, {
  append: {
    '.js--pub-tags-new' => link
  }
}