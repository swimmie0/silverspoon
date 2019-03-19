$(document).ready(function() {
    $(".restaurant-name-field").keyup(function() {
        var keyvalue = $(this).val();
        $.ajax({
            async : true,
            data : {key: keyvalue},
            type : "POST",
            url : "zizuminfos/getZizum",
        })

        // var k = $(this).val();
        // $("#user-table > tbody > tr").hide();
        // var temp = $("#user-table > tbody > tr > td:nth-child(5n+2):contains('" + k + "')");

        // $(temp).parent().show();
    })
})

// $.ajax({
//     async : true,
//     data : {sido : sido},
//     type : "GET",
//     url : "menus/getGungu",
//     success : function(data){
        
//         sigungu = data["sigungu_name"];
//         if(sido != "전체"){
//             sigungu_length = Object.keys(sigungu).length;
//             var options = '';
//             options += '<option value="' +"전체"+ '">' + "--전체선택--" + '</option>';
//             for (var i = 0; i <sigungu_length; i++) {
//                 options += '<option value="' + sigungu[i]+'"'+'class='+'"sigungu-opt"'+'>' + sigungu[i] + '</option>';
//             }

//             $(".sigungu-select").html(options);
//         }

//     }
// })