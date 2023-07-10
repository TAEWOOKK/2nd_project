<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지글 작성</title>
<style>

	.nwtbl {
		text-align:center;
		width:50%;
		height:70%;
	}
	.nwtbl>tr {
		height:100;
	}
	.nwtbl>td {
		height:100;
	}
	.nwselect {
		width:96%;
		height:30px;
		font-size:15px;
		text-align:left;
	}
	.ess {
		color:red;
	}
	.title {
		width:95%;
		height:70%;
	}
	.details {
		width:95%;
		height:90%;
	}
	select option[value=""][disabled] {
		display: none;
	}	
	.listbtn_wr {
		background-color:white;
		width:50px;
		height:30px;
	}
	.listbtn_wr:hover {
		background-color: #f6f6f6;
	}
</style>
	<script type="text/javascript">
		function update() {
			var ret = confirm("작성하시겠습니까?")
			if(ret == true){

			} else {
				return false;
			}
		}
	</script>
</head>
<body>
	<%
	String id = (String)session.getAttribute("id");
	if(id==null){
	%>
	<script>
		alert("로그인을 먼저 해주세요!");
		location.href='Main.jsp?center=User/UserLoginF.jsp';
	</script>
	<%
	} else {
	%>
	<div align="center">
	<br><br>
		<form method="post" action="Main.jsp?center=/Notice/NoticeWriteP.jsp" onsubmit="return confirm('작성하시겠습니까?');">
			<h2 align="left" style="padding-left:26%;">공지글 쓰기</h2>
			<hr width="48%"/>
			<table class="nwtbl" cellspacing="0">
				<tr>

					<td width="50%">
						<select class="nwselect" name="cat" required="required">
							<option value="" disabled selected>분류</option>
							<option value="normal">Normal</option>
							<option value="important">Important</option>
						</select>
					</td>
				</tr>
				<tr height="50px">

					<td>
						<input class="title" type="text" name="title" maxlength="200" placeholder="제목을 입력해 주세요" autofocus required="required"/>
					</td>
				</tr>
				<tr>
					<td>
						<textarea class="details" name="details" cols="80" rows="30" maxlength="250" placeholder="여기에 내용을 입력하세요." required="required"></textarea>
					</td>
				</tr>
			</table>
			<br>

			<input type="submit" class="listbtn_wr" value="작성"/>&nbsp;&nbsp;&nbsp;
			<input type="button" class="listbtn_wr" onclick="location.href='Main.jsp?center=Notice/NoticeListT.jsp'" value="목록" />		
		</form>
	</div>
	<br><br>
	<% } %>
</body>
</html>