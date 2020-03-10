<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<title>Home</title>
</head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script>
$(function(){	
	// 저장된 쿠키값을 가져온다. 없으면 공백으로 들어감.
    var location1 = getCookie("location1");
    var location2 = getCookie("location2");
    var location2 = getCookie("location3");
    $("input[name='location1']").val(location1);
    $("input[name='location2']").val(location2);
    $("input[name='location3']").val(location3);
     
     
    $("#location").change(function(){ // 체크박스에 변화가 있다면,
        if($("#location").is(":checked")){ // 체크했을 때,
            var location1 = $("input[name='location1']").val();
            var location2 = $("input[name='location2']").val();
            var location3 = $("input[name='location3']").val();
            setCookie("location1", location1, 365); // 1년 동안 쿠키 보관
            setCookie("location2", location2, 365); 
            setCookie("location3", location3, 365); 
            alert(location1)
        }else{ // 체크 해제 시,
            deleteCookie("location1");
            deleteCookie("location2");
            deleteCookie("location3");
        }
    });    
});

</script>
<body>

<input type="checkbox" id="location"/>
<input type="text" name="location1"/>
<input type="text" name="location2"/>
<input type="text" name="location3"/>



</body>
</html>
