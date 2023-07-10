<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "kr.co.ezen.RBoardDAO" %>
<%@ page import = "kr.co.ezen.RBoardVO" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>후기글 수정 페이지</title>
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
		int numb=Integer.parseInt(request.getParameter("numb"));
		
		String id = (String)session.getAttribute("id"); 
		
		if(id == null){%>
			<script type = "text/javascript">
			alert('먼저 로그인을 해주세요.');
			location.href='./Main.jsp?center=User/UserLoginF.jsp';
			</script><%
		}else{	
		
		//데이터베이스 연결 객체 생성  (MVC2 방식)
		RBoardDAO rbdao = new RBoardDAO();
	
		
		//data select (데이터 조회)
		RBoardVO RBVO = rbdao.getUpdateBoard(numb);
			
		
	%>
	<div align="center">
		<div align="center">
			<form method="post" action="Main.jsp?center=/Review/ReviewUpdateP.jsp" onsubmit="return confirm('수정하시겠습니까?');">
				<h2 align="left" style="padding-left:26%;">후기글 수정</h2>
				<hr width="48%"/>
				<table class="nwtbl" cellspacing="0">
					
					<tr height="50px">
	
						<td>
							<input class="title" type="text" name="title" maxlength="200" value="<%=RBVO.getTitle() %>" autofocus />
						</td>
					</tr>
					<tr>
						<td>
							<textarea class="details" name="details" cols="80" rows="30" maxlength="500" placeholder="여기에 내용을 입력하세요." required="required"><%=RBVO.getDetails() %></textarea>
						</td>
					</tr>
				</table>
				<br>
	
				<input type="hidden" name="numb" value="<%=RBVO.getNumb() %>" />
				<input type="submit" class="listbtn_wr" value="수정" />&nbsp;&nbsp;&nbsp;
				<input type="button" class="listbtn_wr" value="목록" onclick="location.href='Main.jsp?center=Review/ReviewListT.jsp'" />			
			</form>
		</div>
	</div>
	<% } %>
</body>
</html>