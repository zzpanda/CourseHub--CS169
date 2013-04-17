

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

function calendarChangeMonth() {
    $("a .ec-month-nav").click(function() {
        //$("#panel_calendar").show();
    });

    showCalendar();
}

$(document).ready(function() {
    panelHandler();
    //showOverview();
    showResources();
    resourceHandler();
    calendarChangeMonth();
    subscribeHandler();

    $("#event_form").hide();
    $("#event_form_paragraph").click(function() {
        $("#event_form").show();
    });
    $("#event_submit").click(function(){
        //$("#event_form").hide();
        location.reload();
    });
    $("#event_start_date").datepicker({
        dateFormat: "yy-mm-dd"
    });
    $("#event_start_time").timepicker();
    $("#event_end_date").datepicker({
        dateFormat: "yy-mm-dd"
    });
    $("#event_end_time").timepicker();


});

