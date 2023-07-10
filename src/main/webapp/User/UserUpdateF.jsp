<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import = "java.sql.*" %>     
<%@ page import  = "kr.co.ezen.EZUserVO" %>
<%@ page import  = "kr.co.ezen.EZUserDAO" %>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title> 마이페이지에서 회원이 직접 가입정보를 수정하는 페이지</title>
</head>
<%
		String sid = (String)session.getAttribute("id"); 
		
		if(sid == null){
%>
			<script type = "text/javascript">
			alert('먼저 로그인을 해주세요.');
			location.href='Main.jsp?center=User/UserLoginF.jsp';
			</script>
<%		} %>
	<script>
        function check_pwd(){
 
            var pwd = document.getElementById('pwd').value;
            var num = pwd.search(/[0-9]/g);
            var eng = pwd.search(/[a-z]/ig);
            var spe = pwd.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);
 
            if(pwd.length < 4 || pwd.length > 12){
                //document.getElementById('pwd_pro_label').innerHTML ='비밀번호는 4글자 이상, 12글자 이하만 이용 가능합니다.';
                alert("비밀번호는 4글자 이상, 12글자 이하만 이용 가능합니다.");
                document.getElementById("pwd").value = "";
                document.getElementById('pwd_pro').value='0';
                return false;
            		}else if(pwd.search(/\s/) != -1){
	            	  alert("비밀번호는 공백 없이 입력해주세요.");
	            	  document.getElementById("pwd").value = "";
	            	  return ;
	            	 }else if(num < 0 || eng < 0 || spe < 0 ){
	            		 alert("영문,숫자,특수문자를 혼합하여 입력해주세요.");
	            		 document.getElementById("pwd").value = "";
                  	  return ;
	            	 }
            
          	  /*else if(num < 0 && eng > 0 && spe > 0 ){
	       	  alert("숫자를 혼합하여 입력해주세요.");
	       	  return ;
	       	 }else if(num > 0 && eng < 0 && spe > 0 ){
	       	  alert("영문을 혼합하여 입력해주세요.");
	       	  return ;
	       	 }else if(num > 0 && eng > 0 && spe < 0 ){
	       	  alert("특수문자를 혼합하여 입력해주세요.");
	       	  return ;
	       	 }else {
       		
       		 }*/
           
			/*if(check_SC == 0){
            	document.getElementById('pwd_pro_label').innerHTML = '비밀번호에 !,@,#,$,% 의 특수문자를 포함시켜야 합니다.'
                return;
            }*/
            
            if(pwd.length < 6){
                document.getElementById('pwd_pro').value='1';
            }
            else if(pwd.length < 9){
                document.getElementById('pwd_pro').value='2';
            }
            else{
                document.getElementById('pwd_pro').value='3';
            }
            if(document.getElementById('pwd').value !='' && document.getElementById('pwd2').value!=''){
                if(document.getElementById('pwd').value == document.getElementById('pwd2').value){
                    document.getElementById('check').innerHTML='비밀번호가 일치합니다.'
                    document.getElementById('check').style.color='blue';
                }
                else{
                    document.getElementById('check').innerHTML='비밀번호가 일치하지 않습니다.';
                    document.getElementById('check').style.color='red';
                }
            }
        }
    </script>
    <script type="text/javascript">
	function CheckKey() {
		//alert(event.keyCode );
		if(!(event.keyCode >= 48 && event.keyCode <= 57)) {
			alert("숫자만 입력 가능합니다.");
			event.returnValue=false;
		}
	}
	</script>
	<script type="text/javascript">
	function checkLogin() {
		
		var form = document.loginForm;
		
		if (form.birth.value.length < 8 || form.birth.value.length > 8) {
			alert("생년월일은 8자로 입력해야 합니다!");
			form.birth.select();
			return;
		}
	}
		
		</script>	
		<script type="text/javascript">
		function checkLogin2() {
			
			var form = document.loginForm;

			
			 if (form.tel.value.length < 11 || form.tel.value.length > 11 ){
				alert("연락처는 11자로 입력해야 합니다!");
				form.tel.focus();
				return;
			}
			
		}
	</script>
    
  
    
