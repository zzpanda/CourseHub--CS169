$(document).ready(function() {


    $("#event_start_date").datepicker({
        dateFormat: "yy-mm-dd"
    });
    $("#event_start_time").timepicker();
    $("#event_end_date").datepicker({
        dateFormat: "yy-mm-dd"
    });
    $("#event_end_time").timepicker();


})