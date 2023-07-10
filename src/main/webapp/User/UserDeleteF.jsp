<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "kr.co.ezen.EZUserDAO" %>     
<%@ page import = "kr.co.ezen.EZUserVO" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 탈퇴 화면</title>
</head>
<style>
	.adminlist{
		height:700px;
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
</style>
<body>
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
					location.href='../Main.jsp?center=User/UserLoginF.jsp';
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
	
	if(!ezu2.getUtype().equals("0")){   //관리자는 회원유형이 '0'임 
%>	
		<script type="text/javascript">
			alert("이 화면은 관리자가 사용합니다.!!!" + <%=ezu2.getUtype()%>);               
			history.back();//history.go(-1)
		</script>
		
<%
	}
%>

<form action="User/UserDeleteP.jsp" method="post">

 <div class = "adminlist">
		<br><br>
		<span style="font-size:30px;font-weight:bold;">  회원정보 삭제 화면(관리자용)  </span><br><br><br><br>

	<div align="center"> 
		<table border="1" style="width: 600; background: coral;" align= "center" >
			<tr align="center" height="40">
				<td width="150" style="background: beige;">아이디</td>
				<td width="350"><%=ezu1.getId() %></td>
			</tr>
			
			<tr height="40" align="center">
				<td width="150" style="background: beige;">이  름</td>
				<td width="350"><%=ezu1.getName() %></td>
				</td>
			</tr>
			

			<tr height="40" align="center">
				<td width="150" style="background: skyblue;">관리비밀번호</td> <!-- 2714 -->
				<td width="350">
					<input type="password" name="pwd"> <!-- ..Proc에 넘기는 스트링 pwd -->
				</td>
			</tr>
			
			<tr height="40" align="center">
				<td colspan="2" style="background: azure;">
					<input type="hidden" name="id" value="<%=ezu1.getId()%>"> <!-- ..Proc에 넘기는 스트링 id -->
					<!--  이렇게 대체해도 됨  <%=request.getParameter("id")%> -->
					<input type="submit" value="회원정보삭제">&nbsp;&nbsp;  <!-- location은 위에 action에 언급 : "UserDeleteP.jsp" -->
					<input type="button" value="회원가입" onclick="location.href='Main.jsp?center=User/UserSignUpF.jsp'"/>&nbsp;&nbsp;
					<input type="button" value="회원목록" onclick="location.href='Main.jsp?center=User/UserListT.jsp'"/>
				</td>
			</tr>
			
		</table>
	</div>
 </div>
</form> 




</body>
</html>