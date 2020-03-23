
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" 
	uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<title>Spring 답변형 게시판</title>
</head>
<body>	
<script type="text/javascript">
function writeValidate(f)
{
	if(f.name.value==""){
		alert("작성자 이름을 입력하세요");
		f.name.focus();
		return false;
	}
	if(f.contents.value==""){
		alert("내용을 입력하세요");
		f.contents.focus(); 
		return false;
	} 
	if(f.pass.value!=f.pass1.value){
		alert("비밀번호가 맞지 않습니다.");
		f.pass.focus(); 
		return false;
	} 
}
</script>
<div class="container">
	<h3>사용후기 - 
		<small>저희 서비스가 마음에 드셨거나 개선할 점을 남겨주세요</small></h3>
	
	<form name="writeFrm" method="post" 
		onsubmit="return writeValidate(this);"
		action="<c:url value="/modifyAction" />" >
	
	<!-- 수정할 게시물의 일련번호 -->		
	<input type="hidden" name="idx" value="${dto.idx }"/>
	<input type="hidden" name="pass1" value="${dto.pass }"/>
		
	<table class="table table-bordered">
	<colgroup>
		<col width="20%"/>
		<col width="*"/>
	</colgroup>
	<tbody>
		<tr>
			<th class="text-center" 
				style="vertical-align:middle;">작성자</th>
			<td>
				<input type="text" class="form-control" 
					style="width:100px;" name="name" 
						value="${dto.name }" />
			</td>
		</tr>		
		<tr>
			<th class="text-center" 
				style="vertical-align:middle;">비밀번호</th>
			<td>
				<input type="password" name="pass"/>
			</td>
		</tr>
		<tr>
			<th class="text-center" 
				style="vertical-align:middle;">내용</th>
			<td>
				<textarea rows="10" class="form-control" 
				name="contents">${dto.content }</textarea>
			</td>
		</tr>	
	</tbody>
	</table>
	
	<div class="row text-center" style="" align="center">
		<!-- 각종 버튼 부분 -->		
		<button type="submit" class="btn btn-danger">전송하기</button>
		<button type="reset" class="btn">다시 쓰기</button>
		<button type="button" class="btn btn-warning" 
			onclick="location.href='list';">리스트보기</button>
	</div>
	</form> 
</div>
</body>
</html>
