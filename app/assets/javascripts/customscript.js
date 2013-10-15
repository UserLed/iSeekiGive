// 1. Header - Search Givers Autocomplete
// 2. Signup Email Checker
// 3. Date Picker Configuration
// 4. Profile - Locations autocomplete (tagit)
// 5. Keywords Add/Edit/Delete
// 6. Perspectives


// 1. Header - Search Givers Autocomplete

$(function () {
    $("#search_keywords").autocomplete({
        minLength: 2,
        source: '/search-users.json',
        select: function (event, ui) {
        event.preventDefault();
        window.location.href = "/users/" + ui.item.user_id + "/public_profile"
        }
        })
    .data("ui-autocomplete")._renderItem = function (ul, item) {
        return $("<li class='giver-search-result'></li>")
        .append(itemFormatResult(item))
        .appendTo(ul);
    };
});

function itemFormatResult(item) {
    var markup = "<a href='" + "/users/" + item.user_id + "/public_profile'>";
    markup += "<div class='result-profile-pic'><img class='img-circle' src = " + item.icon + "></div>";
    markup += "<div class='result-description'>";
    markup += "<div class='result-title'>" + item.name + "</div>";
    markup += "<div class='result-location'>" + item.location + "</div>";
    markup += "<div class='result-info'>" + item.companies + "</div>";
    markup += "<div class='result-info'>" + item.educations + "</div>";
    markup += "</div><div class='clearfix'></div></a>";
    return markup;
}


// 2. Signup Email Checker

function password_check(input) {
    if (input.value != document.getElementById('user_password').value) {
        input.setCustomValidity('The two passwords must match.');
    } else {
        // input is valid -- reset the error message
        input.setCustomValidity('');
    }
}

$(function () {
    $("input#user_email").blur(function () {
        var email = $("#user_email").val();
        var filter = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
        if (filter.test(email)) {
            $.ajax({
                url: "/email_checker",
                type: "POST",
                data: {
                    email: email
                },
                dataType: "script",
                beforeSend: function (jqXHR, settings) {
                    jqXHR.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
                },
                error: function () {
                // alert("An error ocurred");
                },
                success: function () {

                }
            });
        } else {
            $("#email_error").html("Invalid Email.");
        }
    });
});


// 3. Date Picker Configuration

/* Update datepicker plugin so that MM/DD/YYYY format is used. */
$.extend($.fn.datepicker.defaults, {
    parse: function (string) {
        var matches;
        if ((matches = string.match(/^(\d{2,2})\/(\d{2,2})\/(\d{4,4})$/))) {
            return new Date(matches[3], matches[1] - 1, matches[2]);
        } else {
            return null;
        }
    },
    format: function (date) {
        var
        month = (date.getMonth() + 1).toString(),
        dom = date.getDate().toString();
        if (month.length === 1) {
            month = "0" + month;
        }
        if (dom.length === 1) {
            dom = "0" + dom;
        }
        return month + "/" + dom + "/" + date.getFullYear();
    }
});

$('#datepicker').datepicker();


// 4. Profile - Locations autocomplete (tagit)

$(function(){
    $("#new_user #user_location").autocomplete({
        delay: 0,
        minLength: 2,
        source: '/locations.json'
    });
});

$(function(){
    $("#locations").tagit({
        requireAutocomplete: true,
        autocomplete: {
            delay: 0,
            minLength: 2,
            source: '/locations.json'
        },
        placeholderText: "Type here",
        allowSpaces : true
    });
    
});


$(function(){
    $("#add-language").click(function(){
        $(".language-field").toggle();
    });

    $("#submit-language").click(function(){
        var language = $("input#language").val();
        $.ajax({
            url: "languages",
            type: "POST",
            data: {
                name: language
            },
            dataType: "script",
            beforeSend: function (jqXHR, settings) {
                jqXHR.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
            }
        });
    });
});


// 5. Keywords Add/Edit/Delete

$(document).on('click', '.btn-edit', function(){
    $(this).hide();
    $(this).parent().parent(".info-container").hide();
    $(this).parent().parent().next('.form-container').show();
});

$(document).on('click', '.cancel', function(){
    $('.btn-edit').show();
    $('.info-container').show();
    $('.form-container').hide();
});

// 6. Perspectives

$(document).ready(function(){
    $("#the_good_selector").click(function(){
        $("#perspective_story_type").val("The Good");
    });
    $("#the_bad_selector").click(function(){
        $("#perspective_story_type").val("The Bad");
    });
    $("#the_ugly_selector").click(function(){
        $("#perspective_story_type").val("The Ugly");
    });
});


$(function () {
    $.getJSON("/user_tags", function (data) {
        var temp_tags = [];
        $("#perspectives_keywords").tagit({
            availableTags: data,

            afterTagAdded: function (event, ui) {
                temp_tags.push(ui.tagLabel);
            //data.push(_.last(temp_tags));
            //console.log(data);
            },
            afterTagRemoved: function (event, ui) {
                if (_.indexOf(temp_tags, ui.tagLabel) != (-1)) {
                    data.splice(_.indexOf(data, ui.tagLabel), 1);
                //  console.log(data);
                }
            },
            allowSpaces: true
        });
    });
});

$(function () {
    $(".story").readmore({
        maxHeight: 60
    });
});