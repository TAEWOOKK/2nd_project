<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import  = "kr.co.ezen.EZUserVO" %>
<%@ page import  = "kr.co.ezen.EZUserDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 실행 페이지</title>
</head>
<body>
	<jsp:useBean id="eVo" class="kr.co.ezen.EZUserVO">
		<jsp:setProperty name="eVo" property="*"/>	
	</jsp:useBean>	
	
	<% 
	String id = request.getParameter("id");
	String pwd = request.getParameter("pwd");	
	
	//데이터베이스 연결 객체 생성
	EZUserDAO edao = new EZUserDAO();
	
	//id check
	String idcheck = edao.getid(id);
	if (idcheck == null) {
%>
		<script type="text/javascript">
		alert("'<%=id%>'는 존재하지 않는 id입니다!! ");
		history.back(-1);
	  	</script>
<%	} else {
			// pwd check
			String pass = edao.getPwd(id);
			String ucheck = edao.getUtype(id);
			
			if(pass.equals(pwd) && ucheck.equals("0")){
			
				session.setAttribute("id", id);
				session.setAttribute("pwd", pwd);
				session.setAttribute("utype", "0");
			%>
			<script type="text/javascript">
				alert('관리자님 환영합니다!!!');
				location.href='../Main.jsp';
			</script>
			<%
			} else if (pass.equals(pwd)) {
				session.setAttribute("id", id);
				session.setAttribute("pwd", pwd);
				session.setAttribute("utype", "1");
			%>
				<script type="text/javascript">
					alert('<%=id%>님 환영합니다!!!');
					location.href='../Main.jsp';
				</script>
				<%	
			} else {
			%>
			<script type="text/javascript">
				alert("비밀번호가 틀립니다. 확인 바랍니다.")
				history.back();//history.go(-1)
			</script>
			<%
			}
			%>	
	<%
	}
	%>
	<b><%= id %></b>님이 로그인 하셨습니다. 
    <form method="post" action="Main.jsp?center=User/UserLogoutT.jsp">
		<input type="submit" value="로그아웃">
    </form>
    
</body>
</html>