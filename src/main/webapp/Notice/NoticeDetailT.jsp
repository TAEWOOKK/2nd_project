<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="kr.co.ezen.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지글 상세보기</title>
<style>


	.nwtbl {
		text-align:center;
		width:50%;
		height:70%;
	}
	.nwtbl>tr {
		height:100;
	}
	.nwtbl>td {
		height:100;
	}
	.nwselect {
		width:80%;
		font-size:15px;
		text-align:center;
	}
	.title {
		width:99%;
		height:75%;
	}
	.details {
		width:99%
	}
	.listbtn {
		width:80px;
		height:40px;
		background-color:white;
	}
	.listbtn:hover {
		background-color:aliceblue;
	}
	.listform {
		display:inline;
	}
</style>
</head>
<body>
	<%
		int numb = Integer.parseInt(request.getParameter("numb"));
	
		NBoardDAO nbDAO = new NBoardDAO();;
		
		NBoardVO nVO = nbDAO.oneSelectBoard(numb);
		NBoardVO nVO2 = nbDAO.prevSelectBoard(numb);
		NBoardVO nVO3 = nbDAO.nextSelectBoard(numb);
		
		if(session.getAttribute("id")!=null){
			session.setAttribute("notice" + nVO.getNumb(), nVO.getTitle());
		}
		%>
	<div align="center">
			<br><br>
			<div align="center"><font size="20px"><b>공지</b></font></div><br>
			<div align="center"><font size="3px" color="#969696">'이젠스키'의 새로운 소식을 가장 먼저 알려드립니다.</font></div><br><br><br><br>
			<div align="center" style="width:75px; height:23px; background-color:purple;"><font size="2px" color="white"><b>이젠스키</b></font></div><br>
			<div align="center"><font size="16px"><%=nVO.getTitle() %></font></div>
			<hr align="center" style="width:8%; border:solid 1.5px black"/><br>
			<div align="center"><span><b>작성일</b>&nbsp;&nbsp;<%=nVO.getWdate() %></span></div><br>
			<hr style="width:70%; color:#dcdcdc;"/>
				<table align="center" style="width:40%;">
				<tr height="500px">
					<td align="center" style="vertical-align:middle;"><%=nVO.getDetails().replace("\r\n","<br>") %></td>
				</tr>
			</table>
			<br>
			<hr style="width:70%; color:#dcdcdc;"/>
			<br>
			<div align="right" style="padding-right:15%;">
					<a href="Main.jsp?center=/Notice/NoticeListT.jsp"><button class="listbtn" >목록</button></a>&nbsp;
				<% 
					if(session.getAttribute("id")!=null){
					String utype = (String)session.getAttribute("utype");
					String id = (String)session.getAttribute("id");
					
					if(utype.equals("0")){
				%>
					<form class="listform" action="Main.jsp?center=/Notice/NoticeDeleteT.jsp?numb=<%=nVO.getNumb()%>" method="post" onsubmit="return confirm('삭제하시겠습니까?');"><button class="listbtn">삭제</button></form>&nbsp;
					<a href="Main.jsp?center=/Notice/NoticeUpdateF.jsp?numb=<%=nVO.getNumb()%>"><button class="listbtn">수정</button></a>
				<%
					}else {}}
				%>
			</div>
			<table align="center" width="70%" style="text-aling:left;">
			<tr height="40px">
				<td>다음글</td>
				<%
					if(nVO3.getTitle()==null){
				%>
					<td><font color="#FF8C8C">다음 글이 존재하지 않습니다.</font></td>
				<%
					} else {
				%>
				<td>
					<a href="Main.jsp?center=/Notice/NoticeDetailT.jsp?numb=<%=nVO3.getNumb() %>" style="color:black; text-decoration:none;"><%=nVO3.getTitle() %></a>
				</td>	
				<%} %>
			</tr>
			
			<tr height="40px">
				<td width="100px;">이전글</td>
				<%
					if(nVO2.getTitle()==null){
				%>
					<td><font color="#FF8C8C">이전 글이 존재하지 않습니다.</font></td>
				<%
					} else {
				%>
				<td>
					<a href="Main.jsp?center=/Notice/NoticeDetailT.jsp?numb=<%=nVO2.getNumb() %>" style="color:black; text-decoration:none;"><%=nVO2.getTitle() %></a>
				</td>
				<%} %>
			</tr>
			
			
			</table>
			<br><br>
	</div>
</body>
</html>