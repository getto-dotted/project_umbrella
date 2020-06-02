
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>사용후기</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
</head>
<body>	
<script>
function deleteRow(idx,pass){
	
	var input = prompt('비밀번호를 입력해 주세요');
	if(input == pass){
		location.href='delete?idx='+idx+'&pass='+pass;		
	}
	
}
</script>
<div class="container">
	<h1 class="text-center">사용후기</h1>
	<br />
	
<div class="row">
  		<div class="col-sm-5 col-xl-5">
		  	<form name="searchForm">
		  	<div class="input-group mb-3">		
		  		<select name="searchColumn" id="searchColumn" class="form-control">
		  			<option value="name">작성자</option>
		  			<option value="content">내용</option>
		  		</select>  		
				<input type="text" class="form-control" placeholder="검색어입력"
					name="searchWord" id="searchWord">				
				<div class="input-group-append">
				  <button class="btn btn-success" type="submit">검색</button>
				</div>
			</div>
			</form>  		
  		</div>
  		<div class="col-sm-7 col-xl-7">
			<div class="text-right"><!-- https://project--umbrella-susos.run.goorm.io/ -->
				<button class="btn btn-warning"	onclick="location.href='/umbrella';">
					오늘 우산 필요해?
				</button>
				&nbsp;&nbsp;
				<button class="btn btn-danger"	onclick="location.href='list';">
					사용후기 리스트
				</button>
				&nbsp;&nbsp;
				<button class="btn btn-success"	onclick="location.href='write';">
					사용후기 작성
				</button>
			</div>  		
  		</div>
  	</div>

		
	<!-- 방명록 반복 부분 s -->

		<c:forEach items="${lists }" var="row">	 
		<div class="border mt-2 mb-2">
			<div class="media">
				<div class="media-left mr-3">
					<img src="<%= request.getContextPath()%>/images/img_avatar3.png" class="media-object" style="width:60px">
				</div>
				<div class="media-body">
					<h4 class="media-heading">작성자:${row.name }</h4>
					<p>${row.content }</p>
				</div>	  
				<!--  수정,삭제버튼 -->
				<div class="media-right">
					<button class="btn btn-primary" onclick="location.href='modify?idx=${row.idx}';">수정</button>
					<button class="btn btn-danger" onclick="javascript:deleteRow(${row.idx}, ${row.pass });">삭제</button>					
				</div>
			</div>
		</div>	 
	</c:forEach>	
	<!-- 방명록 반복 부분 e -->
	<ul class="pagination justify-content-center">${pagingImg }</ul>
</div>
</body>
</html>
