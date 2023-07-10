<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>     
<%@ page import  = "kr.co.ezen.EZUserVO" %>
<%@ page import  = "kr.co.ezen.EZUserDAO" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디중복체크 실행</title>
</head>
<body>
<%
request.setCharacterEncoding("UTF-8");
String id = request.getParameter("id");
EZUserDAO edao = new EZUserDAO();
String idcheck = edao.getid(id);
int dcheck = 1;
if(id.equals("")){
	dcheck = 0;
}
	if(idcheck ==null && dcheck ==1){
%>
		<script type="text/javascript">
		var id = '<%=id%>'
		var dcheck = '<%=dcheck%>'
		alert("'<%=id%>'는 사용가능합니다");
		location.href= "../Main.jsp?center=User/UserSignUpF.jsp?userid="+id+"&dcheck="+dcheck;

	  	</script>
<% 
	}
	else if(id.equals("")){%>
		<script type="text/javascript">
		alert("id를 작성해주세요.");
		history.back(-1);
		</script>
		<% 
	}
	else{
%>
		<script type="text/javascript">
		alert("'<%=id%>'는 이미 사용중입니다.");
		history.back(-1);

	  	</script>
	
<% 
	}
%>
</body>
</html>