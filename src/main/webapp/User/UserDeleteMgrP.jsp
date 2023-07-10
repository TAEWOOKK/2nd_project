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
<title>회원 탈퇴 처리(관리자용)</title>
</head>
<body>
<%
		String sid = (String)session.getAttribute("id"); 
		
		if(sid == null){
%>
			<script type = "text/javascript">
			alert('먼저 로그인을 해주세요.');
			location.href='../Main.jsp?center=User/UserLoginF.jsp';
			</script>
<%		} else {%>

<%
	request.setCharacterEncoding("UTF-8");
%>

<%  String logid = "";

	 try {
			logid = (String)session.getAttribute("id");
			
			 if(logid == null){
				 
%>				
				<script type="text/javascript">
					alert("로그인하지 않은 상태입니다.");
					location.href='../Main.jsp?center=User/UserLoginF.jsp';
				</script>
<%
			}
			 
	  }catch(Exception e){
		  e.printStackTrace();
	  }
%>

	<jsp:useBean id="ezuvo" class="kr.co.ezen.EZUserVO">
		<jsp:setProperty name="ezuvo" property="*"/>	
	</jsp:useBean>

<%
	String id = ezuvo.getId();
	String password = ezuvo.getPwd(); 	
%>

<%!
	private Boolean delOk1 = false;
%>

<%
	// DAO : 데이터베이스 연결 및 처리 객체 생성
	EZUserDAO ezudao = new EZUserDAO();
	

	// id 존재여부 확인
	String idcheck = ezudao.getid(id);
	
	if(idcheck == null) {
	%>
		<script type="text/javascript">
			alert("'<%=id %>'는 가입 회원이 아닙니다!!!");
			history.back(-1);     
	  	</script>
	<% 
	}
	
	// 로그인한 ID의 관리자, 일반회원 판단 
	EZUserVO ezu2 = ezudao.oneselectUser(logid);

	String pass = null;
	
	if(ezu2.getUtype().equals("0")){    // 관리자
		pass = ezudao.getPwd(logid);
	
	} else {            				// 일반회원
		pass = ezudao.getPwd(id);
	}
	
	Boolean delOk = false;

			
	if(pass.equals(password)){
		
		try {

			ezudao.signUpDelete(ezuvo);     // table 데이터 삭제 처리	

			delOk = true;
			
		} catch (Exception e) {

			throw e;
		}

	}
	
%>	

					
<%
	if(!pass.equals(password)){	        
%>
	<script type="text/javascript">
		alert("관리자 비밀번호가 일치하지 않습니다. 확인 바랍니다.!!!" );  
		history.back();
	</script>							
<%
	}
%>

<%
	if (delOk) {
%>			
		<script type="text/javascript">        
				alert("정상적으로 '<%=id %>' 님의 회원정보 삭제를 완료하였습니다.('<%=delOk %>')");   
				location.href = "../Main.jsp?center=User/UserListT.jsp";
		</script>
<% }
%>
	
<%
}
%>

</body>
</html>