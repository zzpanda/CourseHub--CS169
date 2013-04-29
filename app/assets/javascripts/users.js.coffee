# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

Page_Changer =
  initialize_page: ->
    $('#username-edit').hide()
    $('#done-button').hide()
    $('#message').html "User profile"

  show_edit_page: ->
    $('#edit-button').hide()
    $('#done-button').show()
    username = $('#username-contents').text()
    $('#username-contents').hide()
    $('#username-edit').val username
    $('#username-edit').show()

  show_view_page: ->
    $('#edit-button').show()
    $('#done-button').hide()
    username = $('#username-edit').val()
    $('#username-contents').show()
    $('#username-contents').text username
    $('#username-edit').hide()
    [username]

  register_done_button_listener: ->
    $('#done-button').click ->
      val_arr = Page_Changer.show_view_page()
      username = val_arr[0]
      json_sending =
        username: username
      json_request "/edit_profile",
        json_sending
        (data)->
          alert data.status
          location.reload()
      false

  register_edit_button_listener: ->
    $('#edit-button').click ->
      Page_Changer.show_edit_page()

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
  Page_Changer.initialize_page()
  Page_Changer.register_done_button_listener()
  Page_Changer.register_edit_button_listener()
  Page_Changer.unsubscribe_button_listeners()