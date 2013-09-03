$(document).ready(function(){
    $('.field_edit').click(function(){
        $('.field_edit').hide();
        $(this).parent().parent().hide();
        $(this).parent().parent().next($('.field_form')).show();
    })

    $('.cancel').click(function(){
        $('.field_edit').show();
        $('.field_text').show();
        $('.field_form').hide();
    })
})