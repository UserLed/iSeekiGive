$(document).ready(function(){
    $("a.fancybox").fancybox({});

    $("a.modal_popup").fancybox({
        modal: true,
        autoDimensions: false
    }).trigger("click");

});