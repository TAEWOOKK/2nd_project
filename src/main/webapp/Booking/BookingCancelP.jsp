<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="kr.co.ezen.BookingDAO" %>
<%

 request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약하기 구현</title>
</head>

<body>
	<%
		String id = request.getParameter("id");
		String bdate = request.getParameter("bdate");
		String sid = (String)session.getAttribute("id"); 
		
		if(sid == null){
			%>
			<script type = "text/javascript">
			alert('먼저 로그인을 해주세요.');
			location.href='../Main.jsp?center=User/UserLoginF.jsp';
			</script>
	<%	} else {
	//DB연결을 위한 객체 생성
	BookingDAO bdao = new BookingDAO();
	
	//BookingVO의 bvo 오브젝트 이용해서 예약정보 data insert 
	bdao.cancelBooking(id,bdate);

	%>
	
	<script>
	alert("변경되었습니다.");
	location.href='../Main.jsp?center=User/MyPage.jsp';
	</script>
	<% } %>
</body>
</html>