function handle_login_response(data) {
    if( data.errCode == 0 ) {
           alert( 'There was a problem connecting to the server');
    }
    location.reload();
}
//$("#save_button").click(function(){
function handle_save(resource_id) {
    var comments = document.getElementById("comment_box").value;
    var user_id = 1;
    json_save_comment("/resources/addComment", { comment: comments, user_id: user_id, resource_id: resource_id },
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
