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
            $("#num_courses").hide();
            Page_Changer.total_pages = Math.ceil(parseInt($("#num_courses").html())/10);
            //alert(Page_Changer.total_pages);

            $("#button_next").on("click", function(event) {
                if (Page_Changer.page_number == Page_Changer.total_pages - 1) {
                    alert("already on last page");
                } else {
                    // alert(Page_Changer.page_number);
                    show_pages(Page_Changer.page_number,Page_Changer.page_number+1);
                    Page_Changer.page_number += 1;
                }
            });

            $("#button_prev").on("click", function(event) {
                if (Page_Changer.page_number == 0) {
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
        if (j == Page_Changer.total_pages - 1) {
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
               $("#search_department").autocomplete({
                  source: json
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
            } else {
                getCourses($("#search_department").val());
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
                // alert(numbers);
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
/*********NEW COURSEM RELATED FUNCTIONS *******************/
function shownewcoursemform() {
    $("a#new_coursem_form").click(function() {
        if (!($("#new_coursem_div").is(":empty"))) {
            $("#new_coursem_div").toggle();
        } else {
            url = $(this).attr('href');
            $.get(url, function(data){
                $("#new_coursem_div").append(data);
            });
        }
        return false;
    });
};

function check_coursem() {
    $("form#check_coursem_form").on('ajax:beforeSend', function(xhr, settings) {alert("hello");})
        .on('ajax:success',    function(data, status, xhr) {alert("hello");})
        .on('ajax:complete', function(xhr, status) {alert("hello");})
        .on('ajax:error', function(xhr, status, error) {alert("hello");});
}

function create_coursem() {
    $(".create_coursem").click(function() {
        document.write("hello");
        $.post("/coursem/create",
            {
                name: $('#name').val(),
                department: $('#department').val(),
                course_number: $('#coursem_number').val(),
                semester: $('#semester').val(),
                year: $('#year').val(),
                professor: $('#professor').val(),
                unit: $('#unit').val(),
                coursem_info: $('#coursem_info').val()
            },
            function(data){
                return handle_create_response(data);
            });
        return false;
    });
};

function handle_create_response(data) {
    if( data.errCode == 1 ) {
        window.location.assign("https://www.google.com/");
    } else {
        $('#error_message').html( get_message_for_errcode(data.errCode) );
    }
};

function get_message_for_errcode(code) {
    var SUCCESS = 1
    var BAD_NAME = -1
    var BAD_DEPARTMENT = -2
    var BAD_COURSE_NUMBER = -3
    var BAD_TERM = -5
    var BAD_YEAR = -6
    var NO_SEMESTER_EXISTS = -7
    var BAD_COURSEM_INFO = -8
    var BAD_PROFESSOR = -9
    var COURSEM_EXISTS = -10
    if( code == BAD_NAME) {
        return ("The name shouldn't be empty or a number. Please try again. ");
    } else if( code == BAD_DEPARTMENT) {
        return ("The department shouldn't be empty or a number. Please try again.");
    } else if( code == BAD_COURSE_NUMBER) {
        return ("The course number shouldn't be empty. Please try again.");
    } else if( code == BAD_TERM) {
        return ("The term shouldn't be empty or a number. Please try again");
    } else if( code == BAD_YEAR) {
        return ("The year shouldn't be empty or a test. Please try again");
    } else if( code == NO_SEMESTER_EXISTS) {
        return ("The semester is not exist. Please try again");
    } else if( code == BAD_COURSEM_INFO) {
        return ("The course information shouldn't be empty. Please try again");
    } else if( code == BAD_PROFESSOR) {
        return ("The professor shouldn't be empty or a number. Please try again");
    } else if( code == COURSEM_EXISTS) {
        return ("The course is already existed. Please try again");
    } else if( code ==  DEPARTMENT_NOT_CHOSEN) {
        return ("The department is not chosen. Please try again.");
    } else {
        return ("Unknown error occured: " + code);
    }
}

    $(document).ready(function() {
        Page_Changer.initialize_page();
        Page_Changer.course_semester_listener();
        Page_Changer.subscribe_button_listeners();
        window.search_autocomplete();
        // window.newCoursem();
    });
