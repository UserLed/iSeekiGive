$(document).ready(function(){
    function hide_all_session_methods(){
        $('ul.session-methods li').hide();
    }

    function reset_all_session_methods(){
        $('.session-methods').find('input').val('');
    }

    function show_session_method(val){
        $('.session-method-'+val).show();
    }

    var default_session_method = $('.session-method').val();

    //alert(default_session_method);
    hide_all_session_methods();
    show_session_method(default_session_method);


    $('select.session-method').change(function() {
        var val = $(this).val();
        hide_all_session_methods();
        reset_all_session_methods();
        show_session_method(val);
    });
});
