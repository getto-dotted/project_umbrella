<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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

<body>
<!-- Navigation -->
  <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
    <div class="container">
      <a class="navbar-brand" href="#">우산꽂이</a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarResponsive">
         <ul class="navbar-nav ml-auto">
          <!--<li class="nav-item active">
            <a class="nav-link" href="#">Home
              <span class="sr-only">(current)</span>
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="#">About</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="#">Services</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="#">Contact</a>
          </li> -->
        </ul>
      </div>
    </div>
  </nav>

  <!-- Page Content -->
  <div class="container">

    <!-- Heading Row -->
    <div class="row align-items-center my-5">
      <div class="col-lg-7">
        <img class="img-fluid rounded mb-4 mb-lg-0" src="<%= request.getContextPath()%>/images/umbrella.jpg" alt="">
      </div>
      <!-- /.col-lg-8 -->
      <div class="col-lg-5">
        <h1 class="font-weight-light">오늘 우산 필요해?</h1>
        <p>당신이 우산을 들고 가야할지 <br/>지금 바로 알려드립니다.</p>
<!--         <a class="btn btn-primary" href="#">시작하기</a>
 -->        
      </div>
      <!-- /.col-md-4 -->
    </div>
    <!-- /.row -->

    <!-- Call to Action Well -->
    <!-- <div class="card text-white bg-secondary my-5 py-4 text-center">
      <div class="card-body">
        <p class="text-white m-0"></p>
      </div>
    </div> -->
    <!-- 나중에 hidden form 처리 -->
     <form action="weather.do" name='addressForm'>    	
    	<input type="text" name="name" value="pppppp"/>
    	<input type="text" name="age" value="5555"/>
    	<input type="submit" />
    </form>
<script>
	window.onload = function(){	  
	    var decodedCookie = document.cookie;
	    var ca = decodedCookie.split(';');
	    
	    for(var i = 0; i <ca.length; i++){		    	
	    	var i2 = i+1;	    	
	    	var name = "location"+i2+"=";	
	    	var re1 = new RegExp('location1');
	    	var re2 = new RegExp('location2');
	    	var re3 = new RegExp('location3');
	    	var c = ca[i];    	
	    	
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
	
	function go(num){	
		var q = document.getElementById('location'+num).innerHTML;
		var x = document.cookie;
		var re = new RegExp('군$');
		var arrState = ['경기', '강원', '경북', '경남', '충남', '충북', '전남', '전북'];
		var y = q.split(' ');
		
		if(y[0]=='광주'){
			alert('광주광역시'); 
		}
		else if(re.test(y[1])){
			alert(y[1]);
		}
		else if(arrState.includes(y[0]) == true){
			alert(y[1]);		
		}else{
			alert(y[0]);
		}; 
		/* alert(x);	 */	
	};
	
	function daumZipFind(num){
	    new daum.Postcode({
	        oncomplete: function(data) {
	        	var f = document.addressForm;	
				var h = data.address;	 
	        	//f.address.value = data.address;	    
	        	document.getElementById('location'+num).innerHTML= h;
	        	document.cookie = 'location'+num+"="+h+"; expires=365;";
	        }
	    }).open();
	}
</script>
    <!-- Content Row -->
    <div class="row">
      <div class="col-md-4 mb-5">
        <div class="card h-100">
          <div class="card-body" onclick="go(1)">
            <h2 class="card-title" id='location1'>1번 지역</h2>
            <!-- <p class="card-text">서울특별시</p> -->
          </div>
          <div class="card-footer">
            <input type="button" value='주소설정하기'  onclick="daumZipFind(1)"/>
          </div>
        </div>
      </div>
      <!-- /.col-md-4 -->
      <div class="col-md-4 mb-5">
        <div class="card h-100">
          <div class="card-body" onclick="go(2)">
            <h2 class="card-title" id='location2'>2번 지역</h2>
            <!-- <p class="card-text">부산광역시</p> -->
          </div>
          <div class="card-footer">
            <input type="button" value='주소설정하기'  onclick="daumZipFind(2)"/>
          </div>
        </div>
      </div>
      <!-- /.col-md-4 -->
      <div class="col-md-4 mb-5">
        <div class="card h-100">
          <div class="card-body" onclick="go(3)">
            <h2 class="card-title" id='location3'>3번 지역</h2>
            <!-- <p class="card-text">대전광역시</p> -->
          </div>
          <div class="card-footer">
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