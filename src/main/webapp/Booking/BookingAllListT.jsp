<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="kr.co.ezen.BookingDAO" %>
<%@ page import="kr.co.ezen.BookingVO" %>
<%@ page import="kr.co.ezen.EZUserDAO" %>
<%@ page import="kr.co.ezen.EZUserVO" %>
<%@ page import="java.util.Vector"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>모든 예약 보기 : BookingAllListT.jsp</title> <!-- BookingAllList -->
</head>


<body>

<div style="width:80%; text-align:center;">
	<span style="font-size:25px; font-weight:bolder;"> 전체 예약 현황</span>
	<hr style="background-color:black; height:2px;"/>
</div>
<div style="width:80%; height:450px; overflow:auto" text-align:center;">
<!-- 	<span style="font-size:25px; font-weight:bolder;"> 모든 예약 정보</span>	-->
<!-- 	<hr style="background-color:black; height:2px;"/>	-->

<%
		String sid = (String)session.getAttribute("id"); 
		
		if(sid == null){
%>
			<script type = "text/javascript">
			alert('먼저 로그인을 해주세요.');
			location.href='Main.jsp?center=User/UserLoginF.jsp';
			</script>
<%		} %>
<%
	//DB연결을 위한 객체 생성
	BookingDAO bdao = new BookingDAO();
	Vector<BookingVO> vec = bdao.selectBooking(1);
%>

	<table width="100%" cellspacing="0" cellpadding="10px" class="bt">
		<tr align="center" style="background: #f6f5f0; height:40px;">
			<td width="50" style="vertical-align:middle;">No</td>
			<td width="200" style="vertical-align:middle;">아이디</td>
			<td width="100" style="vertical-align:middle;">예약일</td>
			<td width="200" style="vertical-align:middle;">등록일</td>
			<td width="100" style="vertical-align:middle;">예약상태</td>
			<td width="100" style="vertical-align:middle;">삭제</td>		<!-- add hjh 3.17 -->
		</tr>
					
	<%
	String X="";
	String Y="";
	
	for(int i=0; i < vec.size(); i++){
		
		BookingVO bkvo = vec.get(i);
		
		String STR = bkvo.getId();

	%>
		<tr align="center" style="height:40px;">
		<td width="50" style="vertical-align:middle;"><%=i+1 %></td>
		<td width="200" style="vertical-align:middle;"><%=bkvo.getId() %></td>
		<td width="100" style="vertical-align:middle;"><%=bkvo.getBdate() %></td>
		<td width="200" style="vertical-align:middle;"><%=bkvo.getRdate() %></td>
	<%
		String ox = bkvo.getBcheck();
		if(ox.equals("O")){
	%>
 			<td width="100" style="vertical-align:middle;" style="color: #FF5A5A">예약 중</td>
	<%
		}else{
	%>
			<td width="100" style="vertical-align:middle;" style="color: #28A0FF">취소</td>
	<%
		}
	%>
			<!-- add hjh 3.17 -->
		<td style="vertical-align:middle;">
			<a href="Booking/BookingDeleteP.jsp?id=<%=bkvo.getId() %>&bdate=<%=bkvo.getBdate() %>">
			<img src="images/bt_delete.png" class="m_header-banner-close" width="15px" height="20px" align="center">
			</a>
		</td>

	<%
	}
	%>
		</tr>
	</table><br>



</div>


</body>
</html>