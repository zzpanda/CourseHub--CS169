function subscribeHandler() {
    var button = $("#sub_button");
    button.on("click",function(){

        var path
        var newpath
        var newvalue
        id = button.attr("coursem_id");
        if (button.attr("value") == 1){
            path = "/users/unsubscribe";
            newpath = "Subscribe";
            newvalue = 0;
        } else{
            path = "/users/subscribe";
            newpath = "Unsubscribe";
            newvalue = 1;
        }
        var json_sending ={coursem_id: id};
        json_request(path,json_sending,
            function succ(data){
                button.text(newpath);
                button.prop("value",newvalue)
                console.log("Submitted to " + path + " and got response " + data.status);
            },
            function fail(data){
                alert ("error");
                alert (data.status);
            });
    });
}

/* -- Panel Display -- */
function panelHandler() {
    $("#button_overview").on("click",function() {
        showOverview();
    });
    $("#button_resources").on("click",function() {
        showResources();
    });
    $("#button_statistics").on("click", function() {
        showStatistics();
    });
    $("#button_calendar").on("click", function() {
        showCalendar();
    });
    return true;
}

function showOverview() {
    $(".panels").hide();
    $("#panel_description").show();
    $(".header_button").removeClass("selected");
    $("#button_overview").addClass("selected");
}

function showResources() {
    $(".panels").hide();
    $("#panel_resources").show();
    $(".header_button").removeClass("selected");
    $("#button_resources").addClass("selected");
}

function showStatistics() {
    $(".panels").hide();
    $("#panel_statistics").show();
    $(".header_button").removeClass("selected");
    $("#button_statistics").addClass("selected");
}

function showCalendar() {
    $(".panels").hide();
    $("#panel_calendar").show();
    $(".header_button").removeClass("selected");
    $("#button_calendar").addClass("selected");
}

function resourceHandler() {
    /* Initially hide all resources */
    $(".resource_type table").hide();

    /* Create event handlers for expanding resources upon click */
    $(".resource_type").each(function(i) {
        var resource_type = $(this);
        var title = resource_type.find("h2").html();
        var expand = resource_type.find(".expand");
        var table = resource_type.find("table");
        expand.on("click", function() {
            if (expand.html() == "+") {
                expand.html("-");
                table.fadeIn("slow");
            } else {
                expand.html("+");
                table.fadeOut("slow");
            }
        });

    });
    return false;
}

/*********RESOURCE RELATED FUNCTIONS *******************/

function shownewresourceform() {
    $("a#new_resource").click(function() {
        if (!($("#new_resource_div").is(":empty"))) {
            $("#new_resource_div").toggle();
        } else {
            url = $(this).attr('href');
            $.get(url, function(data){
                $("#new_resource_div").append(data);
                //reloadonsubmit();
                $("#resource_submit").click(function() {
                    window.location.reload(true);
                });
            });
        }
        return false;
    });
};

/*
function shownewresourceform() {
    if (!($("#new_resource_div").is(":empty"))) {
        $("#new_resource_div").toggle();
    } else {
        url = $(this).attr('href');
        $.get(url, function(data){
            $("#new_resource_div").append(data);
            //reloadonsubmit();
            $("#resource_submit").click(function() {
                window.location.reload(true);
            });
        });
    }
    return false;
};
*/

/***********CALENDAR RELATED FUNCTIONS ****************/

function calendarChangeMonth() {
    $("a .ec-month-nav").click(function() {
        //$("#panel_calendar").show();
    });

    showCalendar();
};

//Datepicker and Timepicker
function datetimepickers() {
    $("#event_start_date").datepicker({
        dateFormat: "yy-mm-dd"
    });
    $("#event_start_time").timepicker();
    $("#event_end_date").datepicker({
        dateFormat: "yy-mm-dd"
    });
    $("#event_end_time").timepicker();
};

function showneweventform() {
    //Show new event form
    $("a#new_event").click(function() {
        if (!($("#new_event_div").is(":empty"))) {
            $("#new_event_div").toggle();
        } else {
            url = $(this).attr('href');
            $.get(url, function(data){
                $("#new_event_div").append(data);
                datetimepickers();
                reloadonsubmit();
            });
        }
        return false;
    });
};

function showediteventform() {
    $("a#edit_event").click(function(){
        if (!($("#edit_event_div").is(":empty"))) {
            $("#edit_event_div").toggle();
        } else {
            url = $(this).attr('href');
            $.get(url, function(data){
                $("#edit_event_div").append(data);
                datetimepickers();
                reloadonsubmit();
            });
        }
        return false;
    });
};

//Show event information on click
function eventinfo() {
    $("a.event-link").click(function(){
        if ("#event-overlay") {
            $("#event-overlay").fadeOut("slow").remove();
        };
        url = $(this).attr('href');
        $.get(url, function(data){
            //$("body").append(data);
            var overlay = '<div id="event-overlay"></div>';
            $('body').append(overlay);
            $('#event-overlay').append(data);
            showediteventform();
        });
        return false;
    });
};

//close event box if you click outside of the box
//also removes event form for that event if it was open
function closeeventbox() {
    //Used to fade out event info box
    var mouse_is_inside_event_info = false;
    $("#event-overlay").hover(function(){
        mouse_is_inside_event_info=true;
    }, function(){
        mouse_is_inside_event_info=false;
    });

    //Fade out event info box if mouse is outside box
    $("body").click(function(){
        if(!mouse_is_inside_event_info) {
            $("#event-overlay").fadeOut("slow").remove();
            //$("#edit_event_div").empty();
        }
    });
};

function reloadonsubmit() {
    $(".event_submit").click(function() {
        window.location.reload(true);
    });
    return true;
};

function colorrecentevents() {
    $("a.event-link").each(function() {
        eventlink = $(this).attr('href');
        eventlink = eventlink.split('/');
        eventid = eventlink[eventlink.length-1];
        requesturl = "/events/recentevent/" + eventid;
        var recent = false;
        $.ajax({
            type: "GET",
            url: requesturl,
            success: function(data) {
                recent = eval(data);
                },
            async: false
        });
        if (recent) {
            $(this).css("background-color", "red");
        };
    });
};


/* Toby's code for creating a new coursem */




$(document).ready(function() {
    panelHandler();
    //showOverview();
    showResources();
    resourceHandler();
    calendarChangeMonth();
    subscribeHandler();

    /*
    $("a#new_resource").click(function() {
        shownewresourceform();
    });
    */

    shownewresourceform();

    eventinfo();
    closeeventbox();
    showneweventform();
    colorrecentevents();
})

