<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="kr.co.ezen.*" %>
<%@ page import="java.util.Vector" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지글 리스트</title>
<style>
	.noticelistt {
		height:700px;
	}
	a {
		text-decoration:none;
		color:black;
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
</head>
<body>

	<%
		String utype = (String)session.getAttribute("utype");
		String id = (String)session.getAttribute("id");
		int pageSize = 10;
	
		String pageNum = request.getParameter("pageNum");
		
		if(pageNum == null) { // 처음이면 첫페이지이면
			pageNum="1";
		}
		
		int count = 0; // 전체글에 대한 갯수 저장 변수
		int number = 0; // 페이지 넘버링 변수
		
		//현재 보고자 하는 페이지를 저장
		int currentPage = Integer.parseInt(pageNum); // 1
	
		// 데이터베이스 연결 객체 생성
		NBoardDAO nbDao = new NBoardDAO();
		count = nbDao.getAllCount();
		
		// 현재 페이지에 보여줄 시작 번호 설정 = 데이터베이스 불러올 시작번호
		int startRow = (currentPage - 1) * pageSize + 1; // (1 - 1) * 10 + 1 => 11
		int endRow = currentPage * pageSize; // 1 * 10  = 10
		
		// DATA Input
		Vector<NBoardVO> vec = nbDao.selectBoard(startRow, endRow);
		
		// 회원목록 페이지로 이동하기
		// response.sendRedirect("memberList.jsp");
		
		// 페이지 표시 번호 설정
		number = count - (currentPage - 1) * pageSize; // 124 - (1 - 1) * 10 = 124
		int totalPage = (count + 9) / 10;
	%>
	<div class="noticelistt">
	<!--  -->
		<br><br>
		<div align="center"><font size="20px"><b>공지</b></font></div><br>
			<div align="center"><font size="3px" color="#969696">'이젠스키'의 새로운 소식을 가장 먼저 알려드립니다.</font></div><br><br><br><br>
		<table class="listtbl" align="center" style="align:center; width:50%;" cellpadding="0" cellspacing="0">
		<tr height="30">
			<td colspan="5" align="left" style="vertical-align:middle; border-top:none;">총 <%=count %>건 [<%=currentPage %> / <%=totalPage %> 페이지]</td>
		</tr>
		<tr height="40" align="center" style="background-color:#f6f6f6;">
			<th width="10%" style="vertical-align:middle;">번호</th>
			<th width="10%" style="vertical-align:middle;">분류</th>
			<th width="50%" style="vertical-align:middle;">제목</th>
			<th width="20%" style="vertical-align:middle;">작성일</th>
			<th width="10%" style="vertical-align:middle;">조회수</th>
		</tr>
		<%
			for(int i=0; i < vec.size(); i++){
				NBoardVO nbVo = vec.get(i);
		%>
		<tr height="30">
			<td align="center" style="vertical-align:middle;">공지</td>
			<td align="center" style="vertical-align:middle;">
			<%
				if(nbVo.getCat().equals("important")){
			%>	
			<font color="red">중요</font>
			<% 
				} else {
			%>	
			일반
			<%
				}
		 	%>
			</td>
			<% 
				if(id!=null){
				String snumb = (String)session.getAttribute("notice"+nbVo.getNumb());
				if(nbVo.getTitle().equals(snumb)){
			%>
			<td align="left" style="vertical-align:middle;"><a href="Main.jsp?center=/Notice/NoticeDetailT.jsp?numb=<%=nbVo.getNumb() %>" style="color:#c8c8c8; text-decoration:none;">&nbsp;<%=nbVo.getTitle() %></a></td>
			<% } else{%>
			<td align="left" style="vertical-align:middle;"><a href="Main.jsp?center=/Notice/NoticeDetailT.jsp?numb=<%=nbVo.getNumb() %>" style="color:black; text-decoration:none;">&nbsp;<%=nbVo.getTitle() %></a></td>
			<% }} else { %>
			<td align="left" style="vertical-align:middle;"><a href="Main.jsp?center=/Notice/NoticeDetailT.jsp?numb=<%=nbVo.getNumb() %>" style="color:black; text-decoration:none;">&nbsp;<%=nbVo.getTitle() %></a></td>
			<%} %>
			<td align="center" style="vertical-align:middle;"><%=nbVo.getWdate() %></td>
			<td align="center" style="vertical-align:middle;"><%=nbVo.getViews() %></td>
		</tr>
		<%
			}
		%>
	</table>
	<br>
		<div align="right" style="padding-right:25%;">
		<%
			if(id==null){
			} else{
				if(utype.equals("0")){ 
		%>	
			<a href="Main.jsp?center=/Notice/NoticeWriteF.jsp"><button class="listbtn_wr">작성</button></a>
		<%		} else {}
			}
		%>
	</div>
	
	
	<!--  -->
	
	<p align="center">
		<%
			if(count > 0) {
				
				int pageCount = count / pageSize + (count % pageSize == 0 ? 0: 1); // 103 / 10 +(103 % 10) = 103 / 10 + 1 = 11
				
				int startPage = 1;
				if(currentPage % 10 != 0) {
					startPage = (int)(currentPage / 10) * 10 + 1; //
				} else {
					startPage = (int)((currentPage / 10 ) -1) * 10 + 1;//- +로 수정 영훈
				}
				// 한 페이지당 표시할 번호수
				int pageBlock = 10;
				
				// 화면에 보여줄 마지막 페이지 숫자
				int endPage = startPage + pageBlock -1;
				
				// 이전 페이지 링크 작성
				if(endPage > pageCount) {
					endPage = pageCount;
				}
				
				if(startPage > 10) {
				%>
					<a href="Main.jsp?center=/Notice/NoticeListT.jsp?pageNum=<%=startPage -10 %>"><button class="listbtn_1"><<</button></a>	
				<%	
				}
				
				for(int i = startPage; i <= endPage; i++){
				%>
				<a href="Main.jsp?center=/Notice/NoticeListT.jsp?pageNum=<%=i %>"><button class="listbtn"><%=i %></button></a>
				<%
				}
				
				// [next] 링크 작성
				if(endPage < pageCount) {
				%>
					<a href="Main.jsp?center=/Notice/NoticeListT.jsp?pageNum=<%=startPage + 10 %>"><button class="listbtn_2">>></button></a>	
				<%
				}
			}
		%>
	</p>
	</div>
</body>
</html>