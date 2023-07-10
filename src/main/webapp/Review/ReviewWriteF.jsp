<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "kr.co.ezen.RBoardDAO" %>
<%@ page import = "kr.co.ezen.RBoardVO" %>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
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
<body>

<%
		String sid = (String)session.getAttribute("id"); 
		
		if(sid == null){
%>
			<script type = "text/javascript">
			alert('먼저 로그인을 해주세요.');
			location.href='Main.jsp?center=User/UserLoginF.jsp';
			</script>
<%		}else{ %>
	<div align="center">
	<form action="Main.jsp?center=Review/ReviewWriteP.jsp" method="post" onsubmit="return confirm('작성하시겠습니까?');">
		<h2 align="left" style="padding-left:26%;">후기글 쓰기</h2>
		<hr width="48%"/>
		<table class="nwtbl" cellspacing="0">
			<tr height="50px">
				<td>
					<input class="title" type="text" name="title" placeholder="제목을 입력해 주세요" autofocus required="required" maxlength="200"/>
				</td>
			</tr>			
				
			
			<tr>
				<td>
					<textarea class="details" name="details" cols="80" rows="30" placeholder="여기에 내용을 입력하세요." required="required" maxlength="250"></textarea>
				</td>
			</tr>
			
			
		</table>
		<br>
			<input type="hidden" name="writer" value="<%=session.getAttribute("id") %>"/>
			<input type="submit" class="listbtn_wr" value="작성"/>&nbsp;&nbsp;&nbsp;
			<input type="button" class="listbtn_wr" onclick="location.href='Main.jsp?center=Review/ReviewListT.jsp'" value="목록" />	
		
		
			
		
	</form>

</div>



		<%}%>

</body>
</html>

