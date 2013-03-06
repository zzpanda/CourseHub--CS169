/* Takes a dictionary to be JSON encoded, calls the success
 function with the diction decoded from the JSON response.*/
function json_request(page, dict, success, failure) {
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

debug_flag = false;

