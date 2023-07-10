<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="kr.co.ezen.NBoardDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지글 수정 처리</title>
</head>
<body>
	<jsp:useBean id="nbVO" class="kr.co.ezen.NBoardVO" >
		<jsp:setProperty property="*" name="nbVO" />
	</jsp:useBean>
	
		<%
			request.setCharacterEncoding("UTF-8");
			int num = Integer.parseInt(request.getParameter("numb"));

			String id = (String)session.getAttribute("id");
		if(id!=null){
			NBoardDAO nbDAO = new NBoardDAO();
			// data select
			
			nbDAO.updateBoard(nbVO);
		%>
		<script type="text/javascript">
		alert('수정 완료!!!');
		location.href = 'Main.jsp?center=/Notice/NoticeDetailT.jsp?numb=<%=nbVO.getNumb()%>';
		</script>
		<%} else {
			%>
		<script type="text/javascript">
			alert("로그인 후 수정해주세요!");
			location.href='Main.jsp?center=User/UserLoginF.jsp';
		</script>
		<%
		} %>
</body>
</html>