<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "kr.co.ezen.EZUserDAO" %>     
<%@ page import = "kr.co.ezen.EZUserVO" %>
<%@ page errorPage="../errors/error_screen.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보 수정 화면 (관리자용)</title>
</head>

    <script type="text/javascript">
	function CheckNumPress() {
		//alert(event.keyCode );
		if(!(event.keyCode >= 48 && event.keyCode <= 57)) {
		
			event.returnValue=false;
			
			alert("숫자만 입력 가능합니다.");
		}
	}
	</script>
	

<style>
	.adminlist{
		height:900px;
	}
	a {
		text-decoration:none;
	
	}
	.listbtn {
		background-color:white;
		width:30px;
		height:30px;
	}
	.listbtn:hover {
		background-color: #D2D2FF;
	}
	.listbtn_1 {
		width:30px;
		height:30px;
	} 
	.listbtn_2 {
		width:30px;
		height:30px;
	} 
	.listbtn_wr {
		background-color:white;
		width:50px;
		height:30px;
	}
	.listbtn_wr:hover {
		background-color: #f6f6f6;
	}
	.listtbl th{
		border-top: 1px black solid;
		border-bottom: 1px black solid;
	}
	.listtbl td {
		border-top: 0.5px #dcdcdc solid;
		border-bottom: 0.5px #dcdcdc solid;		
	} 
	.listtbl th:first-child,
	.listtbl td:first-child {
		border-left: 0;
	}
	.listtbl th:last-child,
	.listtbl td:last-child {
		border-right: 0;
	}
	td{
	  vertical-align:middle;
	 
	}
</style>


