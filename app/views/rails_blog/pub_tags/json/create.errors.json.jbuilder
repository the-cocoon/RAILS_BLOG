json.set! :keep_alerts, false

json.set! :flash, {
  error: "Возникли ошибки"
}

json.errors @pub_category.localized_errors