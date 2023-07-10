<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import = "kr.co.ezen.EZUserDAO" %>     
<%@ page import = "kr.co.ezen.EZUserVO" %>
<%@ page import = "java.sql.*" %>

<%@ page errorPage="../errors/error_screen.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 수정 처리[관리자용]</title>
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
<%	} else {%>

<% request.setCharacterEncoding("UTF-8"); %>

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
	// String id = request.getParameter("id");  //---- jsp useBean에서 이미 받음
	// String password = request.getParameter("password");	 //----  jsp useBean에서 이미 받음
	
	String id = ezuvo.getId();
	String password = ezuvo.getPwd(); 	
%>


<%	//errorPage  test용
	int t1 = 1111;
	int t2 = 0;
	
	
	t2 = Integer.parseInt(request.getParameter("birth"));  

	int sum = t1 + t2;	
	int div1 = t1 / t2;
%>


	<h2>결과</h2> <br><br>
	덧셈 결과는 <%=t1 %> + <%=t2 %> = <%=sum %> 입니다. <br><br>
	나눗셈 결과는 <%=t1 %> / <%=t2 %> = <%=div1 %> 입니다. <br><br>


<%

	if(sum == 2222) {
%>
 
		<script type="text/javascript">
			alert(" 테스트용 연산 결과입니다. 작성...." + "sum = '<%=sum %>'");
			history.back(-1);     
		 </script>
	  	 
<%
	}
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
	

	Boolean updateOk = false;

			
	if(pass.equals(password)){
		
		try {

			ezudao.signUpChangeMgr(ezuvo);                              // table 데이터 수정 처리	

			updateOk = true;
			
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
	if (updateOk) {
%>			
		<script type="text/javascript">        
				alert("정상적으로 '<%=id %>' 회원님의 정보 변경을 완료하였습니다.('<%=updateOk %>')");   
				location.href = "../Main.jsp?center=User/UserListT.jsp";
		</script>
<% }
%>
	
<%
}
%>

</body>

</html>