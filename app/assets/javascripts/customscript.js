// 1. Header - Search Givers Autocomplete

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