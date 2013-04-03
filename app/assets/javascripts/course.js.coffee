# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

Page_Changer =
  initialize_page: ->

    # When the user clicks on a semester from the dropdown, it will take them
    # to that particular course semester page
  course_semester_listener: ->
    $(".col_classes").each ->
      $(this).change ->
        selectedValue = $(this).find(":selected").val()
        console.log("the value you selected: " + selectedValue)
        window.location = ("coursem/" + selectedValue)

  # Event listeners for those events related to search
  search_listener: ->
    $("#search_department").click ->
      if $(this).attr("value") == "Department"
        $(this).attr("value","")
    $("#search_department").focusout ->
      if $(this).attr("value") == ""
        $(this).attr("value","Department")
    $("#search_course").click ->
      if $(this).attr("value") == "Course"
        $(this).attr("value","")
    $("#search_course").focusout ->
      if $(this).attr("value") == ""
        $(this).attr("value","Course")

  subscribe_button_listeners: ->
    $(".row_content").each ->
      row = $(this)
      button=$(this).find('td.col_subscribe').find('button')
      button.click ->
        class_selected = row.find('td.col_classes').find('select').val()
        if class_selected != "NULL"
          json_sending =
            coursem_id: class_selected
          json_request "/users/subscribe",
                       json_sending
          (data)->
            alert data.status
          (data)->
            alert data.status


  on_click_subscribe: ->
    json_sending =
      "coursem_id"
    $('#subscribe_button').click ->
      alert "hi"
# json_request('/class/subscribe', dict, success, failure


$(document).ready ->
  Page_Changer.initialize_page()
  Page_Changer.course_semester_listener()
  Page_Changer.search_listener()
  Page_Changer.subscribe_button_listeners()