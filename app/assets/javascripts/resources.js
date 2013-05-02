function handle_login_response(data) {
    if( data.errCode == 0 ) {
           alert( 'There was a problem connecting to the server');
    }
    location.reload();
}
//$("#save_button").click(function(){
function handle_save(resource_id) {
    var comments = document.getElementById("comment_box").value;
    json_save_comment("/resources/addComment", { comment: comments, resource_id: resource_id },
        function(data) { return handle_login_response(data); }, function(err) { alert('error occurred on request')
        ; });
}


function json_save_comment(page, dict, success, failure) {
    $.ajax({
        type: 'POST',
        url: page,
        data: JSON.stringify(dict),
        contentType: "application/json",
        dataType: "json",
        success: success,
        failure: failure
    });
}

function favorite_listener() {
    $('table#favorite tr').find('td.col_addFavorite').each(function() {
        var input = $(this).find('input');
        var resourceid = input.attr('id');
        $.post('/resources/check', 
            {
                resource_id: resourceid
            },
            function(data){
                if (data == true) {
                    input.val('Delete Favorite');
                } else {
                    input.val('Add To Favorite');
                }
            }
        );

        
        $(input).click(function() {
            var json_sending;
            if (resourceid !== null) {
                var newbuttontext
                var path
                if (input.val() == "Add To Favorite"){
                    newbuttontext = "Delete Favorite";
                    path = "/users/addFavorite"
                }else {
                    newbuttontext = "Add To Favorite"
                    path = "/users/deleteFavorite"

                }
                json_sending = {
                    resource_id: resourceid
                };
                json_request(path, json_sending,
                function(data) {
                    input.val(newbuttontext);
                },
                function(data) {
                    return alert(data.status);
                });
            }
        });
    });
}

function flag_listener() {
    $('table#resource_description tr').find('td.col_flag').each(function() {
        var button = $(this).find('button');
        var resourceId = button.attr('id');

        $(button).click(function() {
            var json_sending;
            if (resourceId !== null) {
                var newbuttonsrc;
                var path;
                if (button.find('img').attr('src') == "/assets/white.png"){
                    newbuttonsrc= "/assets/red.png";
                    path = "/resources/flag"
                }else {
                    newbuttonsrc = "/assets/white.png"
                    path = "/resources/unflag"

                }
                json_sending = {
                    resource_id: resourceId
                };
                json_request(path, json_sending,
                function(data) {
                    button.find('img').attr("src", newbuttonsrc);
                },
                function(data) {
                    return alert(data.status);
                });
            }
        });
    });

}

$(document).ready(function() {
    favorite_listener();
    flag_listener();
})
