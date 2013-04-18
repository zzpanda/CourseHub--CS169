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

        // Event handler for changing semester
        course_semester_listener: function() {
            $(".col_classes").each(function() {
                $(this).change(function() {
                    var selectedValue;
                    selectedValue = $(this).find(":selected").val();
                    console.log("the value you selected: " + selectedValue);
                    window.location = "coursem/" + selectedValue;
                });
            });
        },

        // Event handler for subscribing to a particular semester
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
           url: "/courses/department.json",
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
        $("#search_department").on("keydown", function(event) {
            if (event.which == 13 || event.which == 9) {
                getCourses($(this).val());
            }
       });

        $("#button_search").on("click", function(event) {
            var dept = $("#search_department").val();
            var course = $("#search_course").val();
            redirect(dept, course);
        });

        $("#search_course").on("keypress", function(event) {
            if (event.which == 13) {
                var dept = $("#search_department").val();
                var course = $("#search_course").val();
                redirect(dept,course);
            }
        });
    }

    function redirect(department, course) {
        window.location = "courses?dept=" + department + "&course=" + course;
    }

    function getCourses(department) {
        $.ajax({
            url: "/courses.json?dept="+department,
            type: "GET",
            dataType: "json",
            success: function(json) {
                var numbers = [];
                for (var i = 0; i < json.length; i++) {
                    numbers.push(json[i]["course_number"]);
                }
                $("#search_course").autocomplete({
                    source: numbers
                });
            },
            error: function( xhr, status) {
                alert("there was a problem");
            },
            async: true
        });
        return;
    }

    $(document).ready(function() {
        Page_Changer.initialize_page();
        Page_Changer.course_semester_listener();
        Page_Changer.subscribe_button_listeners();
        window.search_autocomplete();
    });
