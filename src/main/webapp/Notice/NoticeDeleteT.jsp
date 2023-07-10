<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="kr.co.ezen.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지글 삭제 처리</title>
</head>
<body>

		<%
			int numb = Integer.parseInt(request.getParameter("numb"));

		String id = (String)session.getAttribute("id");
		if(id!=null){
			NBoardDAO nbDAO = new NBoardDAO();
			// data select
	
			nbDAO.deleteBoard(numb);
		%>
			<script type="text/javascript">
		alert('삭제 완료!!!');
		location.href= "Main.jsp?center=/Notice/NoticeListT.jsp";
	</script>
	<%} else {
			%>
		<script type="text/javascript">
			alert("로그인 후 삭제해주세요!");
			location.href="Main.jsp?center=User/UserLoginF.jsp";
		</script>
		<%
		} %>
</body>
</html>