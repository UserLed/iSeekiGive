$(document).ready(function(){
    $("a.fancybox").fancybox({
        });

    $("a.dashboard_popup").fancybox({
        autoDimensions: false,
        height: 303,
        width: 400
    });
    $('.dashboard_popup').click();
});