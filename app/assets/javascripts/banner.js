
function tick(){
    $("#rolling-list li:first").slideUp(function (){
        $(this).appendTo($('#rolling-list')).slideDown();
    });
}
setInterval(function(){tick()}, 3500);


$(window).on('scroll', function(){
    scrollTop = $(window).scrollTop();
    if(scrollTop >= 40){ //밑에 있을 때
        $('.holder').css('position', 'fixed')
    }else{//위에 있을 때
        $('.holder').css('position', 'relative')
    }
});

