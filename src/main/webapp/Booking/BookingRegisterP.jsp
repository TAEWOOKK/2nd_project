<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="kr.co.ezen.EZUserDAO"%>
<%@ page import="kr.co.ezen.EZUserVO"%>
<%@ page import="kr.co.ezen.BookingDAO"%>
<%@ page import="kr.co.ezen.BookingVO"%>
<%@ page import="java.util.*"%>
<%request.setCharacterEncoding("UTF-8");%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
            <title>예약 완료</title>
        </head>
        <style>
            .BookingRegisterP {
                height: 700px;
                align: center;
            }
            .registerpro {
                text-align: center;
                background-color: white;
                width: 600px;
                padding: 100px;
                border: 5px solid grey;
                align: center;
            }
            h1 {
                font-weight: bold;
            }
            .button {
                font-weight: bold;
                background-color: white;
                width: 25%;
                height: 70px;
            }
            .button:hover {
                background-color: #323232;
                color: white;
            }
            h2 {
            	font-weight: bold;
            }
            #countdown {
				color: #FF8C8C;
            }
        </style>
        <body>
            <%
    String id = (String)session.getAttribute("id");
	String bdate = request.getParameter("bdate");
	
	if(id==null){
		%>
		<script type="text/javascript">
		alert("로그인 후 이용해주세요");
		location.href='Main.jsp?center=User/UserLoginF.jsp';
		</script>
		<% 
		
	}
	else{
		
	
	%>
            <jsp:useBean id="bvo" class="kr.co.ezen.BookingVO">
                <jsp:setProperty property="*" name="bvo"/>
            </jsp:useBean>
            <%
	//DB연결을 위한 객체 생성
	BookingDAO bdao = new BookingDAO();
	
	bdao.insertBooking(id, bdate);
	 
	%>
       <script type="text/javascript">
           function countDown() {
               var count = 10; // 카운트 다운 시작 값
               var timer = setInterval(function () {
                   count--;
                   if (count === 0) { // 카운트 다운이 끝나면 다음 페이지로 이동
                       clearInterval(timer); // 타이머 정지
                       window.location.href = "Main.jsp"; // 다음 페이지로 이동
                   } else {
                       document.getElementById("countdown").innerHTML = count; // 카운트 다운 값을 HTML 요소에 삽입
                   }
               }, 1000); // 1초마다 실행
           }
           // 페이지 로드 완료 시 countDown() 함수 실행
           window.onload = function () {
               countDown();
           };
       </script>
       <div class="BookingRegisterP">
           <div class="registerpro">
               <div align="center">
                   <img alt="예약완료 이미지" src="images/check.png" width="100px" height="100px">
                       <br><br>
               </div>
               <font style="font-size:25px; font-weight:bold;">예약이 완료되었습니다.</font>
               <br><br><br>
               <span align="center">----------------------------------<img src="images/alert.PNG" width="10" height="10" alt="alert" style="display:inline;">----------------------------------</span>
               <br><br><br>
               <h2><span id="countdown">10</span>초 뒤 홈으로 이동합니다.</h2><br><br>
               <h2>예약확인을 누르시면 마이페이지로 이동합니다.</h2><br><br><br>
               <button class="button" onclick="location.href='Main.jsp?center=User/MyPage.jsp'">예약 확인</button>
               <br>
			</div>
		</div>
		<%
	}
		%>
</body>
</html>