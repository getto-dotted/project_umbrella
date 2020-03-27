<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.net.URLEncoder"%>
<!DOCTYPE html>
<html>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<head>

  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>B Ω ?</title>

  <!-- Bootstrap core CSS -->
  <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

  <!-- Custom styles for this template -->
  <link href="css/small-business.css" rel="stylesheet">

</head>
<script>
	window.onload = function(){	  
	    var Cookies = document.cookie;
	    var ca = Cookies.split(';');	
	    
	    for(var i = 0; i <ca.length; i++){		    	
	    	var i2 = i+1;	    	
	    	var name = "location"+i2+"=";	
	    	var re1 = new RegExp('location1');
	    	var re2 = new RegExp('location2');
	    	var re3 = new RegExp('location3');
	    	var c = unescape(ca[i]);    	
	    	
	    	if(re1.test(ca[i])){
	    		var ccc = c.substring(name.length, c.length).replace('=','');	    		
	    		document.getElementById('location1').innerHTML = ccc;
	    	}  	
	    	else if(re2.test(ca[i])){
	    		var ccc = c.substring(name.length, c.length).replace('=','');	    		
	    		document.getElementById('location2').innerHTML = ccc;
	    	}  	
	    	else if(re3.test(ca[i])){
	    		var ccc = c.substring(name.length, c.length).replace('=','');	    		
	    		document.getElementById('location3').innerHTML = ccc;
	    	};   	
	    };
	};
	
	function nameSub(num){//주소카드에 저장된 이름을 검색에 필요한 부분만 전송준비
		var q = document.getElementById('location'+num).innerHTML;		
		var re = new RegExp('군$');
		var arrState = ['경기', '강원', '경북', '경남', '충남', '충북', '전남', '전북'];
		var y = q.split(' ');
		
		if(y[0]=='광주'){			
			apiCall(y[0],q);
		}
		else if(re.test(y[1])){			
			apiCall(y[1],q);
		}
		else if(arrState.includes(y[0]) == true){			
			apiCall(y[1],q);
		}else{			
			apiCall(y[0],q);
		}; 		
	};
	
	function apiCall(name,loc){
		if(name == '우리집' | name == '직장' | name == '관심가는'){
			alert('먼저 주소지를 설정해주세요.');
			return false;
		}		
		document.getElementById('apiName').value = name;
		document.getElementById('loc').value = loc;
		document.getElementById('findForm').submit();			
	};
	
	function daumZipFind(num){
	    new daum.Postcode({
	        oncomplete: function(data) {
	        	var f = document.addressForm;	
				var h = data.address;	 	        	
				var date = new Date();
                date.setTime(date.getTime() + 999*24*60*60*1000);
	        	document.getElementById('location'+num).innerHTML= h;
	        	document.cookie = 'location'+num+"="+escape(h)+"; expires=" + date.toUTCString() + ';';
	        }
	    }).open();
	};
</script>
<body>
<!-- Navigation -->
  <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
    <div class="container">
      <a class="navbar-brand" href="https://project-umbrella-itwfk.run.goorm.io/">오늘 우산 필요해?</a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarResponsive">   
        <ul class="navbar-nav ml-auto">
          <li class="nav-item active"><!-- https://project--umbrella-susos.run.goorm.io/ -->
            <a class="nav-link" href="http://localhost:8282/umbrella/list">사용후기
              <span class="sr-only">(current)</span>
            </a>
          </li>          
        </ul>
      </div>
    </div>
  </nav>

  <!-- Page Content -->
  <div class="container"> 
    <!-- Heading Row -->
    <div class="row align-items-center my-5">
      <div class="col-lg-6"> 
      <c:choose>
      	<c:when test = "${today == 'sunny' }">     
        <img class="img-fluid rounded mb-4 mb-lg-0" src="<%= request.getContextPath()%>/images/tomorrow_sunny.jpg" alt="">
        </c:when>
        <c:otherwise>
        <img class="img-fluid rounded mb-4 mb-lg-0" src="<%= request.getContextPath()%>/images/tomorrow_rainy.jpg" alt="">
        </c:otherwise>
       </c:choose>
      </div>
      <!-- /.col-lg-8 -->
      <div class="col-lg-6">
      	<c:choose>
      	<c:when test = "${tomorrow == 'sunny' }">     
        <img class="img-fluid rounded mb-4 mb-lg-0" src="<%= request.getContextPath()%>/images/today_sunny.jpg" alt="">
        </c:when>
        <c:otherwise>
        <img class="img-fluid rounded mb-4 mb-lg-0" src="<%= request.getContextPath()%>/images/today_rainy.jpg" alt="">
        </c:otherwise>
       </c:choose>        
      </div>      
    </div>
    <form action="weather.do" id='findForm'>    	
    	<input type="hidden" id="apiName" name="name" value=""/>
    	<input type="hidden" id="loc" name="loc" value=""/>
    </form>

    <!-- Content Row -->
    <div class="row">
      <div class="col-md-4 mb-5">
        <div class="card h-100">
          <div class="card-body" onclick="nameSub(1)" style="cursor:pointer"
          onMouseOver="this.style.background='yellow';" onMouseout="this.style.background='';">
            <h2 class="card-title" id='location1'>우리집</h2>
          </div>
          <div class="card-footer" align="center">
            <input type="button" value='주소설정하기'  onclick="daumZipFind(1)"/>
          </div>
        </div>
      </div>
      <!-- /.col-md-4 -->
      <div class="col-md-4 mb-5">
        <div class="card h-100">
          <div class="card-body" onclick="nameSub(2)" style="cursor:pointer"
          onMouseOver="this.style.background='yellow';" onMouseout="this.style.background='';">
            <h2 class="card-title" id='location2'>직장</h2>
          </div>
          <div class="card-footer" align="center">
            <input type="button" value='주소설정하기'  onclick="daumZipFind(2)"/>
          </div>
        </div>
      </div>
      <!-- /.col-md-4 -->
      <div class="col-md-4 mb-5">
        <div class="card h-100">
          <div class="card-body" onclick="nameSub(3)" style="cursor:pointer"
          onMouseOver="this.style.background='yellow';" onMouseout="this.style.background='';">
            <h2 class="card-title" id='location3'>관심가는 곳</h2>
          </div>
          <div class="card-footer" align="center">
            <input type="button" value='주소설정하기'  onclick="daumZipFind(3)"/>
          </div>
        </div>
      </div>
      <!-- /.col-md-4 -->

    </div>
    <!-- /.row -->

  </div>
  <!-- /.container -->

  <!-- Footer -->
  <footer class="py-5 bg-dark">
    <div class="container">
      <p class="m-0 text-center text-white">Copyright &copy; Umbrella Co.</p>
    </div>
    <!-- /.container -->
  </footer>

  <!-- Bootstrap core JavaScript -->
  <script src="vendor/jquery/jquery.min.js"></script>
  <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
</body>
</html>