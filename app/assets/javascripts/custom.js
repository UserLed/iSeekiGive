$(document).ready(function(){
    $('ul.nav-tabs > li').click(function(){
        $('.field_edit').show();
        $('.field_text').show();
        $('.field_form').hide();
    });

    $('.close-popup').click(function(){
        parent.$.fancybox.close();
    });

    $(".change-majors-yes").click(function(){
        if($(this).is(':checked')) {
            $(this).parent().parent(".control-group").next(".desc-changing-majors").show();
        }
    });
    
    $(".change-majors-no").click(function(){
        if($(this).is(':checked')) {
            var div = $(this).parent().parent(".control-group").next(".desc-changing-majors");
            div.children(".controls").children("textarea").val("");
            div.hide();
        }
    });

    $( ".change-majors-yes" ).each(function( index ) {
        if($(this).is(':checked')) {
            $(this).parent().parent(".control-group").next(".desc-changing-majors").show();
        }
    });

    $( ".change-majors-no" ).each(function( index ) {
        if($(this).is(':checked')) {
            var div = $(this).parent().parent(".control-group").next(".desc-changing-majors");
            div.children(".controls").children("textarea").val("");
            div.hide();
        }
    });


    $(".another-location").click(function(){
        another_locations();
    });
    another_locations();

});

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
