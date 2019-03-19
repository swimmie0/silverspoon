
function tick(){
    $("#rolling-list li:first").slideUp(function (){
        $(this).appendTo($('#rolling-list')).slideDown();
    });
}
setInterval(function(){tick()}, 3800);


// $(window).on('scroll', function(){
//     scrollTop = $(window).scrollTop();
//     if(scrollTop >= 40){ //밑에 있을 때
//         $('.holder').css('position', 'fixed');
//         // $('.holder').addClass('holder-shadow', 800);
//     }else{//위에 있을 때
//         $('.holder').css('position', 'relative')
//         // $('.holder').removeClass('holder-shadow', 800);
//     }
// });

$(function () {
    var lastScrollTop = 0,
        delta = 30;
    $(window).scroll(function (event) {
        var st = $(this).scrollTop();
        if (Math.abs(lastScrollTop - st) <= delta) return;
        if ((st > lastScrollTop) && (lastScrollTop > 0)) {
            $(".holder").css("top", "-4.7rem");
        } else {
            $(".holder").css("top", "0px");
        }
        lastScrollTop = st;
    });
});  
