$(document).ready(function(){
    $('ul.nav-tabs > li').click(function(){
        $('.field_edit').show();
        $('.field_text').show();
        $('.field_form').hide();
    });

    $('.close-popup').click(function(){
        parent.$.fancybox.close();
    });

    $(".change-majors").click(function(){
        change_majors();
    });

    $(".another-location").click(function(){
        another_locations();
    });

    change_majors();
    another_locations();
});

$(document).on('click', '.btn-edit', function(){
    $('.btn-edit').hide();
    $(this).parent().parent(".info-container").hide();
    $(this).parent().parent().next('.form-container').show();
});

$(document).on('click', '.cancel', function(){
    $('.btn-edit').show();
    $('.info-container').show();
    $('.form-container').hide();
});

function change_majors(){
    if($('#game_change_major_1').is(':checked')) {
        $(".desc-changing-majors").show();
    }
    else
    {
        $("#game_study_majors").val("");
        $(".desc-changing-majors").hide();
    }
}

function another_locations(){
    if($('#game_another_locations_1').is(':checked')) {
        $(".localtion-list-field").show();
    }
    else
    {
        $("#game_locations").val("");
        $(".localtion-list-field").hide();
    }
}