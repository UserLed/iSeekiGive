$(document).ready(function(){
    $("a.fancybox").fancybox({
        });

    $("a.dashboard_popup").fancybox({
        autoDimensions: false,
        height: 320,
        width: 400
    });
    $('.dashboard_popup').click();

    $("a.profile_popup").fancybox({
        autoDimensions: false,
        height: 220,
        width: 400
    });
    $('.profile_popup').click();
});