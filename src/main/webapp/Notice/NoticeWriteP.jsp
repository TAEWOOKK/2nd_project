<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="kr.co.ezen.NBoardDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지글 작성 처리</title>
</head>
	<% request.setCharacterEncoding("utf-8"); %>
	<jsp:useBean class="kr.co.ezen.NBoardVO" id="nboard">
		<jsp:setProperty property="*" name="nboard" />
	</jsp:useBean>
<body>
		<%
			String id = (String)session.getAttribute("id");
		if(id!=null){
			NBoardDAO nbDAO = new NBoardDAO();
			nbDAO.insertBoard(nboard);
		%>
		<script type="text/javascript">
			alert("작성 완료!!");
			location.href="Main.jsp?center=/Notice/NoticeListT.jsp";
		</script>
		<%} else {
			%>
		<script type="text/javascript">
			alert("로그인 후 작성해주세요!");
			location.href='Main.jsp?center=User/UserLoginF.jsp';
		</script>
		<%
		} %>
</body>
</html>