<style>
	td{
	vertical-align:middle;
	}
	.adminlist{
		height:800px;
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
		width:100px;
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
</style>
<body>



<%--  String logid = "";

	 try {
			logid = (String)session.getAttribute("id");
			
			 if(logid == null){
				response.sendRedirect("UserLoginF.jsp");
			} 	 
 			 
	  }catch(Exception e){
		  e.printStackTrace();
	  }
--%>


<%

	String id = request.getParameter("id");
	
	EZUserDAO ezudao = new EZUserDAO();
	
	EZUserVO ezu1 = ezudao.oneselectUser(id);
	
%>


<form action="User/UserUpdateP.jsp" method="post">
<!-- <h2 align="center"><b>회원 정보 수정(마이페이지용)</b></h2>  -->
<!--------------------------------- -->
<div class = "adminlist" align="center" style="height:900px;">
<div style="width:30%; text-align:center;">

	
	<span style="font-size:20px; font-weight:bolder;">회원 정보 수정</span>
	<hr style="background-color:black; height:2px;"width="100%"/>

<table border="1" cellspacing="0" cellpadding="0" align="center" width="100%">
		<tr height="40" >
			<td width="100" style="font-size:15px; font-weight:bolder; background-color:#f6f5f0;">아이디</font></td>
			<td width="80" ><%=id %></td>
			
		</tr>

		<tr height="40" >
			<td width="100" style="font-size:15px; font-weight:bolder; background-color:#f6f5f0;">이름</font></td>			
			<td width="80">
			<input type="text" name="name" value="<%=ezu1.getName() %>" pattern="[가-힣]{2,5}" required></td>
			
		</tr>
		<tr height="40">
			<td width="100" style="font-size:15px; font-weight:bolder; background-color:#f6f5f0;">성별</font></td>
			<td width="80">
				<select name="sex" >
					<option value="<%=ezu1.getSex() %>"><%=ezu1.getSex() %></option>
					<option value="남">남</option>
					<option value="여">여</option>
				</select>
			</td>	

		</tr>
		<tr height="40">
			<td width="100" style="font-size:15px; font-weight:bolder; background-color:#f6f5f0;">생년월일</font></td>
			<td width="80">
				<input type="text" name="birth"value="<%=ezu1.getBirth() %>" pattern="(19|20)\d{2}(0[1-9]|1[012])(0[1-9]|[12][0-9]|3[01])" size="20" placeholder="8자리 숫자만 입력해주세요 ex.19940303" onkeypress="CheckKey()" onchange="checkLogin()" required/>  
			</td>				
		</tr>
		
		<tr height="40">
			<td width="100" style="font-size:15px; font-weight:bolder; background-color:#f6f5f0;">휴대폰</font></td>
			<td width="80">
				<input type="text" name="tel" value="<%=ezu1.getTel() %>" pattern="01[016789]\d{3,4}\d{4}" size="20" placeholder="11자리 숫자만 입력해주세요 ex.01012341234" onkeypress="CheckKey()" onchange="checkLogin2()" required/>
			</td>	
		</tr>
		<tr height="40" >
			<td width="100" style="font-size:15px; font-weight:bolder; background-color:#f6f5f0;">거주지역</font></td>
			<td width="80">
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
					<option value="기타">기타</option>
					<option value="청계산원터골">청계산원터골(err발생용!)</option>
				</select>
			</td>		
		</tr>
		<tr height="40" >
			<td width="100" style="font-size:15px; font-weight:bolder; background-color:#f6f5f0;">이메일</font></td>
			<td width="80">
				<input type="email" name="email" value="<%=ezu1.getEmail() %>" />
			</td>	
		</tr>
		
		<tr height="40" >
			<td width="100" style="font-size:15px; font-weight:bolder; background-color:#f6f5f0;">비밀번호</font></td>
			<td width="80" >
				<input type="password" name="pwd" id="pwd" required/>
			</td>	
		</tr>
		
	</table>
	<br>
				<input type="hidden" name="id" value="<%=id %>">&nbsp;&nbsp; <!-- Pro에 넘어갈 id -->	
				<input class="listbtn_wr" type="submit"  value="수정완료"/>
  </div>
</form>
</body>
</html>