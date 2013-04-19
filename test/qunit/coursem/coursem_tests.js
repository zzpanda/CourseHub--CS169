module ("show new resource form", {
    setup: function() {
        var fixture = $( "#qunit-fixture");
        fixture.append("<a id='new_resource' href='/resources/createnewresource'></a>");
        fixture.append("<div id='new_resource_div'></div>");
        $.mockjax({
            url: '/resources/createnewresource',
            responseText:'<div>The response would be a partial for a html form<div>'
        });
    }, teardown: function() {
        var fixture = $("#qunit-fixture");
        fixture.empty();
    }
});

    asyncTest ('create new resource form', 1, function() {
        setTimeout(function() {
            $.ajax({
                url: '/resources/createnewresource',
                success: function(data) {
                    $('#new_resource_div').text(data);
                }
            });
            equal($('#new_resource_div').text(), '<div>The response would be a partial for a html form<div>', "ajax data appended");
            start();
        });
    });


    asyncTest ('if form has already been created, toggle', 1 , function() {
        $("#new_resource_div").text("Div no longer empty - this text is a pretend form");
        $("#new_resource_div").show();
        setTimeout(function() {
            shownewresourceform();
            equal( $("#new_resource_div").css('display'), "none", "shows form if it was hidden");
            start();
        });
    });

    asyncTest ('if form has already been created, hide it if it was showing', 1 , function() {
         $("#new_resource_div").text("Div no longer empty - this text is a pretend form");
         $("#new_resource_div").hide();
        setTimeout(function() {
            shownewresourceform();
            equal( $("#new_resource_div").css('display'), "block", "hides form if it was showing");
            start();
        });
    });

var tabs = "<div id='tabs'><ul>" +
    "<li id='button_overview' class='header_button'>Overview</li>" +
    "<li id='button_resources' class='header_button'>Resources</li>" +
    "<li id='button_statistics' class='header_button'>Statistics</li>" +
    "<li id='button_calendar' class='header_button selected'>Calendar</li>" +
    "</ul></div>";

module ("panelHandler() tests", {
    setup: function() {
        var fixture = $("#qunit-fixture");
        fixture.append(tabs);
    }, teardown: function() {
        var fixture = $("#qunit-fixture");
        fixture.empty();
    }
});

    // 1 means one exception, start() resumes tests after asynchronous panelHandler() is done
    asyncTest ("panelHandler()", 1, function() {
        setTimeout(function() {
            ok( panelHandler(),  "panelHandler() returned");
            start();
        });
    });

module ("panel and tabs tests", {
    setup: function() {
        var fixture = $("#qunit-fixture");
        fixture.append(tabs);
        fixture.append("<div id='panel_description' class='panels'>");
        fixture.append("<div id='panel_resources' class='panels'>");
        fixture.append("<div id='panel_calendar' class='panels'>");
    }, teardown: function() {
        var fixture = $("#qunit-fixture");
        fixture.empty();
    }
});

    test ("showOverview()", function() {
        showOverview();
        equal($('#panel_description').is(':visible'), true, 'the description panel is visible');
        equal($('#button_overview').hasClass('selected'), true, 'the overview button tab is selected');
    });

    test ("showResources()", function() {
        showResources();
        equal($('#panel_resources').is(':visible'), true, 'the resources panel is visible');
        equal($('#button_resources').hasClass('selected'), true, 'the resources button tab is selected');
    });

    test ("showCalendar()", function() {
        showCalendar();
        equal($('#panel_calendar').is(':visible'), true, 'the calendar panel is visible');
        equal($('#button_calendar').hasClass('selected'), true, 'the calendar button tab is selected');
    });


module ("reloadonsubmit()", {
    setup: function() {
        var fixture = $("#qunit-fixture");
        fixture.append("<input class='event_submit' type='submit'>");
    }, teardown: function() {
        var fixture = $("#qunit-fixture");
        fixture.empty();
    }
});

    //A lousy test. How to check window actually reloaded?
    asyncTest ("reloadonsubmit()", 1, function() {
        setTimeout(function() {
            ok(reloadonsubmit(), "reloadonsubmit() returned true");
            start();
        });
    });

/* Doesn't work because datepicker() and timepicker() not in scope
module("datetimepickers", {
    setup: function () {
        $("#qunit-fixture").append("<input id='event_start_date'>");
        $("#qunit-fixture").append("<input id='event_start_time'>");
        $("#qunit-fixture").append("<input id='event_end_date'>");
        $("#qunit-fixture").append("<input id='event_end_time'>");
    },teardown: function() {
        $("#qunit-fixture").empty();
    }
});

    test("datetimepicker is called",function() {
        datetimepickers();
        assert($("#ui-datepicker-div").exists(), "The datepicker div exists");
    });
*/
