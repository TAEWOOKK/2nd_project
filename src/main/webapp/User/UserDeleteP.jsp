<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "kr.co.ezen.EZUserDAO" %>     
<%@ page import = "kr.co.ezen.EZUserVO" %>
<%@ page import = "java.sql.*" %>
<%@ page errorPage="../errors/error_screen.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원탈퇴 마이페이지용</title>
</head>
<body>

	<jsp:useBean id="ezuvo" class="kr.co.ezen.EZUserVO">
		<jsp:setProperty name="ezuvo" property="*"/>	
	</jsp:useBean>
	
<% 
String id = (String)session.getAttribute("id");
String pwd = (String)session.getAttribute("pwd");	
if(id == null){
%>
	<script type = "text/javascript">
	alert('먼저 로그인을 해주세요.');
	location.href='../Main.jsp?center=User/UserLoginF.jsp';
	</script>
<%} else {

EZUserDAO ezudao = new EZUserDAO();
String pass = request.getParameter("pwd");

Boolean del2Ok = false;

	if(pwd.equals(pass)){
		
		try {
			ezudao.signUpDelete2(id);                              // table 데이터 삭제 처리	
			del2Ok = true;
			
		} catch (Exception e) {
			throw e; 
		}
			
	}

		
%>

<%
	if (!pass.equals(pwd)){
%>
		<script type="text/javascript">
		alert("비밀번호가 일치하지 않습니다. 확인 바랍니다!!!");
		history.back(-1);
		</script>
<%
	}
%>

<%
	if (del2Ok){

		session.removeAttribute("id");	 
		session.removeAttribute("pwd");	
		session.removeAttribute("utype");	
		session.invalidate();
%>	
		
		<script type="text/javascript">
		alert("정상적으로 삭제 완료 되었습니다.");  
		location.href='../Main.jsp?center=User/UserLoginF.jsp';
		</script>
<%
	}
}
%>
	
	
</body>
</html>