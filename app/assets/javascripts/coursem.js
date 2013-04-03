
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

$(document).ready(function() {
    panelHandler();
    //showOverview();
    showResources();
    resourceHandler();
});

