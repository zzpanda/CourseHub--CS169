
/*
module ("")
test ('toggle new resource form', function() {
    var $fixture = $( "#qunit-fixture" );
    $fixture.append("<a id='new_resource' href='www.google.com'>Not Empty</a>");


})
*/

module ("panel and tabs tests", {
    setup: function() {
        var tabs = "<div id='tabs'><ul>" +
            "<li id='button_overview' class='header_button'>Overview</li>" +
            "<li id='button_resources' class='header_button'>Resources</li>" +
            "<li id='button_statistics' class='header_button'>Statistics</li>" +
            "<li id='button_calendar' class='header_button selected'>Calendar</li>" +
            "</ul></div>";
        $("#qunit-fixture").append(tabs);
        $("#qunit-fixture").append("<div id='panel_description' class='panels'>");
        $("#qunit-fixture").append("<div id='panel_resources' class='panels'>");
        $("#qunit-fixture").append("<div id='panel_calendar' class='panels'>");
    }, teardown: function() {
        $("#qunit-fixture").empty();
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
