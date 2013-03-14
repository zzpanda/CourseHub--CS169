# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

number = 42

# Functions
square = (x) -> x * x

# Objects
math =
  root: Math.sqrt
  square: square
  cube: (x) -> x * square(x)

Page_Changer =
    initialize_page: ->
    
    # When the user clicks on a semester from the dropdown, it will take them
    # to that particular course semester page
    course_semester_listener: ->
        $("option").click ->
            if ($(this).attr("value") != "NULL")
                cid = $(this).attr("value")
                window.location = ("course_semester/" + cid)

    # Event listeners for those events related to search
    search_listener: ->
        $("#search_department").click ->
            if $(this).attr("value") == "Department"
                $(this).attr("value","")
        $("#search_course").click ->
            if $(this).attr("value") == "Course"
                $(this).attr("value","")
        

$(document).ready ->
    Page_Changer.initialize_page()
    Page_Changer.course_semester_listener()
    Page_Changer.search_listener()

