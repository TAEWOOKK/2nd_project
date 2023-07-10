UserSignUpF.jsp<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>   
<%@ page import = "java.sql.*" %>     
<%@ page import  = "kr.co.ezen.EZUserVO" %>
<%@ page import  = "kr.co.ezen.EZUserDAO" %>
<%@ page errorPage="../errors/error_screen.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 실행화면</title>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
%>
	<jsp:useBean id="eVo" class="kr.co.ezen.EZUserVO">
		<jsp:setProperty name="eVo" property="*"/>	
	</jsp:useBean>	
<%
	String pwd = request.getParameter("pwd");
	String pwd2 = request.getParameter("pwd2");
	String id = request.getParameter("id");
	
	EZUserDAO edao = new EZUserDAO();
	String idcheck = edao.getid(id);
	Boolean newOk = false;
	
	if (idcheck != null){
		
%>
	<script type="text/javascript">
	alert("'<%=id%>'는 이미 사용중입니다.");
	history.back(-1);

      function idget(){
      	document.getElementById("idcheck").value = opener.document.getElementById("userid").value;
      }
  	</script>
 <% 	
	}else if (pwd2.equals(pwd)){

		try {
			edao.signUp(eVo);
			newOk = true;
		} catch (Exception e) {
			throw e;
		}
	}
%>
	
	
<%
	if (!pwd2.equals(pwd)){
%>
	<script type="text/javascript">
	alert("비밀번호가 일치하지 않습니다.");
	history.back(-1);
	</script>
<%
	}
%>

<%
	if (newOk){
%>	
	<script type="text/javascript">
	alert("회원가입이 완료되었습니다.");
	location.href='../Main.jsp?center=User/UserLoginF.jsp';
	</script>
<%
	}
%>

</body>
</html>