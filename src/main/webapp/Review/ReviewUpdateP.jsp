<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "kr.co.ezen.RBoardDAO" %>
<%@ page import = "kr.co.ezen.RBoardVO" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<% request.setCharacterEncoding("UTF-8");  %>
	<jsp:useBean id="RBVO" class="kr.co.ezen.RBoardVO">
		<jsp:setProperty name="RBVO" property="*"/>
	</jsp:useBean>
	
<%
	

	int numb = Integer.parseInt(request.getParameter("numb"));
	
	String id = (String)session.getAttribute("id"); 
	
	if(id == null){%>
		<script type = "text/javascript">
		alert('먼저 로그인을 해주세요.');
		location.href='./Main.jsp?center=User/UserLoginF.jsp';
		</script><%
	}else{	
	
	//데이터베이스 연결 객체 생성  (MVC2 방식)
	RBoardDAO rbdao = new RBoardDAO();

	
	
		
		rbdao.updateBoard(RBVO);
		
		
		%>
		<script type="text/javascript">
		var numb = <%=numb %>
		alert("게시글이 수정 되었습니다.!!!")
		location.href="Main.jsp?center=./Review/ReviewDetailT.jsp?numb=" + numb;
	 	</script>

	
	
<% } %>
	
</body>
</html>