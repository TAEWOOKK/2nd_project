<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import = "java.sql.*" %>     
<%@ page import  = "kr.co.ezen.EZUserVO" %>
<%@ page import  = "kr.co.ezen.EZUserDAO" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 페이지</title>
<style>
	.usersignin{
		height:900px; width:100%;
	}
</style>
</head>
	
	<script>
		function printName()  {
			  const id = document.getElementById('id').value;
			  location.href="User/UserIDcheckP.jsp?id=" + id;
			}
	</script>
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

<body>
<div class="usersignin">
<br><br>
<%
	String id = request.getParameter("id");
	//DB 연결 
	EZUserDAO edao = new EZUserDAO();
	EZUserVO ezu1 = new EZUserVO();
	
	String userid = request.getParameter("userid");
	String dcheck = request.getParameter("dcheck");
%>

<span style="font-size:20px;font-weight:bold;">회원가입</span><br><br>
<br>
<form name ="loginForm" action="User/UserSignUpP.jsp" method="post" name="frm">
<h2 align="center">----------------------------------<img src="images\alert.PNG" height="10" alt="alert" style="display:inline;">----------------------------------</h2>
	<br>
	<h2 align="center"><font size="1em" color="green">입력하신 정보는 회원님의 동의 없이 공개되지 않으며, 개인정보 보호정책에 의해 보호를 받습니다.<br>
	(*)표시 항목은 필수 입력 정보입니다. 
	</font></h2>
	<br><br>
	<table border="1" width="650" align="center">
		<tr height="40" >
			<td width="300"align="center">
			<font size="2em" color="green">아이디*</font></td>
			<td width="70">
			<%if(userid ==null){ %>
			<input class="input" type="text" name="id" id="id" maxlength="20" autofocus required>
			<%}
			else{%>
			<input class="input" type="text" name="id" id="id" maxlength="20" autofocus required readonly="readonly" value="<%=userid%>" style="background-color: #ECEBE3;">
				<% 
			}
			%>
	   <input class="inputbutton" type="button" value="중복확인" onclick="printName()">
			</td>
		</tr>
		<tr height="40" align="center">
			<td width="300"align="center"><font size="2em" color="green">비밀번호*</font></td>
			<td width="80">
				<input type="password" name="pwd" size="60" id="pwd"  onchange="check_pwd()" value = "" placeholder="영문, 숫자, 특수문자포함 4자리이상 12자리 이하로 입력" required/>
				<br><span style="color:cadetblue">보안성</span> <progress id="pwd_pro" value="0" max="3"></progress><br><span id="pwd_pro_label"></span>
			</td>	
		</tr>
		<tr height="40" align="center">
			<td width="300"align="center"><font size="2em" color="green">비밀번호 확인*</font></td>
			<td width="80">
				<input type="password" name="pwd2" id="pwd2"  onchange="check_pwd()" value = ""  size="60" required/>&nbsp;<span id="check"></span>
			</td>	
		</tr>
		<tr height="40" align="center">
			<td width="300"align="center"><font size="2em" color="green">이름*</font></td>
			<td width="80">
				<input type="text" name="name" size="60"  pattern="[가-힣]{2,5}" required />
			</td>	
		</tr>
		<tr height="40">
			<td width="300"align="center"><font size="2em" color="green">성별</font></td>
			<td width="80">
				<select name="sex">
					<option value="남">남</option>
					<option value="여">여</option>
				</select>
			</td>	

		</tr>
		<tr height="40">
			<td width="300"align="center"><font size="2em" color="green">생년월일</font></td>
			<td width="80">
				<input type="text" name="birth" pattern="(19|20)\d{2}(0[1-9]|1[012])(0[1-9]|[12][0-9]|3[01])" size="60" placeholder="8자리 숫자만 입력해주세요 ex.19940303" onkeypress="CheckKey()" onchange="checkLogin()"/>  
			</td>	
		</tr>
		
		<tr height="40">
			<td width="300"align="center"><font size="2em" color="green">휴대폰*</font></td>
			<td width="80">
				<input type="text" name="tel" pattern="01[016789]\d{3,4}\d{4}" size="60" placeholder="11자리 숫자만 입력해주세요 ex.01012341234" onkeypress="CheckKey()" onchange="checkLogin2()" required/>
			</td>	
		</tr>
		<tr height="40" >
			<td width="300"align="center"><font size="2em" color="green">거주지역</font></td>
			<td width="80">
				<select name="city">
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
				</select>
			</td>		
		</tr>
		<tr height="40" align="center">
			<td width="300"><font size="2em" color="green">이메일*</font></td>
			<td width="80">
				<input type="email" name="email" size="60" placeholder="id@domain.com" required  maxlength = "20"/>
			</td>	
		</tr>
		<tr height="40" align="center" bgcolor = #f6f6f6 >
			<td colspan="2" style="vertical-align: middle">
				<input type="reset" value="취소"/>&nbsp;&nbsp;
				<%if(dcheck == null) {%> 
				<input type="button" onclick="javascript:btn()" value="가입완료">
				<script type="text/javascript">
				function btn(){
					alert("아이디 중복 체크 해주세요!");
				}
				</script>
				<%
				}
				else{
				
				%>
				<input type="submit" onclick="return confirm('입력하신 정보로 회원가입하시겠습니까?')" value="가입완료"/>
				<%
				}
				%>
			</td>	
		</tr>		
	</table>
	</form>
	</div>

</body>
</html>