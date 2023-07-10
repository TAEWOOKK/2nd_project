<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="kr.co.ezen.BookingDAO"%>
<%@ page import="kr.co.ezen.BookingVO"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
</head>

<body>

    <%
String x = request.getParameter("date");
String id = (String)session.getAttribute("id");

 BookingDAO bdao = new BookingDAO();
		
int y= bdao.selectIdDateBooking(id,x); 

if(y==1){ %>
    <script>
        alert('이미 예약 완료된 날짜입니다.');
        location.href = "../Main.jsp?center=Booking/BookingRegisterF.jsp"
    </script>
    <% } 
else{
					%>
    <script>
        history.back(-1); 
    </script>
    <%
}
%>
</body>

</html>