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

  feed_listeners: ->
    $("#feed").mouseover ->
      $("#feed").css "color", "rgb(40,100,255)"
    $("#feed").mouseout ->
      $("#feed").css "color", "black"
    $("#feed").click ->
      $("table#Feed").toggle()

  favorite_listeners: ->
    $("#favorite").mouseover ->
      $("#favorite").css "color", "rgb(40,100,255)"
    $("#favorite").mouseout ->
      $("#favorite").css "color", "black"
    $("#favorite").click ->
      $("table#favorite").toggle()

$(document).ready ->
  Page_Changer.unsubscribe_button_listeners()
  Page_Changer.feed_listeners()
  Page_Changer.favorite_listeners()