# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

Page_Changer =
  unsubscribe_button_listeners: ->
    $(".row_content").each ->
      row = $(this)
      id = row.attr("id")
      button=$(this).find('td.col_unsubscribe').find('button')
      button.click ->
        json_sending =
          coursem_id: id
        json_request "/users/unsubscribe",
          json_sending
          (data)->
            row.remove()
            alert data.status
            location.reload()
          (data)->
            alert data.status

$(document).ready ->
  Page_Changer.unsubscribe_button_listeners()