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
                button.prop("value",newvalue);
            },
            function fail(data){
                alert (data.status);
            });
    });
}

/* -- Panel Display -- */
function tabs_handler() {
    $('#sub_button').each(function() {
        var id = $(this).attr('coursem_id');
        var active_tab = 'active_tab'+id;
        if ($.cookie(active_tab) == "overview") {
            showOverview();
        } else if ($.cookie(active_tab) == "resources") {
            showResources();
        } else if ($.cookie(active_tab) == "calendar") {
            showCalendar();
        } else {
            $.cookie(active_tab, 'announcements', { expires: 7, path: '/coursem' });
            showAnnouncements();
        }
    });
}

function panelHandler() {
    $('#sub_button').each(function() {
        var id = $(this).attr('coursem_id');
        var active_tab = 'active_tab'+id;
        $("#button_overview").on("click",function() {
            $.cookie(active_tab, 'overview', { expires: 7, path: '/coursem' });
            showOverview();
        });
        $("#button_resources").on("click",function() {
            $.cookie(active_tab, 'resources', { expires: 7, path: '/coursem' });
            showResources();
        });
        $("#button_announcements").on("click", function() {
            $.cookie(active_tab, 'announcements', { expires: 7, path: '/coursem' });
            showAnnouncements();
        });
        $("#button_calendar").on("click", function() {
            $.cookie(active_tab, 'calendar', { expires: 7, path: '/coursem' });
            showCalendar();
        });
        return true;
    });
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

function showAnnouncements() {
    $(".panels").hide();
    $("#panel_announcements").show();
    $(".header_button").removeClass("selected");
    $("#button_announcements").addClass("selected");
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
                table.hide();
            }
        });

    });
    return false;
}

/*********RESOURCE RELATED FUNCTIONS *******************/

function show_all_resources() {
    $(".semesters").each(function() {
        $(this).mouseover(function(){
          $(this).css("color","rgb(40,100,255)");
        });
        $(this).mouseout(function(){
          $(this).css("color","black");
        });
        $(this).click(function() {
            var id = $(this).attr('id');
            var select = "#resources" + id;
            $(select).toggle();
        });
    });
}

function shownewresourceform() {
    $("a#new_resource").click(function() {
        if (!($("#new_resource_div").is(":empty"))) {
            $("#new_resource_div").toggle();
        } else {
            url = $(this).attr('href');
            $.get(url, function(data){
                $("#new_resource_div").append(data).addClass('well');
                $('form#new_resource_form').on('ajax:success', function(data, status, xhr) {
                        handle_create_resources_response(status);
                    })
                                .on('ajax:error', function(xhr, status, error) {alert("There is a problem!");});
            });
        }
        return false;
    });
};

function handle_create_resources_response(data) {
  if( data.errCode == 1 ) {
     alert("Congratulations! You just earned 1 karma!");
     location.reload();
  } else {
     $('#error_message_resource').html( get_message_for_errcode(data.errCode) );  
  }
};

function get_message_for_errcode(code) {
    var SUCCESS = 1
    var RESOURCE_EXIST = -1
    var BAD_RESOURCENAME = -2
    var BAD_LINK = -3
    if( code == BAD_RESOURCENAME) {
        return ("The name shouldn't be empty or a number. Please try again. ");
    } else if( code == BAD_LINK) {
        return ("The Link is invalid. Please try again. ");
    } else if( code == RESOURCE_EXIST) {
        return ("The resource is already existed. Can't be repost. ");
    } else {
        return ("Unknown error occured: " + code);
   }
}



/***********CALENDAR RELATED FUNCTIONS ****************/

function calendarChangeMonth() {
    $("a .ec-month-nav").click(function() {
        //$("#panel_calendar").show();
    });

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
                $("#new_event_div").append(data).addClass('well');
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
        location.reload();
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

$(document).ready(function() {
    panelHandler();
    //showOverview();
    //showResources();
    //showAnnouncements();
    tabs_handler();
    resourceHandler();
    calendarChangeMonth();
    subscribeHandler();

    shownewresourceform();

    eventinfo();
    closeeventbox();
    showneweventform();
    colorrecentevents();
    show_all_resources();
})

