<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import= "kr.co.ezen.*" %> 
<%@ page import = "java.util.Vector" %>  

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 페이지</title>
</head>
<style>
	h2 {
		font-weight:bolder;
		font-size: 20px;
		color:#8c8c8c;
	}
	td {
		border-bottom:1px solid black;

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
		width:200px;
		height:30px;
	}
	.listbtn_wr:hover {
		background-color: #3c3c3c;
		color:white;
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
<% request.setCharacterEncoding("UTF-8"); %>

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

<%  String logid = "";

	 try {
			logid = (String)session.getAttribute("id");
			
			 if(logid == null){
				 
%>				
				<script type="text/javascript">
					alert("로그인하지 않은 상태입니다.");
					location.href='../Main.jsp?center=User/UserLoginF.jsp';
				</script>
<%
			}
			 
	  }catch(Exception e){
		  e.printStackTrace();
	  }
%>


<%
	// 회원 객체 생성 , 조회 
	EZUserDAO ezudao = new EZUserDAO();	
	Vector<EZUserVO> vecUser = ezudao.selectUser();	

	// 후기글 객체 생성, 조회
	RBoardDAO rbdao = new RBoardDAO();
	int count = rbdao.getAllCount(); //전체글에 대한 갯수저장 변수
	int startRow = 1;
	int endRow = count;		
	Vector<RBoardVO> vecReview = rbdao.selectBoard(startRow, endRow);
	
	// 예약 객체 생성 , 조회 
	BookingDAO ezbdao = new BookingDAO();	
	Vector<BookingVO> vecbook = ezbdao.selectBooking(1);
	
	// 공지글 객체 생성, 조회	
	NBoardDAO nbDao = new NBoardDAO();
	int	ncount = nbDao.getAllCount();
	int nstartRow = 1;
	int nendRow = ncount;		
	
	Vector<NBoardVO> vecNotice = nbDao.selectBoard(nstartRow, nendRow);
%>

<%

	// id 존재여부 확인

	String idcheck = ezudao.getid(logid);

	if(idcheck == null) {
%>
		<script type="text/javascript">
			alert("'<%=logid %>'는 회원이 아닙니다!!!");
			history.back(-1);     
	  	</script>
<% 
	}
	
	// 로그인 ID 관리자여부 체크 :  회원유형 '0'
	EZUserVO ezu2 = ezudao.oneselectUser(logid);

	if(!ezu2.getUtype().equals("0")){   //관리자는 회원유형이 '0'임 
%>
		<script type="text/javascript">         
			alert("이 화면은 관리자가 사용 가능합니다.!!!");
			history.back();//history.go(-1)
		</script>		
<%
	}

	// if 토탈 일반회원수 == 0 --> 회원현황 skip 추후 추가  총건수만 표시하고 최근회원현황 head글은 유지 고려

%>


<!----------------------------------->
   <div class = "adminlist">
		<br><br>
		<span style="font-size:30px;font-weight:bold;">  이젠스키 운영 상황  </span><br><br><br><br><br><br>

	<table border="1" width="70%">
		<tr>
<!----------------------------------------------------------------------------------------------->
			<td style="border:0;">
				<table  width="100%">			
					<h2 align= "center"> 최근 회원</h2><br>
				
					<tr height="25" align="center" center style=" background: #dcdcdc;">
						<td width="150" style="vertical-align:middle;">아이디</td>
						<td width="150" style="vertical-align:middle;">이  름</td>	
						<td width="150" style="vertical-align:middle;">성  별</td>
						<td width="150" style="vertical-align:middle;">가입일</td>
					</tr>	

	<%
	String utype = "?";
	String edate = "?";
	String username = "?";
	String userid = "?";
	
	int usernum = 0;
	
	for(int i=0; i < vecUser.size(); i++){
		
		EZUserVO ezuVO = vecUser.get(i);								
		
		switch(ezuVO.getUtype()) {				
		    case "1":   utype = "일반";
		    			break;
		    case "0":   utype = "관리자(직원)";
						break;
		    default:	utype = ezuVO.getUtype();
		       			break;
	    }
		
		if (utype == "관리자(직원)" )  continue;  

		edate = ezuVO.getEdate().substring(0,10);
	
		if (ezuVO.getId().length() > 5) {   // 5자 넘어가면 자르자
			userid = ezuVO.getId().substring(0,5);
		} else {
			userid = ezuVO.getId();
		}

%>
		<tr height="25px" align="center">	
			<td style="vertical-align:middle;"><%=userid %></td>
			<td style="vertical-align:middle;"><%=ezuVO.getName() %></td>
			<td style="vertical-align:middle;"><%=ezuVO.getSex() %></td>
			<td style="vertical-align:middle;"><%=edate %></td> 
		</tr>
<%
		usernum = usernum + 1;	
		if (usernum >= 10) break;				
	}
%>		
		<tr height="60px">
			<td align="center" colspan="4" style="vertical-align:middle; border:0;"><button class="listbtn_wr" type="button" onclick="location.href='Main.jsp?center=User/UserListT.jsp'">회원 목록</button>&nbsp;&nbsp;&nbsp;</td>
		</tr>
			
	</table>
			
		</td>
		<td width="200px" style="border:0;">
		</td>
<!----------------------------------------------------------------------------------------------->
		<td style="border:0;">
			<table width="100%">			
				<h2 align= "center"> 최근 예약 </h2><br>
			
				<tr height="25" align="center" center style=" background: #dcdcdc;">
					<td width="200" style="vertical-align:middle;">아이디</td>
					<td width="200" style="vertical-align:middle;">예약일</td>
					<td width="200" style="vertical-align:middle;">구  분</td>
				</tr>	
<%
				String ctype = "?";
				String bdate = "?";
				
				int booknum = 0;
				
				for(int i=0; i < vecbook.size(); i++){
					
					BookingVO bvo = vecbook.get(i);								
					
					switch(bvo.getBcheck()) {				
					    case "O":   ctype = "예약";
					    			break;
					    case "X":   ctype = "취소";
									break;
					    default:	utype = bvo.getBcheck();
					       			break;
				    }
					//bdate = bvo.getBdate().substring(0,10);
					//rdate = bvo.getRdate().substring(0,10);
					
					if (bvo.getBdate().length() > 10) {   // 10자 넘어가면 자르자
						bdate = bvo.getBdate().substring(0,10);
					} else {
						bdate = bvo.getBdate();
					}
		

%>
				<tr height="25px">
					<td align="center" style="vertical-align:middle;"><%=bvo.getId() %></td>
					<td align="center" style="vertical-align:middle;"><%=bdate %></td>
					<td align="center" style="vertical-align:middle;"><%=ctype %></td>					
				</tr>
<%
						booknum = booknum + 1;	
						if (booknum >= 10) break;				
				}
%>		
				<tr height="60px">
					<td align="center" colspan="4" style="vertical-align:middle; border:0;">
						<button class="listbtn_wr" type="button" onclick="location.href='Main.jsp?center=Booking/BookingAllListT.jsp'">예약 목록
						</button>&nbsp;&nbsp;&nbsp;
					</td>
				</tr>
			<tr height="200px"></tr>
		</table>
		</td>
		</tr>

		</table>
<!----------------------------------------------------------------------------------------------->
<table width="70%">
<tr>
			<td style="border:0;">
			<table width="100%">			
				<h2 align= "center"> 최근 후기글 </h2><br>
			
				<tr height="25" align="center" center style=" background: #dcdcdc;">
					<td width="200" style="vertical-align:middle;">제 목</td>
					<td width="200" style="vertical-align:middle;">글쓴이</td>	
					<td width="200" style="vertical-align:middle;">작성일자</td>
				</tr>	

<%
	String title = null;
	int reviewnum = 0;
	
	for(int i=0; i < vecReview.size(); i++){
		
		RBoardVO RBVO = vecReview.get(i);
		
		int num = rbdao.getAllReview(RBVO.getRef());
		
		if (RBVO.getTitle().length() > 5) {   // 5자 넘어가면 자르자
			title = RBVO.getTitle().substring(0,5);
		} else {
			title = RBVO.getTitle();
		}
	
%>
				<tr height="25px">
					<td align="center" style="vertical-align:middle;"><%=title %></td>
					<td align="center" style="vertical-align:middle;" ><%=RBVO.getWriter() %></td>
					<td align="center" style="vertical-align:middle;"><%=RBVO.getWdate() %></td>						
				</tr>
<%
		reviewnum = reviewnum + 1;	
		if (reviewnum >= 10) break;				
}
%>
					<tr height="60px">
					<td align="center" colspan="4" style="vertical-align:middle; border:0;"><button class="listbtn_wr" type="button" onclick="location.href='Main.jsp?center=Review/ReviewListT.jsp'">후기글 목록</button>&nbsp;&nbsp;&nbsp;</td>
				</tr>
			</table>
		</td>
		<td width="200px" style="border:0;">
		</td>
<!----------------------------------------------------------------------------------------------->
		<td style="border:0;">
			<table width="100%">			
				<h2 align= "center"> 최근 공지 </h2><br>
			
				<tr height="25" align="center" center style=" background: #dcdcdc;">			
					<td width="200" style="vertical-align:middle;">제  목</td>
					<td width="200" style="vertical-align:middle;">작성일</td>
					<td width="200" style="vertical-align:middle;">조회수</td>						
				</tr>	

<%
	String ntitle = null;
	int noticenum = 0;
	
	for(int i=0; i < vecNotice.size(); i++){
		
		NBoardVO nbVo = vecNotice.get(i);
		
		if (nbVo.getTitle().length() > 5) {   // 5자 넘어가면 자르자
			ntitle = nbVo.getTitle().substring(0,5);
		} else {
			ntitle = nbVo.getTitle();
		}

%>
				<tr height="25px">
					<td align="center" style="vertical-align:middle;"><%=ntitle %></td>
					<td align="center" style="vertical-align:middle;"><%=nbVo.getWdate() %></td>
					<td align="center" style="vertical-align:middle;"><%=nbVo.getViews() %></td>						
				</tr>
				
			
				
<%
		noticenum = noticenum + 1;	
		if (noticenum >= 10) break;				
}
%>										<tr height="60px">
					<td align="center" colspan="4" style="vertical-align:middle; border:0;"><button class="listbtn_wr" type="button" onclick="location.href='Main.jsp?center=Notice/NoticeListT.jsp'">공지 목록</button>&nbsp;&nbsp;&nbsp;	</td>
				</tr>	
			</table>

		</td>
<!----------------------------------------------------------------------------------------------->
	</tr>
<!----------------------------------------------------------------------------------------------->						
</table>
		<br><br><br><br><br>
		


							
		<br><br><br>
		<button class="listbtn_wr" type="button" onclick="location.href='Main.jsp'">홈</button>		
  </div>
  <% } %>
</body>
</html>