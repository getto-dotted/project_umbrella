<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<title>Home</title>
</head>
<script>	
	function setCookie(){			
		var name1 = document.getElementById("location1").value;		
		document.cookie = 'location1='+name1+';expires=1;';
		}; 
	
	function getCookie(){		
		alert(document.cookie);		
		};
		
	function deleteCookie(name){
		document.cookie = name + '=; expires=Thu, 01 Jan 1999 00:00:10 GMT;';
		};
</script>
<body>

<input type="checkbox" id="location"/>
<input type="text" id="location1"/>
<input type="text" name="location2"/>
<input type="text" name="location3"/>

<input type="button" value="버튼0000" onclick="setCookie()">
<input type="button" value="버튼1111" onclick="getCookie()">
<!-- setCookie(변수이름, 변수값, 기간);
	setCookie("expend", "true", 1);
getCookie(변수이름)
	var is_expend = getCookie("expend");
	console.log("쿠키 is_expend변수에 저장된 값: "+is_expend);
deleteCookie(변수이름)
	deleteCookie('name');
 -->
</body>
</html>
