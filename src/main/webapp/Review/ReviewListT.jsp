<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "kr.co.ezen.RBoardDAO" %>
<%@ page import = "kr.co.ezen.RBoardVO" %>   
<%@ page import = "java.util.Vector" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>후기글 리스트</title>
</head>
<style>
	
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
</style>
<body style="height:700px;">

	
<%
	int pageSize = 10;
	
	String pageNum = request.getParameter("pageNum");
	
	if(pageNum == null){//처음이면 = 첫페이지면
			pageNum = "1";
	
	}
	
	int count = 0; //전체글에 대한 갯수저장 변수
	int number = 0; //페이지 넘버링 변수
	
	//현재보고자하는 페이지를 저장
	int currentPage = Integer.parseInt(pageNum);
	
	
	//데이터베이스 연결 객체 생성  (MVC2 방식)
	RBoardDAO rbdao = new RBoardDAO();
	count = rbdao.getAllCount();
	
	
	//현재 페이지에 보여줄 시작 번호 설정 = 데이터베이스를 불러올 시작번호
	int startRow = (currentPage - 1) * pageSize + 1;//(1 - 1) * 10 + 1 => 10 + 1 = 11
	int endRow = currentPage * pageSize; // 1 * 10 = 10
	
	
	//data input (데이터 조회)
	Vector<RBoardVO> vec = rbdao.selectBoard(startRow, endRow);
	
	//페이지 표시 번호 설정
	number = count - (currentPage - 1) * pageSize;//게시글 105 - (1 - 1) * 10 = 105
	int totalPage = (count + 9) / 10;
%>
	
		
		
		<br><br>
			<div align="center"><font size="20px"><b>후기</b></font></div><br>
			<div align="center"><font size="3px" color="#969696">'이젠스키'에서의 소중한 추억을 올려주세요.</font></div><br><br><br><br>
		

	<table class="listtbl" align="center" style="width:50%;" cellpadding="0" cellspacing="0">
				<tr height="30">
			<td colspan="5" align="left" style="vertical-align:middle; border-top:none;">총 <%=count %>건 [<%=currentPage %> / <%=totalPage %> 페이지]</td>
		</tr>
		<tr height="40" align="center" style="background-color:#f6f6f6;">
			<th width="10%" style="vertical-align:middle;">번 호</th>
			
	<%int count2 = 0; //전체글에 대한 갯수저장 변수 %>
			
			<th width="50%" style="vertical-align:middle;">제 목</th>
			<th width="10%" style="vertical-align:middle;">글쓴이</th>
			<th width="20%" style="vertical-align:middle;">작성일자</th>
			
	   	</tr>
			
		<%
			for(int i=0; i < vec.size(); i++){
				
			RBoardVO RBVO = vec.get(i);
				
		%>
			
		<tr height="30" align="center">
			<td style="vertical-align:middle;" ><%=number-- %></td>
			<td align="left" width="150" style="vertical-align:middle;">
				<a href= "Main.jsp?center=Review/ReviewDetailT.jsp?numb=<%=RBVO.getNumb() %>" style="text-decoration: none">

			<%
				int num = rbdao.getAllReview(RBVO.getRef());
				String id = (String)session.getAttribute("id");
			
				if(id!=null){
				String snumb = (String)session.getAttribute("notice"+RBVO.getNumb());
				if(RBVO.getTitle().equals(snumb)){
		
			%>
			
			<font style="color:#c8c8c8;"><%=RBVO.getTitle() %></font>&nbsp;<font size="2px" color="red">
			<% } else{%>
					<%=RBVO.getTitle() %>&nbsp;
			<font size="2px" color="red">
			<%}} else {%> 
				<%=RBVO.getTitle() %><font size="2px" color="red">
				<%} 
				if(num==0){} else {%>
			<%=num %>
			<%} %>
			</font></a></td>
			<td style="vertical-align:middle;"><%=RBVO.getWriter() %></td>
			<td style="vertical-align:middle;"><%=RBVO.getWdate() %></td>
	
			<!-- 원본 확인 필요 지점 -->
			
		</tr>
		
		<% }%>
		
		
		
		
		

	</table>
	<br>
		<div align="right" style="padding-right:25%;">
		<a href="Main.jsp?center=Review/ReviewWriteF.jsp"><button class="listbtn_wr">작성</button></a>
		</div>
		<p align="center">
		
		<%
			if(count > 0){
				
				int pageCount = count / pageSize + (count % pageSize == 0 ? 0:1);
			
				int startPage = 1;
				
				if(currentPage % 10 != 0){
					startPage = (int)(currentPage / 10) * 10 + 1;
				
				}else{
					startPage = (int)((currentPage / 10) - 1) * 10 + 1;
					
					
				}
				//한페이지당 표시할 번호수
				int pageBlock = 10;
				
				//화면에 보여줄 마지막 페이지 숫자
				int endPage = startPage + pageBlock -1; //11 + 10 - 1 = 20
				
				//이전 페이지 링크 작성
				if(endPage > pageCount){
					
					endPage = pageCount;
					
				}
				if(startPage > 10){
				%>
					
				<a href = "Main.jsp?center=Review/ReviewListT.jsp?page=<%=startPage - 10 %>"><button class="listbtn_1"><<</button></a>
					
				<%
				}
				for(int i = startPage; i <= endPage; i++){
					%>
					<a href="Main.jsp?center=Review/ReviewListT.jsp?pageNum=<%=i %>"><button class="listbtn"><%=i %></button></a>
					
					<%
					
				}
				//[next]링크 작성
				if(endPage < pageCount){
					%>
					<a href="Main.jsp?center=Review/ReviewListT.jsp?pageNum=<%=startPage + 10 %>"><button class="listbtn_2">>></button></a></p>
					
				<%}
				
				
				
			}
		
		
		%>
	
	
	

</body>
</html>