<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>]
    <%@page import= "javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그아웃</title>
</head>
<body>
<% 
	session.removeAttribute("id");	
	session.removeAttribute("pwd");	
	session.removeAttribute("utype");	
	session.invalidate();
	
	HttpSession session2 = request.getSession(false);
	
	if (session2 != null) {
	    // 세션 무효화
	    session2.invalidate();
	}
%>
<script>
	alert("로그아웃 되었습니다.");
	location.href="Main.jsp";
</script>

</body>
</html>