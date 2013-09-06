$(document).ready(function(){
    $('ul.nav-tabs > li').click(function(){
        $('.field_edit').show();
        $('.field_text').show();
        $('.field_form').hide();
    });

    $('.close-popup').click(function(){
        parent.$.fancybox.close();
    });
})

$(document).on('click', '.field_edit', function(){
    $('.field_edit').hide();
    $(this).parent().parent().hide();
    $(this).parent().parent().next($('.field_form')).show();
})

$(document).on('click', '.cancel', function(){
    $('.field_edit').show();
    $('.field_text').show();
    $('.field_form').hide();
})