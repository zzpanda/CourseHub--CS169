test('assertions', function() {
    equal( 1, 1, 'one equals one');
})

/*
module ("")
test ('toggle new resource form', function() {
    var $fixture = $( "#qunit-fixture" );
    $fixture.append("<a id='new_resource' href='www.google.com'>Not Empty</a>");


})
*/
module("datetimepickers", {
    setup: function () {
        $("#qunit-fixture").append("<div id='thing'>hello</div>");
    },teardown: function() {
        $("#qunit-fixture").empty();
    }
});

/*
test("datepicker is called",function() {
    equal($("#thing").text(), "hello");

});
*/