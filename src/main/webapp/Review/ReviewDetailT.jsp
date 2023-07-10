<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "kr.co.ezen.RBoardDAO" %>
<%@ page import = "kr.co.ezen.RBoardVO" %> 
<%@ page import = "java.util.Vector" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>후기글 상세보기</title>

</head>
<style>

	boby{bottom:300;}
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
		width:80%;
		font-size:15px;
		text-align:center;
	}
	.title {
		width:99%;
		height:75%;
	}
	.details {
		width:99%
	}
	.listbtn {
		width:80px;
		height:40px;
		background-color:white;
	}
	.listbtn:hover {
		background-color:aliceblue;
	}
	.listform {
		display:inline;
	}
</style>
<body>
	


	<%
		int numb = Integer.parseInt(request.getParameter("numb"));
		
		//데이터베이스 연결 객체 생성  (MVC2 방식)
		RBoardDAO rbdao = new RBoardDAO();
	
	
		//data select (데이터 조회)
		RBoardVO RBVO = rbdao.oneselectBoard(numb);
		RBoardVO RVO2 = rbdao.prevSelectBoard(numb);
		RBoardVO RVO3 = rbdao.nextSelectBoard(numb);
		
		String id = (String)session.getAttribute("id");
		
		String utype = (String)session.getAttribute("utype");
		
		if(session.getAttribute("id")!=null){
			session.setAttribute("notice" + RBVO.getNumb(), RBVO.getTitle());
		}
	%>

	
	<div align="center">
	
	<div align="center"><font size="20px"><b>후기</b></font></div><br>
			<div align="center"><font size="3px" color="#969696">'이젠스키'에서의 소중한 추억을 올려주세요.</font></div><br><br><br><br>
			<div align="center" style="width:75px; height:23px; background-color:royalblue;"><font size="2px" color="white"><b>이젠스키</b></font></div><br>
			<div align="center"><font size="16px"><%=RBVO.getTitle() %></font></div>
			<hr align="center" style="width:8%; border:solid 1.5px black"/><br>
			<div align="center"><span><b>작성일</b>&nbsp;&nbsp;<%=RBVO.getWdate() %></span></div><br>
			<hr style="width:70%; color:#dcdcdc;"/>
			
			<br>
			<table align="center" style="width:40%;">
				<tr height="300px">
					<td align="center" style="vertical-align:middle;"><%=(RBVO.getDetails()).replace("\r\n","<br>") %></td>
				</tr>
			</table>
			
			<br>
			<hr style="width:70%; color:#dcdcdc;"/>
			<br>
			<div align="right" style="padding-right:15%;">
					<a href="Main.jsp?center=Review/ReviewListT.jsp"><button class="listbtn" >목록</button></a>&nbsp;
					
				<%	
				if(id==null){
				
				
				
				
				}else{
				
				if(RBVO.getWriter().equals(id)){%>		
					
					<form class="listform" action="Main.jsp?center=Review/ReviewDeleteT.jsp?numb=<%=RBVO.getNumb()%>&ref=<%=RBVO.getRef() %>" method="post" onsubmit="return confirm('삭제하시겠습니까?');"><button class="listbtn">
					삭제</button></form>&nbsp;
					
					<a href="Main.jsp?center=Review/ReviewUpdateF.jsp?numb=<%=RBVO.getNumb()%>"><button class="listbtn">수정</button></a>
				
				<%}else {
					
					
						if(utype.equals("0")){%>
					
					
					<form class="listform" action="Main.jsp?center=Review/ReviewDeleteT.jsp?numb=<%=RBVO.getNumb()%>&ref=<%=RBVO.getRef() %>" method="post" onsubmit="return confirm('삭제하시겠습니까?');"><button class="listbtn">
					삭제</button></form>&nbsp;
					
					<a href="Main.jsp?center=Review/ReviewUpdateF.jsp?numb=<%=RBVO.getNumb()%>"><button class="listbtn">수정</button></a>
				
					
						<% }%>
					
				<%} }%>
						</div>
	
	
		<br><br>

	</div>
	
	
	
		
	
	<div align="center">

	<h2 align="left" style="width:70%">댓글</h2><br>
	<div style="background-color:#e9e9e9; width:70%; text-align:left;">
	
	
		<br>
	
	<%
	int pageSize = 10;
	
	String pageNum = request.getParameter("pageNum");
	
	if(pageNum == null){//처음이면 = 첫페이지면
		pageNum = "1";
	
	}
	int count = 0; //전체글에 대한 갯수저장 변수
	
	int number = 0; //페이지 넘버링 변수
	
	//현재보고자하는 페이지를 저장
	int currentPage = Integer.parseInt(pageNum);//1
	
	
	//데이터베이스 연결 객체 생성  (MVC2 방식)
	RBoardDAO rbdao2 = new RBoardDAO();
	count = rbdao2.getAllCount2(RBVO.getRef());
	
	//현재 페이지에 보여줄 시작 번호 설정 = 데이터베이스를 불러올 시작번호
	int startRow = (currentPage - 1) * pageSize + 1;//(1 - 1) * 10 + 1 => 10 + 1 = 11
	int endRow = currentPage * pageSize; // 1 * 10 = 10
	
	
	
	
	
	//페이지 표시 번호 설정
	number = count - (currentPage - 1) * pageSize;//게시글 105 - (1 - 1) * 10 = 105
	int totalPage = (count + 9) / 10;

	//data input (데이터 조회)
	Vector<RBoardVO> vec = rbdao2.REselectBoard(RBVO.getRef() ,startRow, endRow);

			
	
	for(int i=0; i < vec.size(); i++){
				
	RBoardVO RBVO2 = vec.get(i);
				
		%>
		<font size="2px" color="#808080">
		
		
		&nbsp;&nbsp;<b><%=RBVO2.getWriter() %></b>
		
		&nbsp;&nbsp;<b><%=RBVO2.getWdate() %></b>
		<%
			String a = RBVO.getWriter();			
			String b = RBVO2.getWriter();
		
			if(a.equals(b)){ %>
		
				 &nbsp;&nbsp;<font size="1px" color="#7878FF">작성자</font>
		
		<%}%>
			<%
			
			if(id==null){
			
			}else{
			
			if(RBVO2.getWriter().equals(id)){%>		
				
				&nbsp;&nbsp;
				<b><font size="1px" >
				<a style= "color:#FF5A5A;" href ="Main.jsp?center=Review/ReDeleteT.jsp?numb=<%=RBVO2.getNumb()%>&numb2=<%=RBVO.getNumb()%>" onClick="return confirm('삭제하시겠습니까?')">[삭제]</a></font></b>
				
				<%}else {
						if(utype.equals("0")){ 	%>
							
					&nbsp;&nbsp;
				<b><font size="1px" >
				<a style= "color:#FF5A5A;" href ="Main.jsp?center=Review/ReDeleteT.jsp?numb=<%=RBVO2.getNumb()%>&numb2=<%=RBVO.getNumb()%>" onClick="return confirm('삭제하시겠습니까?')">[삭제]</a></font></b>
					
				
					
					
					<%}%>
				<%}%>
			
					
			<%}%>
			
			
		
		</font>
		<br><br>
		 &nbsp;&nbsp;<%=RBVO2.getDetails().replace("\r\n","<br>&nbsp;&nbsp;") %>	
				
		<br><br>
		<%} %>
	</div>
	
	<br>
	
	<form action="Review/ReWriteP.jsp" method="post" onsubmit="return confirm('작성하시겠습니까?');">
		<div style=" width:100%;">
			<table align="center" style=" width:70%;">
				<tr>
					<td><textarea align="center"  class="details" name="details" cols="200" rows="3" placeholder="여기에 내용을 입력하세요." required="required" maxlength="100"></textarea></td>
					<td style="vertical-align:middle;"><input type="submit" value="작성" class="listbtn" /></td>
				</tr>
			</table>
			<input type="hidden" name="writer" value="<%=session.getAttribute("id") %>" />
			<input type="hidden" name="numb" value="<%=RBVO.getNumb()%>" />
			<input type="hidden" name="ref" value="<%=RBVO.getRef()%>" />
			<input type="hidden" name="ref_step" value="<%=RBVO.getRef_step()%>" />
			<input type="hidden" name="ref_level" value="<%=RBVO.getRef_level()%>" />
		<br><br>
		</div>
		
	</form>
	
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
				
			<a href = "Main.jsp?center=Review/ReviewDetailT.jsp?numb=<%=numb %>&pageNum=<%=startPage - 10 %>">[<<]</a>
				
			<%
			}
			for(int i = startPage; i <= endPage; i++){
				%>
				<a href="Main.jsp?center=Review/ReviewDetailT.jsp?numb=<%=numb %>&pageNum=<%=i %>">[<%=i %>]</a>
				
				<%
				
			}
			//[next]링크 작성
			if(endPage < pageCount){
				%>
				<a href="Main.jsp?center=Review/ReviewDetailT.jsp?numb=<%=numb %>?&pageNum=<%=startPage + 10 %>">[>>]</button></a></p>
				
			<%}
			
			
		
	}


%>
	</div>
	<br><br><br><br>
	<table align="center" width="70%" style="text-aling:left;">
		
			
			<tr height="40px">
				<td>다음글</td>
				<%
					if(RVO3.getTitle()==null){
				%>
					<td><font color="#FF8C8C">다음 글이 존재하지 않습니다.</font></td>
				<%
					} else {
				%>
				<td>
					<a href="Main.jsp?center=/Review/ReviewDetailT.jsp?numb=<%=RVO3.getNumb() %>" style="color:black; text-decoration:none;"><%=RVO3.getTitle() %></a>
				</td>
				<%} %>
			</tr>
				<tr height="40px">
				<td width="100px;">이전글</td>
				<%
					if(RVO2.getTitle()==null){
				%>
					<td><font color="#FF8C8C">이전 글이 존재하지 않습니다.</font></td>
				<%
					} else {
				%>
				<td>
					<a href="Main.jsp?center=/Review/ReviewDetailT.jsp?numb=<%=RVO2.getNumb() %>" style="color:black; text-decoration:none;"><%=RVO2.getTitle() %></a>
				</td>
				<%} %>
			</tr>
			</table>
			<br><br>
	
	
</body>
</html>