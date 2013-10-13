// 1. Header - Search Givers Autocomplete





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