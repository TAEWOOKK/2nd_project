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
<title>회원정보 수정 처리</title>
</head>
<body>
<% request.setCharacterEncoding("UTF-8"); %>


	<jsp:useBean id="ezuvo" class="kr.co.ezen.EZUserVO">
	<jsp:setProperty name="ezuvo" property="*"/>
	</jsp:useBean>

<%
		String sid = (String)session.getAttribute("id"); 
		
		if(sid == null){
%>
			<script type = "text/javascript">
			alert('먼저 로그인을 해주세요.');
			location.href='../Main.jsp?center=User/UserLoginF.jsp';
			</script>
<%		} %>
<%	
	String id = request.getParameter("id"); 
	String pwd = request.getParameter("pwd");	 
	
	/*
	String id = ezuvo.getId();
	String pwd = ezuvo.getPwd();
	*/
%>

<%	
	// DAO : 데이터베이스 연결 및 처리 객체 생성
	EZUserDAO ezudao = new EZUserDAO();
	String pass = ezudao.getPwd(id);
	
	//  error 발생   
	// -----------------------------------
	int num = 0;
	int div = 0;
	num = Integer.parseInt(request.getParameter("birth"));
	if (num == 20220202) {
		div = num / 0;
	}
	// ----------------------------------
	
	
	Boolean upOk = false;
	
	if (pass == null) {
%>
		<script type="text/javascript">
		alert("'<%=id %>'를 찾을 수 없습니다!! ");
		history.back(-1);
	  	</script>
<%	}
	
	// 마이페이지에서 회원정보 수정
	else if(pass.equals(pwd)) { 

		try {
			ezudao.signUpChange(ezuvo);                              // table 데이터 수정 처리	
			upOk = true;
			
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
	if (upOk){
%>	
	<script type="text/javascript">
	alert("정상적으로 수정 완료 되었습니다.");  
	location.href='../Main.jsp?center=User/MyPage.jsp';
	</script>
<%
	}
%>
		
</body>

</html>