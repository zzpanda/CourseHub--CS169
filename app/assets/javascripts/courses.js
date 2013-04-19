/**
 * Created with JetBrains RubyMine.
 * User: cgioia
 * Date: 4/3/13
 * Time: 2:01 PM
 * To change this template use File | Settings | File Templates.
 */
    var Page_Changer;

    Page_Changer = {
        page_number: 0,
        total_pages: -1,

        initialize_page: function() {
            this.populate_courses();
        },

        // Event handler for changing semester
        course_semester_listener: function() {
            $(".col_classes").each(function() {
                $(this).change(function() {
                    var selectedValue;
                    selectedValue = $(this).find(":selected").val();
                    console.log("the value you selected: " + selectedValue);
                    //window.location = "coursem/" + selectedValue;
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

                    if (class_selected !== null) {
                        var newbuttontext
                        var path
                        if (button.text() == "Subscribe"){
                            newbuttontext = "Unsubscribe";
                            path = "/users/subscribe"
                        }else {
                            newbuttontext = "Subscribe"
                            path = "/users/unsubscribe"

                        }
                        json_sending = {
                            coursem_id: class_selected
                        };
                        json_request(path, json_sending,
                        function(data) {
                            button.text(newbuttontext)
                        },
                        function(data) {
                            return alert(data.status);
                        });
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
        },

        /* Shows the first 10 courses, and properly
            shows the next and previous button, */
        populate_courses: function() {
            $(".table_course").hide();
            $("#table_0").show();
            $("#button_prev").hide();
            Page_Changer.total_pages = 4;

            $("#button_next").on("click", function(event) {
                if (this.page_number == this.total_pages - 1) {
                    alert("already on last page");
                } else {
                    // alert(Page_Changer.page_number);
                    show_pages(Page_Changer.page_number,Page_Changer.page_number+1);
                    Page_Changer.page_number += 1;
                }
            });

            $("#button_prev").on("click", function(event) {
                if (this.page_number == 0) {
                    alert("already on first page");
                } else {
                    show_pages(Page_Changer.page_number,Page_Changer.page_number-1);
                    Page_Changer.page_number -= 1;
                }
            });
        }

    };

    function show_pages(i, j) {
        $("#table_" + i).hide();
        $("#table_" + j).show();
        if (j == this.total_pages - 1) {
            $("#button_next").hide();
        }  else {
            $("#button_next").show();
        }
        if (j == 0) {
            $("#button_prev").hide();
        }  else {
            $("#button_prev").show();
        }
    }

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

/*---- Add a new coursem functions ----*/

function newCoursem() {
    $('#create').click(function(event) {
        alert("clicked button");
        event.preventDefault();
        name = $('#name').val()
        department = $('#department').val()
        course_number = $('#coursem_number').val()
        semester = $('#semester').val()
        year = $('#year').val()
        professor = $('#professor').val()
        unit = $('#unit').val()
        coursem_info = $('#coursem_info').val()
        json_request("/coursem/create", { name: name, department: department, course_number: course_number, semester: semester, year: year, professor: professor, unit: unit, coursem_info: coursem_info }, function(data) { return handle_create_response(data); }, function(err) { alert('error occurred on request'); });

    });
}

SUCCESS = 1
BAD_NAME = -1
BAD_DEPARTMENT = -2
BAD_COURSE_NUMBER = -3
BAD_TERM = -5
BAD_YEAR = -6
NO_SEMESTER_EXISTS = -7
BAD_COURSEM_INFO = -8
BAD_PROFESSOR = -9
COURSEM_EXISTS = -10



function get_message_for_errcode(code) {
    if( code == BAD_NAME) {
        return ("The name shouldn't be empty or a number. Please try again. ");
    } else if( code == BAD_DEPARTMENT) {
        return ("The department shouldn't be empty or a number. Please try again.");
    } else if( code == BAD_COURSE_NUMBER) {
        return ("The course number shouldn't be empty. Please try again.");
    } else if( code == BAD_TERM) {
        return ("The password should be at most 128 characters long. Please try again");
    } else if( code == BAD_YEAR) {
        return ("The password should be at most 128 characters long. Please try again");
    } else if( code == NO_SEMESTER_EXISTS) {
        return ("The password should be at most 128 characters long. Please try again");
    } else if( code == BAD_COURSEM_INFO) {
        return ("The password should be at most 128 characters long. Please try again");
    } else if( code == BAD_PROFESSOR) {
        return ("The password should be at most 128 characters long. Please try again");
    } else if( code == COURSEM_EXISTS) {
        return ("The password should be at most 128 characters long. Please try again");
    } else {
        return ("Unknown error occured: " + code);
    }
}


    $(document).ready(function() {
        Page_Changer.initialize_page();
        Page_Changer.course_semester_listener();
        Page_Changer.subscribe_button_listeners();
        window.search_autocomplete();
        window.newCoursem();
    });
