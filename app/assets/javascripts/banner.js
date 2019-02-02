$(document).ready(function(){
    var height =  $("#banner1").height(); //공지사항의 높이값을 구해주고~~
    var num = $(".rolling li").length; // 공지사항의 개수를 알아볼수 있어요! length라는 것으로!
    var max = height * num; //그렇다면 총 높이를 알 수 있겠죠 ?
    var move = 0; //초기값을 설정해줍니다.
    function noticeRolling(){
        move += height; //여기에서 += 이라는 것은 move = move + height 값이라는 뜻을 줄인 거에요.
        $(".rolling").animate({"top":-move},600,function(){ // animate를 통해서 부드럽게 top값을 올려줄거에요.
            if( move >= max ){ //if문을 통해 최대값보다 top값을 많이 올렸다면 다시 !
                $(this).css("top",0); //0으로 돌려주고~
                move = 0; //초기값도 다시 0으로!
            };
        });
    };
    noticeRollingOff = setInterval(noticeRolling,3000); //자동롤링답게 setInterval를 사용해서 1000 = 1초마다 함수 실행!!
    $(".rolling").append($(".rolling li").first().clone()); //올리다보면 마지막이 안보여서 clone을 통해 첫번째li 복사!

    $(".rolling_stop").click(function(){
        clearInterval(noticeRollingOff); //stop을 누르면 clearInterval을 통해 자동롤링을 해제합니다.
    });
    $(".rolling_start").click(function(){
        noticeRollingOff = setInterval(noticeRolling,1000); //다시 start를 누르면 자동롤링이 실행하도록 !!
    });
});		