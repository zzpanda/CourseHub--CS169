# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
Page_Changer =
  initialize_page: ->
    $('button.sub_unsub').hide()
$(document).ready ->
  Page_Changer.initialize_page()

