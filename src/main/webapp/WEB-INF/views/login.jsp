<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
</head>
<body>
<script type="text/javascript">
function loginValidate(f)
{
	if(f.id.value==""){
		alert("아이디를 입력하세요");
		f.id.focus();
		return false;
	}
	if(f.pass.value==""){
		alert("패스워드를 입력하세요"); 
		f.pass.focus();
		return false;
	} 
}
</script>
<div class="container"> 
	<h3>관리자 로그인</h3> 
	<c:choose>
		<c:when test="${not empty sessionScope.siteUserInfo }">
			<div class="row" style="border:2px solid #cccccc;padding:10px;">			
				<h4>관리자 아이디:${sessionScope.siteUserInfo.id }</h4>
				<h4>관리자명:${sessionScope.siteUserInfo.name }</h4>
				&nbsp;&nbsp;&nbsp;&nbsp;<br />
				<button class="btn btn-primary" 
					onclick="location.href='listM';">
					데이터 현황</button>
					&nbsp;&nbsp;
					<button class="btn btn-danger" 
					onclick="location.href='logout';">
					로그아웃</button>
			</div>
		</c:when>
		<c:otherwise>
			<span style="font-size:1.5em; color:red;">${LoginNg }</span>
			<form name="loginForm" method="post" action="./loginAction" onsubmit="return loginValidate(this);">
				<input type="hidden" name="backUrl" value="${param.backUrl }"/>
				<!-- tabindex : 해당 속성은 input폼에서 tab키로 포커스를
					이동할 때의 순서를 지정하게 된다.
				-->
				<table class="table-bordered" style="width:50%;">
					<tr>
						<td><input type="text" class="form-control" name="id" placeholder="아이디" tabindex="1"></td>
						<td rowspan="2" style="width:80px;"><button type="submit" class="btn btn-primary" style="height:77px; width:77px;"  tabindex="3">로그인</button></td>
					</tr>
					<tr>
						<td><input type="password" class="form-control" name="pass" placeholder="패스워드" tabindex="2"></td>
					</tr>
				</table>
			</form>
		</c:otherwise>
	</c:choose>
</div>
</body>

</html>