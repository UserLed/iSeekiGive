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
        if($('#change_majors_YES').is(':checked')) {
            $(".desc-changing-majors").show();
        }
        else
        {
            $("#desc_changing_majors").val("");
            $(".desc-changing-majors").hide();
        }
    });
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