<body>
<%
		String sid = (String)session.getAttribute("id"); 
		
		if(sid == null){
%>
			<script type = "text/javascript">
			alert('먼저 로그인을 해주세요.');
			location.href='Main.jsp?center=User/UserLoginF.jsp';
			</script>
<%		}  else {%>

<% request.setCharacterEncoding("UTF-8"); %>


<%  String logid = "";

	 try {
			logid = (String)session.getAttribute("id"); 
			
			 if(logid == null){
				response.sendRedirect("UserLoginF.jsp");
			}
	  }catch(Exception e){
		  e.printStackTrace();
	  }
%>


<%

	String id= request.getParameter("id");
	
	EZUserDAO ezudao = new EZUserDAO();	
	
	EZUserVO ezu1 = ezudao.oneselectUser(id);

%>

<%

	// 로그인 ID 관리자여부 체크 :  회원유형 '0'
	EZUserVO ezu2 = ezudao.oneselectUser(logid);

	if(!ezu2.getUtype().equals("0")){   //관리자는 회원유형이 '0'임 
%>
		<script type="text/javascript">         
			alert("이 화면은 관리자가 사용합니다.!!!");
			history.back();//history.go(-1)
		</script>		
<%
	}
%>

<%
	String utype = null;
		
	switch(ezu1.getUtype()) {
		
	    case "1":   utype = "일반";
	    			break;
	    case "2":   utype = "VIP";
					break;
	    case "7":   utype = "직원";
					break;
	    case "0":   utype = "관리자";
					break;							
	    default:	utype = ezu1.getUtype();
	       			break;
    }

%>




<form name ="UpdateMgrForm" action="User/UserUpdateMgrP.jsp" method="post">

<div class = "adminlist">
		<br><br>
		<span style="font-size:30px;font-weight:bold;">회원정보 수정</span><br><br><br><br><br><br>

	<div style="width:30%; text-align:left;">
		<span style="font-size:20px; font-weight:bolder;">관리자용</span>
		<hr style="background-color:black; height:2px;"/> 
	</div>
	
	
	<div align="center" >
		<table border = "1" align="center" style="width:600;" >
			<tr height="40" align="center">
				<td  width="150"  style="background: #f6f5f0;">아이디</td>
				<td width="350"><%=ezu1.getId() %></td>
			</tr>	
					

			<tr height="40" align="center">
				<td width="150" style="background: #f6f5f0;">이   름</td> <!-- *한글 2~5자* -->
				<td width="350"><input type="text" style = "text-align:center" maxlength = "20" name="name" value="<%=ezu1.getName() %>"  pattern="[가-힣]{2,5}" required></td>

			</tr>
			
			<tr height="40" align="center">
				<td width="150" style="background: #f6f5f0;">성   별</td> 
				<td>
					<select name="sex">
						<option value="<%=ezu1.getSex() %>"><%=ezu1.getSex() %></option>
						<option value="남">남</option>
						<option value="여">여</option>
					</select>
				</td>		
			
			<tr height="40" align="center">
				<td width="150"  style="background: #f6f5f0;">생년월일</td> <!-- 패턴 19940303 / 타이핑시 숫자 확인 / 이동(탭)시 입력숫자갯수 확인 -->
				<td width="350">	
					<input type="text" style="text-align:center" maxlength = "8" name="birth"value="<%=ezu1.getBirth() %>" pattern="(19|20)\d{2}(0[1-9]|1[012])(0[1-9]|[12][0-9]|3[01])" size="20" onkeypress="CheckNumPress()"  required/>  
				</td>		
			</tr>

	
			<tr height="40" align="center">
				<td width="150" style="background: #f6f5f0;">폰/전화</td> <!-- 패턴 01*+ 999(9)+ 9999 / 타이핑시 숫자 확인  / 이동(탭)시 숫자갯수 확인  -->
				<td width="350">
					<input type="text" style="text-align:center" maxlength = "11" name="tel" value="<%=ezu1.getTel() %>" pattern="01[016789]\d{3,4}\d{4}" size="20" onkeypress="CheckNumPress()" required/>
				</td>	

			</tr>
	
			<tr height="40" align="center">
				<td width="150"  style="background: #f6f5f0;">지   역</td>
				<td>
					<select name="city">
						<option value="<%=ezu1.getCity() %>"><%=ezu1.getCity() %></option>
						<option value="서울">서울</option>
						<option value="경기">경기</option>
						<option value="인천">인천</option>
						<option value="강원">강원</option>
						<option value="충남">충남</option>
						<option value="대전">대전</option>
						<option value="충북">충북</option>
						<option value="부산">부산</option>
						<option value="울산">울산</option>
						<option value="대구">대구</option>
						<option value="경북">경북</option>
						<option value="경남">경남</option>
						<option value="전남">전남</option>
						<option value="광주">광주</option>
						<option value="전북">전북</option>
						<option value="제주">제주</option>
						<option value="기타">기타ㅣ</option>
					</select>
				</td>					
			</tr>
			
			
			<tr height="40" align="center">
				<td width="150" style="background: #f6f5f0;">이메일</td>  <!-- / 패턴 : 이메일 형식만 가능  [a-z0-9\.\-_]+@([a-z0-9\-]+\.)+[a-z]{2,6}$ -->
				<td width="350">
					<input type="text" style = "text-align:center" maxlength = "20" name="email" value="<%=ezu1.getEmail() %>" pattern="[a-z0-9\.\-_]+@([a-z0-9\-]+\.)+[a-z]{2,6}$" size="30" required />
				</td>
			</tr>
			
			<tr height="40" align="center">
				<td width="150" style="background: #f6f5f0;">회원유형</td>
				<td>
					<select name="utype">
						<option value="<%=ezu1.getUtype() %>"><%= utype %></option>
						<option value="1">일반</option>
						<option value="0">관리자</option>

					</select>
				</td>				
			</tr>
			
			<tr height="40" align="center">
				<td width="150"  style="background: #f6f5f0;">가입일자</td>
				<td width="350"><%=ezu1.getEdate() %></td>
			</tr>
			
			<tr height="40" align="center">
				<td width="150" style="background:lightgrey;">관리자 아이디</td>
				<td width="350"><%=logid %></td>
			</tr>
			
			<tr height="40" align="center">
				<td width="150" style="background:lightgrey;">관리자 비밀번호</td>
				<td width="350"><input type="password" name="pwd" style = "text-align:center" ></td> 
			</tr>

			<!-- input data exception 처리 test용  : errPage 구현 -->
			<!-- 
			<tr height="40" align="center">
				<td width="150" style="background:lightgrey;">테스트 넘버</td>
				<td width="100"><input type="text" name="testnum1" style = "text-align:center" ></td> 
				<td width="100"><input type="text" name="testnum2" style = "text-align:center" ></td> 
				
			</tr>
			 -->

		</table>
			</tr>
				<td>
					<input type="hidden" name="id" value="<%=ezu1.getId()%>">&nbsp;&nbsp; <!-- Pro에 넘어갈 id -->
					<br><br>
					<input class="listbtn_wr" type="submit" value="수정">&nbsp;&nbsp;
					<input class="listbtn_wr" type="button" value="목록" onclick="location.href='Main.jsp?center=User/UserListT.jsp'">
				</td>
			</tr>
	</div>
 </div>
</form>

<%} %>
</body>
</html>