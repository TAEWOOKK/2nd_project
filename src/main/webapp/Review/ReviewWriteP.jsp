<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "kr.co.ezen.RBoardVO" %>
<%@ page import = "kr.co.ezen.RBoardDAO" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<% request.setCharacterEncoding("UTF-8"); 
%>

	
	<jsp:useBean id="RBVO" class="kr.co.ezen.RBoardVO">
		<jsp:setProperty name="RBVO" property="*"/>
	</jsp:useBean>

<%
	String id = (String)session.getAttribute("id"); 
	
	if(id == null){%>
		<script type = "text/javascript">
		alert('먼저 로그인을 해주세요.');
		location.href='./Main.jsp?center=User/UserLoginF.jsp';
		</script><%
	}else{	


		RBoardDAO rbdao = new RBoardDAO();
		rbdao.insertBoard(RBVO);
	
	

	%>
	<script type="text/javascript">
		alert("후기글이 작성 되었습니다.!!!")
		location.href='Main.jsp?center=Review/ReviewListT.jsp';
		</script>

<% } %>

</body>
</html>