<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 로그인 페이지</title>
<style>
	.userlogin{
		height:700px;
	}
</style>
</head>
<script type="text/javascript">
function checkLogin() {
	var form = document.loginForm;
	if (form.id.value=="") {
		alert("아이디를 입력해주세요.");
		form.id.focus();
		return false;
	} else if (form.pwd.value==""){
		alert("비밀번호를 입력해주세요.");
		form.pwd.focus();
		return false;
	}
	form.submit();
}
</script>

<body>
<div class="userlogin">
<br><br>
<span style="font-size:20px;font-weight:bold;">로그인</span><br><br>
<br>
	<form name="loginForm" action="User/UserLoginP.jsp" method="post">
	<span align="center">----------------------------------<img src="images/alert.PNG" width="10" height="10" alt="alert" style="display:inline;">----------------------------------</span>
	<br><br>
	<h2 align="center"><font size="1em" color="#3232FF">가입하신 아이디와 비밀번호를 입력해주세요<br>
	비밀번호는 대소문자를 구분합니다.
	</font></h2>
	<br><br>	
		<table border="1" align="center" width="400"> 
			<tr height="40" align="center" >
				<td width="80">
					<img src="images/id.PNG" width="13" height="13" alt="id"> 
				</td>
				<td>
					<input type="text" name="id" size="40" placeholder="아이디" style="height:20px" autofocus >
				</td>
			</tr>
			<tr height="40" align="center" >
				<td width="80">
					<img src="images/lock.PNG" width="13" height="13" alt="pwd"> 
				</td>
				<td>
					<input type="password" name="pwd" size="40" placeholder="비밀번호" style="height:20px" >
				</td>
			</tr>
			<tr align="center" height="40">
				<td colspan="2" bgcolor=#f6f6f6 style="vertical-align: middle">
					<input  type="submit" value="로그인" onclick="checkLogin()"/>&nbsp;&nbsp;&nbsp;
				</td>
			</tr>	
		</table>   
			
		<table align="center" width="400">
			<tr align="center" height="40">
				<td colspan="2" style="vertical-align: middle">
					<input type="button" value="회원가입"	onclick="location.href='Main.jsp?center=User/UserSignUpF.jsp'">&nbsp;&nbsp;
					<input type="reset" value="취소"/>
				</td>
			</tr>
	  	</table>
	</form>
</div>
</body>
</html>