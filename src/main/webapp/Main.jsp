<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
  <link rel="icon" href="./images/ezski.png" />
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/reset-css@5.0.1/reset.min.css" />
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400;700&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">

  <!-- SWIPER -->
   <link rel="stylesheet" href="https://unpkg.com/swiper@6.8.4/swiper-bundle.min.css" />
  <script src="https://unpkg.com/swiper@6.8.4/swiper-bundle.min.js"></script>

  <link rel="stylesheet" type="text/css" href="./Main.css">
  <script defer src="./main.js"></script>

<title>이젠스키</title>

</head>
<style>
	.main {
		width: 100%;
		
	}
	.center {
	  margin:0;
	  padding-top:150px;
	  width:100%;
	  height:100%;
	  margin-bottom: 250px;
	}
  	ul {
	  list-style-type: none;
	  padding: 0px;
	  margin: 0px;
	  width: 50px;
	  background: #FAEBD7;
	  height: 100%;
	  overflow: auto;
	}
	li {
	}
	li a {
	  text-decoration: none;
	  padding: 20px;
	  display: block;
	  color: #000;
	  font-weight: bold;
	}
	
	li a:hover {
	  background: #333;
	  color: #fff;
	}
	
	a {
  		text-decoration-line: none;
  		color: #000000;
    } 
	
 </style>
 <script>
history.pushState(null, null, location.href);
window.onpopstate = function () {
    history.go(1);
};

var modal = document.getElementById("myModal"); // 모달 요소 가져오기
var span = document.getElementsByClassName("close")[0]; // 닫기 버튼 요소 가져오기

span.onclick = function() { // 닫기 버튼 클릭 이벤트 리스너
  modal.style.display = "none"; // 모달 숨기기
}

window.onclick = function(event) { // 모달 외부 클릭 이벤트 리스너
  if (event.target == modal) {
    modal.style.display = "none"; // 모달 숨기기
  }
}

</script>
<body class="main">
	
	<%
		String id = (String)session.getAttribute("id");
		request.setCharacterEncoding("utf-8");
		String center = request.getParameter("center");
		String utype = (String)session.getAttribute("utype");
		
		if(center == null){
			center = "Center.jsp";
		}
	
	%>
	
<div style="position:relative;">
 <jsp:include page="./header.jsp"></jsp:include>
</div>
  <div class="center" align="center" style="position:relative; height:100%; top:120px;">
			<jsp:include page="<%=center %>"></jsp:include>
    <section class="right">
	   <ul>
<%
	if(id==null){
		
		%>
        <li><a href="Main.jsp?center=Booking/BookingRegisterF.jsp">예약</a></li>
	    <li><a href="Main.jsp?center=/Notice/NoticeListT.jsp">공지사항</a></li>
	    <li><a href="Main.jsp?center=Review/ReviewListT.jsp">사용자후기</a></li>
    
   <% 
    
	}else{
				if(utype.equals("0")){
			%>
				    <li><a href="Main.jsp?center=/Notice/NoticeListT.jsp">공지사항</a></li>
				    <li><a href="Main.jsp?center=Review/ReviewListT.jsp">사용자후기</a></li>
			<%} else { %>	    
				    	    <li><a href="Main.jsp?center=Booking/BookingRegisterF.jsp">예약</a></li>
			
				    <li><a href="Main.jsp?center=/Notice/NoticeListT.jsp">공지사항</a></li>
				    <li><a href="Main.jsp?center=Review/ReviewListT.jsp">사용자후기</a></li>
	    <%}}%>
	    
	    
	    
	  </ul>
 	</section>
</div>

<div style="position:relative; height:150px;height:370px; bottom:0">
 <jsp:include page="./footer.jsp"></jsp:include>
</div>
  <div style = "opacity:0.5; position : fixed; right : 30px; top : 92%;">
					<a href="#">
						<img src="images\up.png" height="50" width="60" alt=""/>
					</a>
				</div>
  

</body>
</html>