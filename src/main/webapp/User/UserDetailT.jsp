<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "kr.co.ezen.EZUserDAO" %>     
<%@ page import = "kr.co.ezen.EZUserVO" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script>
	function deleteUser() {
		var inputPwd = prompt('비밀번호를 입력하세요.');
		if(inputPwd!=null){
		location.href= 'User/UserDeleteP.jsp?pwd=' + inputPwd;
		} else {
			
		}
	}
</script>
<style>
	.adminlist{
		height:800px;
	}
	a {
		text-decoration:none;
	
	}
	.listbtn {
		background-color:white;
		width:30px;
		height:30px;
	}
	.listbtn:hover {
		background-color: #D2D2FF;
	}
	.listbtn_1 {
		width:30px;
		height:30px;
	} 
	.listbtn_2 {
		width:30px;
		height:30px;
	} 
	.listbtn_wr {
		background-color:white;
		width:50px;
		height:30px;
	}
	.listbtn_wr:hover {
		background-color: #f6f6f6;
	}
	.listtbl th{
		border-top: 1px black solid;
		border-bottom: 1px black solid;
	}
	.listtbl td {
		border-top: 0.5px #f6f5f0 solid;
		border-bottom: 0.5px #f6f5f0 solid;		
	} 
	.listtbl th:first-child,
	.listtbl td:first-child {
		border-left: 0;
	}
	.listtbl th:last-child,
	.listtbl td:last-child {
		border-right: 0;
	}
	td {
		vertical-align: middle;
	}
	td:first-child {
		height:50px;
	}
	td:first-child img {
		height:200px;
	}
</style>
<body>
<br>
<%
	String id= (String)session.getAttribute("id");

	EZUserDAO ezudao = new EZUserDAO();	

	EZUserVO ezu1 = ezudao.oneselectUser(id);
%>


<!-- <h2 align="center">회원정보 상세</h2>  -->
<!--------------------------------- -->
<div style="text-align:center;">
	<table border="1" cellspacing="0" cellpadding="0" align="center" width="100%">
		<tr>
<td rowspan="4" width="200px">
			<% if(ezu1.getSex().equals("남")){ %>
				<img src="images/male.png" alt="" width="200px"  /> 		
			<% } else { %>
				<img src="images/female.png" alt="" width="200px"  /> 	
			<% } %>
			</td>
			<td width="150px" style="font-weight:bolder; background-color:#f6f5f0;">이름</td><td width="200px"><%=ezu1.getName() %></td>
			<td width="150px" style="font-weight:bolder; background-color:#f6f5f0;">생일</td><td width="250px"><%=ezu1.getBirth().substring(0,4) %>년&nbsp;<%=ezu1.getBirth().substring(4,6) %>월&nbsp;<%=ezu1.getBirth().substring(6,8) %>일</td>
		</tr>
		<tr>
			<td style="font-weight:bolder; background-color:#f6f5f0;">아이디</td><td><%=ezu1.getId() %></td>
			<td style="font-weight:bolder; background-color:#f6f5f0;">전화번호</td><td><%=ezu1.getTel().substring(0,3) %>-<%=ezu1.getTel().substring(3,7) %>-<%=ezu1.getTel().substring(7,11) %></td>
		</tr>
		<tr>
			<td style="font-weight:bolder; background-color:#f6f5f0;">성별</td><td><%=ezu1.getSex() %></td>
			<td style="font-weight:bolder; background-color:#f6f5f0;">이메일</td><td><%=ezu1.getEmail() %></td>
		</tr>
		<tr>
		
			<td style="font-weight:bolder; background-color:#f6f5f0;">지역</td><td><%=ezu1.getCity() %></td>
			<td style="font-weight:bolder; background-color:#f6f5f0;">가입일자</td><td><%=ezu1.getEdate().substring(0,10) %></td>
		</tr>
		<tr height="40px">
		</tr>
			<tr height="40" align="center">
		<td colspan="5" align="right">

 		
			<!-- tmp ㅡMypage test용 -->
			<button class="listbtn_wr" type="button" onclick="location.href='Main.jsp?center=User/UserUpdateF.jsp?id=<%=ezu1.getId()%>'">수정</button>&nbsp;&nbsp;
			<button class="listbtn_wr" onclick="deleteUser()">탈퇴</button>&nbsp;&nbsp;
			
		</td>
	</tr>
	</table>
</div>
</body>
</html>