$(".btn-allergy").click(function(){
        
    $(this).addClass("active-btn");
    $(".btn-restaurant").removeClass("active-btn");
    $(".restaurant-search").addClass("nodisplay");
    $(".allergy-search").removeClass("nodisplay");

});

$(".btn-restaurant").click(function(){

    $(this).addClass("active-btn");
    $(".btn-allergy").removeClass("active-btn");
    $(".restaurant-search").removeClass("nodisplay");
    $(".allergy-search").addClass("nodisplay");

})



var sigungu;
var sigungu_length;

// $("#custom").click(function(){
//     if('<%=user_signed_in?%>'==="false"){
//         alert("로그인이 필요한 기능입니다.")
//     }
// });


$(".sido-select").click(function() {
var sido = $(this).val();

$.ajax({
    async : true,
    data : {sido : sido},
    type : "GET",
    url : "menus/getGungu",
    success : function(data){
        
        sigungu = data["sigungu_name"];
        if(sido != "전체"){
            sigungu_length = Object.keys(sigungu).length;
            var options = '';
            options += '<option value="' +"전체"+ '">' + "--전체선택--" + '</option>';
            for (var i = 0; i <sigungu_length; i++) {
                options += '<option value="' + sigungu[i]+'"'+'class='+'"sigungu-opt"'+'>' + sigungu[i] + '</option>';
            }

            $(".sigungu-select").html(options);
        }

    }
})
});

// $(".a-submit").click(function(){
//     if($(".origin-sido").val()=="시도"){
//          alert("시/도를 선택하세요");
//          return false;//alert 창 닫기.
//     }
// });

if('<%=user_signed_in?%>'=== "true"){
$("#custom").click(function(){
    if( $(this).children("#ct").html() == "내 알러지정보 불러오기")
    {      
        console.log("눌렀는데 왜안됨");
        $(".original-check").addClass("nodisplay");
        $("#myinfo").removeClass("nodisplay");
        $(".allergy-check").css('visibility','visible');
    
        $(this).children("#ct").html("되돌리기");
        
        $(".custom-sido").val($(".origin-sido").val());
        $(".custom-sigungu").val($(".origin-sigungu").val());
        
    }
    else
    {
        $(".original-check").removeClass("nodisplay");
        $("#myinfo").addClass("getinfo");
        $(this).children("#ct").html("내 알러지정보 불러오기");
        $(".origin-sido").val($(".custom-sido").val());
        $(".origin-sigungu").val($(".custom-sigungu").val());
        
    }
});
}

//페이지 뒤로 넘어가기 했을 시에 에러 수정.
var sido = $(".sido-select").val();

if(sido != "전체"){
$.ajax({
async : true,
data : {sido : sido},
type : "GET",
url : "menus/getGungu",
success : function(data){
    
    sigungu = data["sigungu_name"];
    if(sido != "전체"){
        sigungu_length = Object.keys(sigungu).length;
        var options = '';
        options += '<option value="' +"전체"+ '">' + "--전체선택--" + '</option>';
        for (var i = 0; i <sigungu_length; i++) {
            options += '<option value="' + sigungu[i]+'"'+'class='+'"sigungu-opt"'+'>' + sigungu[i] + '</option>';
        }

        $(".sigungu-select").html(options);
    }

}
});
} 
//에러 수정 끝