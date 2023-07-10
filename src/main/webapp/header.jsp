<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="kr.co.ezen.EZUserDAO" %>
<%@ page import="java.util.*, java.text.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Header</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Black+Ops+One&family=Dongle&family=Gugi&family=Josefin+Sans&family=Poor+Story&family=Rubik+Mono+One&family=Sigmar+One&family=Stylish&family=Sunflower:wght@300&family=Yeseva+One&display=swap" rel="stylesheet">

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Black+Ops+One&family=Dongle&family=Gugi&family=Poor+Story&family=Rubik+Mono+One&family=Sigmar+One&family=Stylish&family=Sunflower:wght@300&family=Yeseva+One&display=swap" rel="stylesheet">
<style>
	.header_menu{
	font-family:'Sunflower', sans-serif;
  	font-size:150%;
  }
  .logo{
 	font-family: 'Josefin Sans', sans-serif;
 	font-size:40px;
  }

</style>
</head>
<body>
<div class="header">
      <br><div class="header_top" style = "padding:10px 50px 0px 0px;">
    <%
    	String id = (String)session.getAttribute("id");
  		String utype = (String)session.getAttribute("utype");
   	 	EZUserDAO ezdao = new EZUserDAO();
   	 	String name = null;
    	if(id==null){
    	
    %>
      <a href="Main.jsp?center=User/UserLoginF.jsp"><span>Login</span></a>&nbsp;&nbsp;  
      |  &nbsp;&nbsp;  
      <a href="Main.jsp?center=User/UserSignUpF.jsp"><span>SignUp</span></a> 
     <%
    	} else if(utype.equals("0")){
    		name = ezdao.getName(id);
     %>
   	      <a href="Main.jsp?center=User/UserLogoutT.jsp"><span>Logout</span></a>&nbsp;&nbsp;  
      |  &nbsp;&nbsp;  
   	      <a href="Main.jsp?center=User/AdminPageT.jsp"><span>AdminPage</span></a>
     <%
    	} else {
    		name = ezdao.getName(id);
     %>
     	  <a href="Main.jsp?center=User/UserLogoutT.jsp"><span>Logout</span></a>&nbsp;&nbsp;  
      |  &nbsp;&nbsp;  
   	      <a href="Main.jsp?center=User/MyPage.jsp"><span>MyPage</span></a>
   	  <%
    	}
    	//
    	if(session.getAttribute("id")!=null){
   	  %>
   	  &nbsp;&nbsp;&nbsp;&nbsp;<div style="padding:10px; color:white; font-size:75%; background-color:#da5ada; border-radius:50%; font-weight:bolder; display:inline;"><%=name %></div>
   	  <%} %>
    </div>
     <a href="Main.jsp">
     <span class="logo">
      <font size="7px" style="opacity:0.3; font-weight:bolder"><b>&nbsp;&nbsp;&nbsp;E&nbsp;Z&nbsp;S&nbsp;K&nbsp;I</b></font>
   	  </span>
    </a>
	
     <div class="header_menu" style = "padding:70px 0px 0px 0px;">
      <span><a href="Main.jsp?center=Introduce.jsp">소개</a></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <span><a href="Main.jsp?center=InformationUse.jsp">이용안내</a></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <%
			Calendar cal = Calendar.getInstance();
			int year = cal.get(Calendar.YEAR);
			int month = cal.get(Calendar.MONTH)+1;
		%>
      <span><a href='Main.jsp?center=Booking/BookingStatusT.jsp?year=<%=year %>&month=<%=month %>'>예약현황</a></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <span><a href="Main.jsp?center=Location.jsp">오시는길</a></span>
    </div>
    
  </div>
</body>
</html>