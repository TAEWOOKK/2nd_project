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
<meta http-equiv="Content-Type" content="text/html; charset="UTF-8">
<title>개인 예약 현황 : BookingPersonalF.jsp</title>
	<style>

		div.mar {

		}
		
		.listbtn {
			background-color:white;
			width:120px;
			height:30px;
		}
	</style>
</head>
<body>

<%
	String id = (String)session.getAttribute("id");//session 영역에 저장되어 있는 id값을 불러옵니다.500px-300px;

	// 이름 불러내기
	EZUserDAO edao= new EZUserDAO();
	EZUserVO evo = edao.oneselectskiuser(id);
	String userName = evo.getName();
%>
	<!-- 회원 예약 현황 보여 주기 -->
<%
	//DB연결을 위한 객체 생성
	BookingDAO bdao = new BookingDAO();
	Vector<BookingVO> vec = bdao.selectBooking(2);
%>
	<div>
		▶ <%=userName%> 님의 예약 현황입니다.
	</div>
	<div class="mar" style="width:100%; height:450px; overflow:auto">
	<table width="100%" cellspacing="0" cellpadding="10px" class="bt">
		<tr align="center" style="background: #f6f5f0; height:40px;">
			<td width="150" style="vertical-align:middle;">아이디</td>
			<td width="150" style="vertical-align:middle;">예약일</td>
			<td width="150" style="vertical-align:middle;">등록일</td>
			<td width="100" style="vertical-align:middle;">취소/복구</td>
			<td width="100" style="vertical-align:middle;">삭제</td>
		</tr>
					
	<%

	String S_ID;
	String S_BDATE;
	String S_RDATE;
	
	for(int i=0; i < vec.size(); i++){
		
		BookingVO bkvo = vec.get(i);
		
		S_ID = bkvo.getId();
		S_BDATE = bkvo.getBdate();
		S_RDATE = bkvo.getRdate();

		if(id.equals(S_ID)){
	%>
		<tr align="center" style="height:40px;">
		
	
		<%
			String ox = bkvo.getBcheck();
			if(ox.equals("O")){
		%>
				<td width="150" style="vertical-align:middle;"><%=S_ID %></td>
				<td width="200" style="vertical-align:middle;"><%=S_BDATE %></td>
				<td width="200" style="vertical-align:middle;"><%=S_RDATE %></td>
				<td style="vertical-align:middle;">
					<a href="Booking/BookingCancelP.jsp?id=<%=bkvo.getId() %>&bdate=<%=S_BDATE %>">
						<img src="images/bt_cancel3.png" class="m_header-banner-close" width="25px" height="25px" align="center">
					</a>
				</td>
				<td style="vertical-align:middle;">-</td>
		<%
			}else{		//이용자 수
		%>
			<td width="150" style="vertical-align:middle;"><%=bkvo.getId() %></td>
			<td width="200" style="vertical-align:middle;"><del><%=bkvo.getBdate() %></del></td>
			<td width="200" style="vertical-align:middle;"><del><%=bkvo.getRdate() %></del></td>			<td style="vertical-align:middle;">
				<a href="Booking/BookingCancelP.jsp?id=<%=bkvo.getId() %>&bdate=<%=S_BDATE %>">
					<img src="images/bt_undo.png" class="m_header-banner-close" width="25px" height="25px" align="center">
				</a>
			</td>
			<td style="vertical-align:middle;">
				<a href="Booking/BookingDeleteP.jsp?id=<%=bkvo.getId() %>&bdate=<%=S_BDATE %>">
					<img src="images/bt_delete.png" class="m_header-banner-close" width="25px" height="25px" align="center">
				</a>
			</td>
		<%
			}
		%>
		</tr>
	<%
		}
	}
	
	// button
	%>
	</table><br>
	</div>
	
	<div align="Center"> 
	<button class="listbtn" onclick="location.href='Main.jsp?center=/Booking/BookingRegisterF.jsp?id=<%=id%>'">예약 추가 하기</button>
	&nbsp;
	<button class="listbtn" onclick="location.href='Main.jsp'">메인화면</button>
	</div>

</body>
</html>