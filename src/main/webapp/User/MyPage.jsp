<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
</style>
<body>
	<%
	String id = (String)session.getAttribute("id");
	if(id==null){
	%>
	<script>
		alert("로그인을 먼저 해주세요!");
		location.href='Main.jsp?center=User/UserLoginF.jsp';
	</script>
	<%
	} else {
	%>

<!-- RBVO.getId() %> -->

		<div align="center" style="height:900px;">
			<span style="font-size:30px;font-weight:bold;">마이페이지</span><br><br><br><br>
			<div style="width:70%; text-align:left;">
			<span style="font-size:20px; font-weight:bolder;">회원 정보</span>
			<hr style="background-color:black; height:2px;"/>
			<jsp:include page="/User/UserDetailT.jsp" />  
		</div>
		
		<br><br><br>
		<div style="width:70%; text-align:left;">
		<span style="font-size:20px; font-weight:bolder;">예약 정보</span>
		<hr style="background-color:black; height:2px;"/>
		<jsp:include page="/Booking/BookingPersonalT.jsp" />
		</div>
	

</div>
<%} %>

</body>
</html>