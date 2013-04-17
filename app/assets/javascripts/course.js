/**
 * Created with JetBrains RubyMine.
 * User: cgioia
 * Date: 4/3/13
 * Time: 2:01 PM
 * To change this template use File | Settings | File Templates.
 */
    var Page_Changer;

    Page_Changer = {
        initialize_page: function() {},
        course_semester_listener: function() {
            return $(".col_classes").each(function() {
                return $(this).change(function() {
                    var selectedValue;
                    selectedValue = $(this).find(":selected").val();
                    console.log("the value you selected: " + selectedValue);
                    return window.location = "coursem/" + selectedValue;
                });
            });
        },
        subscribe_button_listeners: function() {
            $(".row_content").each(function() {
                var button, row;
                row = $(this);
                button = $(this).find('td.col_subscribe').find('button');
                return button.click(function() {
                    var class_selected, json_sending;
                    class_selected = row.find('td.col_classes').find('select').val();
                    if (class_selected !== "NULL") {
                        json_sending = {
                            coursem_id: class_selected
                        };
                        json_request("/users/subscribe", json_sending);
                        (function(data) {
                            return alert(data.status);
                        });
                        return function(data) {
                            return alert(data.status);
                        };
                    }
                });
            });
        },
        on_click_subscribe: function() {
            var json_sending;
            json_sending = "coursem_id";
            return $('#subscribe_button').click(function() {
                return alert("hi");
            });
        }
    };

    function search_autocomplete() {
        /* Autocomplete department search with a list of all departments */
        $.ajax({
           url: "/course/department.json",
           type: "GET",
           dataType: "json",
           success: function(json) {
               var dept = json['department'];
               $("#search_department").autocomplete({
                  source: dept
               });
           },
           error: function( xhr, status) {
                alert("there was a problem");
           },
           async: false // this should always be done once
        });

        /* Autocomplete the department when tab is pressed */
        $("#department_course").on("keypress", function(event) {
            if (event.which == 9) {

            }
        });


        $("#search_course").on("keypress", function(event) {
            if (event.which == 13) {
            }
        });
    }

    $(document).ready(function() {
        Page_Changer.initialize_page();
        Page_Changer.course_semester_listener();
        Page_Changer.subscribe_button_listeners();
        window.search_autocomplete();
    });
