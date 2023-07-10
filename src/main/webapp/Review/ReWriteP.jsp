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
<%
	request.setCharacterEncoding("UTF-8");

%>

	<jsp:useBean id="RBVO" class="kr.co.ezen.RBoardVO">
		<jsp:setProperty name="RBVO" property="*"/>
	</jsp:useBean>


<% 
	String id = (String)session.getAttribute("id"); 	
	int numb = Integer.parseInt(request.getParameter("numb"));
	String ID = request.getParameter("ID");
	

	String sid = (String)session.getAttribute("id"); 
	
	if(sid == null){%>
		<script type = "text/javascript">
		alert('먼저 로그인을 해주세요.');
		location.href='../Main.jsp?center=/User/UserLoginF.jsp';
		</script><%
	}else{

	
		
	if(id!=null) {

	//데이터베이스 연결 객체 생성  (MVC2 방식)
	RBoardDAO rbdao = new RBoardDAO();
	RBoardVO rbVO = new RBoardVO();
	
	//rewriteBoard (댓글작성)
	rbdao.rewriteBoard(RBVO);
	
	%>
	
	<script>
		var numb = <%=numb %>
		alert("댓글이 등록 되었습니다.!!!")
		location.href="../Main.jsp?center=./Review/ReviewDetailT.jsp?numb=" + numb;
	</script>
	
	<%
	} else {
	%>
		<script type = "text/javascript">
		alert('먼저 로그인을 해주세요.');
		history.back();
		</script>	
	<%}%>
	

	<%} %>


</body>
</html>