<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "kr.co.ezen.EZUserDAO" %>     
<%@ page import = "kr.co.ezen.EZUserVO" %> 
<%@ page errorPage="../errors/error_screen.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 삭제 화면</title>
</head>
<style>
	.adminlist{
		height:900px;
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
		border-top: 0.5px #dcdcdc solid;
		border-bottom: 0.5px #dcdcdc solid;		
	} 
	.listtbl th:first-child,
	.listtbl td:first-child {
		border-left: 0;
	}
	.listtbl th:last-child,
	.listtbl td:last-child {
		border-right: 0;
	}
	td{
	  vertical-align:middle;
	 
	}
</style>
<body>
<%
		String sid = (String)session.getAttribute("id"); 
		
		if(sid == null){
%>
			<script type = "text/javascript">
			alert('먼저 로그인을 해주세요.');
			location.href='Main.jsp?center=User/UserLoginF.jsp';
			</script>
<%		} else {%>
<%

	request.setCharacterEncoding("UTF-8");

%>

<%  String logid = "";

	 try {
			logid = (String)session.getAttribute("id");
			
			 if(logid == null){
%>				
				<script type="text/javascript">
					alert("로그인하지 않은 상태입니다.");
					location.href='Main.jsp?center=User/UserLoginF.jsp';
				</script>
<%
			}
			 
	  }catch(Exception e){
		  e.printStackTrace();
	  }
%>


<%
	
	String id= request.getParameter("id");
	
	EZUserDAO ezudao = new EZUserDAO();	
	
	EZUserVO ezu1 = ezudao.oneselectUser(id);
%>	

<%	
	// 로그인 ID 관리자여부 체크 : 관리자는 회원유형이 '0'임 
	EZUserVO ezu2 = ezudao.oneselectUser(logid); // login id  
	
	// id 존재여부 확인
	
	String idcheck = ezudao.getid(logid);

	if(idcheck == null) {
%>
		<script type="text/javascript">
			alert("'<%=logid %>'는 관리회원이 아닙니다!!!");
			history.back(-1);     
	  	</script>
<% 
	}
	
	if(!ezu2.getUtype().equals("0")){   // 관리자
%>	
		<script type="text/javascript">
			alert("이 화면은 관리자가 사용합니다.!!!" + <%=ezu2.getUtype()%>);               
			history.back();//history.go(-1)
		</script>
		
<%
	}
%>

<form action="User/UserDeleteMgrP.jsp" method="post">

 <div class = "adminlist">
		<br><br>
		<span style="font-size:30px;font-weight:bold;">회원 삭제</span><br><br><br><br>

	<div style="width:30%; text-align:left;">
		<span style="font-size:20px; font-weight:bolder;">관리자용</span>
		<hr style="background-color:black; height:2px;"/> 
	</div>

	
	<div align="center"> 
		<table border="1" style="width: 600; " align= "center" >
			<tr align="center" height="40">
				<td width="150"  style="background: #f6f5f0;">아이디</td>
				<td width="350"><%=ezu1.getId() %></td>
			</tr>
			
			<tr height="40" align="center">
				<td width="150"  style="background: #f6f5f0;">이  름</td>
				<td width="350"><%=ezu1.getName() %></td>
				</td>
			</tr>
			
			<tr height="40" align="center">
				<td width="150" style="background:lightgrey;">관리자 아이디</td>
				<td width="350"><%=logid %></td>
			</tr>
			
			<tr height="40" align="center">
				<td width="150" style="background:lightgrey;">관리자 비밀번호</td>
				<td width="350"><input type="password" style="text-align:center" name="pwd"> 
				</td>
			</tr>
		
		</table>
			<tr height="40" align="center">
				<td colspan="2" style="background: azure;">
					<input type="hidden" name="id" value="<%=ezu1.getId()%>"> 
					<br><br>
					<input class="listbtn_wr" type="submit" value="삭제">&nbsp;&nbsp; 
					<input class="listbtn_wr" type="button" value="목록" onclick="location.href='Main.jsp?center=User/UserListT.jsp'"/>
				</td>
			</tr>
	</div>
 </div>
</form> 


</body>
<% } %>
</html>