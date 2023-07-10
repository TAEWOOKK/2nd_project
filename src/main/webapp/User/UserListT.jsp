<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
<%@ page import = "kr.co.ezen.EZUserDAO" %>     
<%@ page import = "kr.co.ezen.EZUserVO" %>
<%@ page import = "java.util.Vector" %>  

<!DOCTYPE html>
<html>
<head>
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
		background-color: black;
		color: white;
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
<style>
	.scrolltable {
	  display: block;
	  overflow: auto;
	}
	table {
	  width: 100%; height:400px;
	  border-spacing: 0;
	}
	th {
	
	  background: #ace;
	}
	td {
	  border: 1px solid #000;
	}
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
		String sid = (String)session.getAttribute("id"); 
		
		if(sid == null){
%>
			<script type = "text/javascript">
			alert('먼저 로그인을 해주세요.');
			location.href='Main.jsp?center=User/UserLoginF.jsp';
			</script>
<%		} %>
<%

	EZUserDAO ezudao = new EZUserDAO();	

	Vector<EZUserVO> vec = ezudao.selectUser();
	
	
%>


<!--------------------------------- -->
<span style="font-size:25px; font-weight:bolder;"> 회원 목록 </span>
	<hr style="width:70%; background-color:black; height:2px;"/>
	
<div style="width:70%; text-align:center; overflow:auto; height:700px;">
	

		<table  cellpadding="10px" class="bt">  <!-- border="1"  -->
		<tr align="center" style="background: #f6f5f0; height:40px;">
			<td width="100" style="vertical-align:middle;">번호</td>
			<td width="100" style="vertical-align:middle;">아이디</td>
			<td width="100" style="vertical-align:middle;">이름</td>
			<td width="100" style="vertical-align:middle;">성별</td>
			<td width="100" style="vertical-align:middle;">전화번호</td>
			<td width="100" style="vertical-align:middle;">지  역</td>
			<td width="100" style="vertical-align:middle;">이메일</td>
			<td width="100" style="vertical-align:middle;">유  형</td>
			<td width="100" style="vertical-align:middle;">가입일시</td>
			<td width="80" style="vertical-align:middle;">수  정</td>
			<td width="80" style="vertical-align:middle;">삭  제</td>
		</tr>
	

		
	<%
		String utype = null;
		for(int i=0; i < vec.size(); i++){
			
			EZUserVO ezuVO = vec.get(i);
								
			
			switch(ezuVO.getUtype()) {
			
			    case "1":   utype = "일반";
			    			break;
			    case "0":   utype = "관리자";
							break;							
			    default:	utype = ezuVO.getUtype();
			       			break;
		    }

	%>
	
	
    
	<tr align="center" style="height:40px;">	
			<td width="100" style="vertical-align:middle;"><%=i+1 %></td>
			<td width="100" style="vertical-align:middle;"><%=ezuVO.getId()%></td>
			<td width="100" style="vertical-align:middle;"><%=ezuVO.getName() %></td>
			<td width="100" style="vertical-align:middle;"><%=ezuVO.getSex() %></td>
			<td width="100" style="vertical-align:middle;"><%=ezuVO.getTel() %></td>
			<td width="100" style="vertical-align:middle;"><%=ezuVO.getCity() %></td>
			<td width="100" style="vertical-align:middle;"><%=ezuVO.getEmail() %></td>
			<td width="100" style="vertical-align:middle;"><%=utype %></td>
			<td width="100" style="vertical-align:middle;"><%=ezuVO.getEdate() %></td>
			<td width="50" style="vertical-align:middle;">
	<%	
	
		if (!ezuVO.getId().contains("test")){  // 
	%>
	  				<a href="Main.jsp?center=User/UserUpdateMgrF.jsp?id=<%=ezuVO.getId() %>"><button class="listbtn_wr">변경</button></a>
	<%
		} else {						      // 예외처리 test용 id : errTT
		
	%>
		  			<a href="Main.jsp?center=User/UserUpdateMgrTestF.jsp?id=<%=ezuVO.getId() %>"><button class="listbtn_wr">변경-</button></a>
		
	<%	
		}
	%>	
		

			</td>	
			<td width="50" style="vertical-align:middle;">
  				<a href="Main.jsp?center=User/UserDeleteMgrF.jsp?id=<%=ezuVO.getId() %>"><button class="listbtn_wr">삭제</button></a>
			</td>
	</tr>
	
	<%
		}
	%>	
	
  </table>
  
  
 </div>
			<br><br><br><br>
			<button style="width:150px;" class="listbtn_wr" type="button" onclick="location.href='Main.jsp?center=User/AdminPageT.jsp'">Admin Page</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	
			<button style="width:150px;" class="listbtn_wr" type="button" onclick="location.href='Main.jsp'">Home</button>&nbsp;&nbsp;		
					
</body>
</html>