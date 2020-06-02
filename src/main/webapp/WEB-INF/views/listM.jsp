<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>관리자모드</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
</head>
<body>	
<script>
function deleteRow(idx){
	location.href='deleteM?idx='+idx;	
}
</script>
<div class="container">
	<h1 class="text-center">User Log</h1>
	<br />
	
<div class="row">
  		<div class="col-sm-5 col-xl-5">
		  	<form name="searchForm">
		  	<div class="input-group mb-3">		
		  		<select name="searchColumn" id="searchColumn" class="form-control">
		  			<option value="loc">지역</option>
		  			<option value="utime">시간</option>
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
					<h4 class="media-heading">시간:${row.utime }</h4>
					<p>지역 : ${row.loc }</p>
					<c:choose>
				      	<c:when test = "${row.today == '1' }">
				      	     <p>당일 날씨 : 맑음</p>
				        </c:when>
				        <c:otherwise>
				        	<p>당일 날씨 : 흐림</p>
				        </c:otherwise>
				    </c:choose>
					<c:choose>
				      	<c:when test = "${row.tomorrow == '1' }">
				      	     <p>익일 날씨 : 맑음</p>
				        </c:when>
				        <c:otherwise>
				        	<p>익일 날씨 : 흐림</p>
				        </c:otherwise>
				    </c:choose>				
				</div>	  
				<!--  수정,삭제버튼 -->
				<div class="media-right">
					<button class="btn btn-danger" onclick="javascript:deleteRow(${row.idx});">삭제</button>					
				</div>
			</div>
		</div>	 
	</c:forEach>	
	<!-- 방명록 반복 부분 e -->
	<table class="pagination justify-content-center">
		<tr>
			<td>${pagingImg }</td>
		</tr>
	</table>
</div>
</body>
</html>
