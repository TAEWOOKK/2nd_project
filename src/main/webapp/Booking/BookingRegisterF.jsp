<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="kr.co.ezen.EZUserDAO"%>
<%@ page import="kr.co.ezen.EZUserVO"%>
<%@ page import="kr.co.ezen.BookingDAO"%>
<%@ page import="kr.co.ezen.BookingVO"%>
<%@ page import="java.util.*"%>
<%request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>예약하기 폼</title>
    <%
	String id = (String)session.getAttribute("id");
%>
    <script type="text/javascript">
        if ( <%=id%> == null) {
            alert("로그인 후 이용해주세요.");
            location.href = "Main.jsp";
        }
    </script>
    <style>
        body {
            width: 100%;

        }

        .BookingRegister {
            height: 800px;
        }

        .Calendar {
            display: grid;
            place-items: center;
            position: absolute;
            left: 22.5%;
            text-align: center;
            padding: 2em 1em 1em 1em;
            width: 27%;
        }

        .userInfo {
            display: grid;
            place-items: center;
            position: absolute;
            right: 22.5%;
            text-align: center;
            padding: 3em 2em 2.5em 2em;
            width: 27%;
            height: 465px;
        }

        tbody td {
            width: 60px;
            height: 60px;
            vertical-align: middle;
        }

        .Calendar>thead>tr:first-child>td {
            font-weight: bold;
        }

        .Calendar>thead>tr:last-child>td {
            background-color: gray;
            color: white;
        }

        .pastDay {
            background-color: lightgray;
        }

        .today {
            background-color: #FFCA64;
            cursor: pointer;
        }

        .futureDay {
            background-color: #ffffff;
            cursor: pointer;
        }

        .futureDay.choiceDay,
        .today.choiceDay {
            background-color: #3E85EF;
            color: #fff;
            cursor: pointer;
        }

        .button {
            font-weight: bold;
        	background-color: white;
        	width: 40%;
        	height: 65%;
        }
        .button:hover {
        	background-color: #323232;
        	color: white;
        }

        table {
            border-collapse: collapse;
            align: center;
            vertical-align: middle;
        }

        td {
            vertical-align: middle;
            text-align: center;
        }

        /*팝업 박스*/
        .popup_layer {
            position: fixed;
            top: 0;
            left: 0;
            z-index: 10000;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.4);
        }

        /*컨텐츠 영역*/
        .popup_box {
            position: relative;
            top: 50%;
            left: 10%;
            overflow: auto;
            height: 600px;
            width: 400px;
            transform: translate(-50%, -50%);
            z-index: 1002;
            box-sizing: border-box;
            background: #fff;
            box-shadow: 2px 5px 10px 0px rgba(0, 0, 0, 0.35);
            -webkit-box-shadow: 2px 5px 10px 0px rgba(0, 0, 0, 0.35);
            -moz-box-shadow: 2px 5px 10px 0px rgba(0, 0, 0, 0.35);
        }

        /*버튼영역*/
        .popup_box .popup_cont {
            padding: 40px;
            line-height: 1.4rem;
            font-size: 14px;
            bottom: 0;
            vertical-align: middle;
            margin-top: 11%;
        }

        .popup_box .popup_cont h2 {
            color: #333;
            margin: 0;
            font-size: 18px;
            font-weight: bold;
            padding-bottom: 25px;
        }

        .popup_box .popup_cont h1 {
            line-height: 1.4rem;
            font-size: 14px;
            bottom: 0;
        }

        .popup_box .popup_cont p {
            border-top: 1px solid #666;
            padding-top: 17px;
            padding-bottom: 17px;
        }

        /*오버레이 뒷배경*/
        .popup_box .popup_btn {
            display: table;
            table-layout: fixed;
            width: 100%;
            height: 70px;
            word-break: break-word;
        }

        .popup_box .popup_btn a {
            position: relative;
            display: table-cell;
            height: 70px;
            font-size: 17px;
            text-align: center;
            vertical-align: middle;
            text-decoration: none;
            background: #ECECEC;
        }

        .popup_box .popup_btn a:before {
            content: '';
            display: block;
            position: absolute;
            top: 26px;
            right: 29px;
            width: 1px;
            height: 21px;
            background: #fff;
            -moz-transform: rotate(-45deg);
            -webkit-transform: rotate(-45deg);
            -ms-transform: rotate(-45deg);
            -o-transform: rotate(-45deg);
            transform: rotate(-45deg);
        }

        .popup_box .popup_btn a:after {
            content: '';
            display: block;
            position: absolute;
            top: 26px;
            right: 29px;
            width: 1px;
            height: 21px;
            background: #fff;
            -moz-transform: rotate(45deg);
            -webkit-transform: rotate(45deg);
            -ms-transform: rotate(45deg);
            -o-transform: rotate(45deg);
            transform: rotate(45deg);
        }

        .popup_box .popup_btn a.close_day {
            background: #5d5d5d;
        }

        .popup_box .popup_btn a.close_day:before,
        .popup_box .popup_btn a.close_day:after {
            display: none;
        }

        /*popup*/
        .popup_overlay {
            position: fixed;
            top: 0px;
            right: 0;
            left: 0;
            bottom: 0;
            z-index: 1001;
            background: rgba(0, 0, 0, 0.5);
        }
       .calInfo {
       	background: #ECE9E6;  /* fallback for old browsers */
		background: -webkit-linear-gradient(to left, #FFFFFF, #ECE9E6);  /* Chrome 10-25, Safari 5.1-6 */
 		background: linear-gradient(to left, #FFFFFF, #ECE9E6); /* W3C, IE 10+/ Edge, Firefox 16+, Chrome 26+, Opera 12+, Safari 7+ */
		}
		
		.btntd {
			vertical-align: top;
		}
    </style>

    <script>
        window.onload = function() {
            buildCalendar();
        } // 웹 페이지가 로드되면 buildCalendar 실행

        let nowMonth = new Date(); // 현재 달을 페이지를 로드한 날의 달로 초기화
        let today = new Date(); // 페이지를 로드한 날짜를 저장
        today.setHours(0, 0, 0, 0); // 비교 편의를 위해 today의 시간을 초기화

        var usercheck = null; //중복확인을 위한 날짜 변수 선언

        // 달력 생성 : 해당 달에 맞춰 테이블을 만들고, 날짜를 채워 넣는다.
        function buildCalendar() {

            let firstDate = new Date(nowMonth.getFullYear(), nowMonth.getMonth(), 1); // 이번달 1일
            let lastDate = new Date(nowMonth.getFullYear(), nowMonth.getMonth() + 1, 0); // 이번달 마지막날

            let tbody_Calendar = document.querySelector(".Calendar > tbody");
            document.getElementById("calYear").innerText = nowMonth.getFullYear(); // 연도 숫자 갱신
            document.getElementById("calMonth").innerText = leftPad(nowMonth.getMonth() + 1); // 월 숫자 갱신

            while (tbody_Calendar.rows.length > 0) { // 이전 출력결과가 남아있는 경우 초기화
                tbody_Calendar.deleteRow(tbody_Calendar.rows.length - 1);
            }

            let nowRow = tbody_Calendar.insertRow(); // 첫번째 행 추가           

            for (let j = 0; j < firstDate.getDay(); j++) { // 이번달 1일의 요일만큼
                let nowColumn = nowRow.insertCell(); // 열 추가
            }

            for (let nowDay = firstDate; nowDay <= lastDate; nowDay.setDate(nowDay.getDate() + 1)) { // day는 날짜를 저장하는 변수, 이번달 마지막날까지 증가시키며 반복  

                let nowColumn = nowRow.insertCell(); // 새 열을 추가하고
                nowColumn.innerText = leftPad(nowDay.getDate()); // 추가한 열에 날짜 입력

                if (nowDay.getDay() == 0) { // 일요일인 경우 글자색 빨강으로
                    nowColumn.style.color = "#DC143C";
                }
                if (nowDay.getDay() == 6) { // 토요일인 경우 글자색 파랑으로 하고
                    nowColumn.style.color = "#0000CD";
                    nowRow = tbody_Calendar.insertRow(); // 새로운 행 추가
                }

                if (nowDay < today) { // 지난날인 경우
                    nowColumn.className = "pastDay";
                } else if (nowDay.getFullYear() == today.getFullYear() && nowDay.getMonth() == today.getMonth() && nowDay.getDate() == today.getDate()) { // 오늘인 경우           
                    nowColumn.className = "today";
                    nowColumn.onclick = function() {
                        choiceDate(this);
                        location.href = "Booking/BookingCheck.jsp?date=" + usercheck
                    }
                } else { // 미래인 경우
                    nowColumn.className = "futureDay";
                    nowColumn.onclick = function() {
                        choiceDate(this);
                        location.href = "Booking/BookingCheck.jsp?date=" + usercheck
                    }
                }
            }
        }

        // 날짜 선택
        function choiceDate(cell) {
            // 이전에 선택한 셀의 "choiceDay" 클래스 제거
            var prevChoice = document.querySelector(".choiceDay");
            var calendaryear = document.getElementById("calYear");
            var calendarmonth = document.getElementById("calMonth");
            var calenderyeargogo = calendaryear.textContent.trim();
            var calendermonthgogo = calendarmonth.textContent.trim();

            if (prevChoice) {
                prevChoice.classList.remove("choiceDay");
            }

            // 클릭한 셀에 "choiceDay" 클래스 추가
            cell.classList.add("choiceDay");

            // 클릭한 셀의 날짜 정보 가져오기
            var selectedDate = cell.textContent.trim();
            var selectedDateInfo = document.getElementById("selectedDateInfo");
            var selectedDateInput = document.getElementById("selectedDate");

            selectedDateInfo.innerHTML = calenderyeargogo + "-" + calendermonthgogo + "-" + selectedDate;
            selectedDateInput.value = selectedDateInfo.innerHTML;

            var selectedDateInf = document.getElementById("selectedDateInf");
            selectedDateInf.innerHTML = calenderyeargogo + "-" + calendermonthgogo + "-" + selectedDate;

            usercheck = calenderyeargogo + "-" + calendermonthgogo + "-" + selectedDate;

        }

        // 이전달 버튼 클릭
        function prevCalendar() {
            nowMonth = new Date(nowMonth.getFullYear(), nowMonth.getMonth() - 1, nowMonth.getDate()); // 현재 달을 1 감소
            buildCalendar(); // 달력 다시 생성
        }

        // 다음달 버튼 클릭
        function nextCalendar() {
            nowMonth = new Date(nowMonth.getFullYear(), nowMonth.getMonth() + 1, nowMonth.getDate()); // 현재 달을 1 증가
            buildCalendar(); // 달력 다시 생성
        }

        // input값이 한자리 숫자인 경우 앞에 '0' 붙혀주는 함수
        function leftPad(value) {
            if (value < 10) {
                value = "0" + value;
                return value;
            }
            return value;
        }
    </script>
</head>

<body>

    <div class="BookingRegister">

        <div align="center">
            <font size="20px"><b>예약하기</b></font>
        </div><br>
        <div align="center" style="padding-bottom:80px;">
            <font size="3px" color="#969696">'이젠스키' 지금 바로 예약하세요.</font>
        </div>

	<div style="border:1px solid black; width:60%; height:530px; border-radius:20px; vertical-align: middle;" class="calInfo">
        <table class="Calendar">
            <thead>
                <tr>
                    <td onClick="prevCalendar();" style="cursor:pointer; width:60px; height:60px;">&#60;</td>
                    <td colspan="5">
                        <font size="4px"><span id="calYear"></span>년
                            <span id="calMonth"></span>월</font>
                    </td>
                    <td onClick="nextCalendar();" style="cursor:pointer; width:60px; height:60px;">&#62;</td>
                </tr>
                <tr>
                    <td style="width:60px; height:60px;">일</td>
                    <td style="width:60px; height:60px;">월</td>
                    <td style="width:60px; height:60px;">화</td>
                    <td style="width:60px; height:60px;">수</td>
                    <td style="width:60px; height:60px;">목</td>
                    <td style="width:60px; height:60px;">금</td>
                    <td style="width:60px; height:60px;">토</td>
                </tr>
            </thead>
            <tbody>
            </tbody>
        </table>

        <form action="Main.jsp?center=Booking/BookingRegisterP.jsp" method="post">
    <%
	EZUserDAO edao= new EZUserDAO();
	
	EZUserVO evo = edao.oneselectskiuser(id);
	%>
            <table class="userInfo">
                <tr>
                    <td colspan="2">
                    	<font size="4px" style="font-weight:bold;">예약 정보<br><br></font>
                    	<hr style="background-color: black; height:2px;"><br>
                    </td>
                </tr>
                <tr>
                    <td style="width:130px; height:60px; background-color:#f6f5f0; font-weight:bold;">아이디</td>
                    <td style="width:280px; height:60px;"><%=evo.getId() %></td>
                </tr>
                <tr>
                    <td style="width:130px; height:60px; background-color:#f6f5f0; font-weight:bold;">이름</td>
                    <td style="width:280px; height:60px;"><%=evo.getName() %></td>
                </tr>
                <tr>
                    <td style="width:130px; height:60px; background-color:#f6f5f0; font-weight:bold;">이메일</td>
                    <td style="width:280px; height:60px;"><%=evo.getEmail() %></td>
                </tr>
                <tr>
                    <td style="width:130px; height:60px; background-color:#f6f5f0; font-weight:bold;">예약날짜</td>
                    <td style="width:280px; height:60px;"><span id="selectedDateInfo">날짜를 입력해주세요.</span></td>
                </tr>
                <tr>
                	<td colspan="2">
                		<hr style="background-color: black; height:2px;">
                	</td>
                </tr>
                <tr>
                    <td colspan="2"  class="btntd">
                        <input type="button" class="button" value="예약하기" onclick="openPop()">
                    </td>
                </tr>
            </table>
	</div>
            <div class="popup_layer" id="popup_layer" style="display: none;">
                <div class="popup_box" id="popup_box">
                    <div style="height: 10px; width: 375px; float: top; padding-top:5px;">
                        <a href="javascript:closePop();"><img src="images/xbutton.png" class="m_header-banner-close" width="20px" height="20px" align="left"></a>
                    </div>
                    <!--팝업 컨텐츠 영역-->
                    <div class="popup_cont" id="popup_cont">
                    
                    <table>
                		<tr>
                    		<td colspan="2">
                    			<font size="4px" style="font-weight:bold;">예약 정보 확인<br><br></font>
                    			<!-- <hr style="background-color: black; height:2px;"> -->
                    		</td>
               			</tr>
                		<tr>
		                    <td style="width:100px; height:70px; background-color:#f6f5f0; font-weight:bold;">아이디</td>
		                    <td style="width:250px; height:70px;"><%=evo.getId() %></td>
		                </tr>
		                <tr>
		                    <td style="width:100px; height:70px; background-color:#f6f5f0; font-weight:bold;">이름</td>
		                    <td style="width:250px; height:70px;"><%=evo.getName() %></td>
		                </tr>
		                <tr>
		                    <td style="width:100px; height:70px; background-color:#f6f5f0; font-weight:bold;">이메일</td>
		                    <td style="width:250px; height:70px;"><%=evo.getEmail() %></td>
		                </tr>
		                <tr>
		                    <td style="width:100px; height:70px; background-color:#f6f5f0; font-weight:bold;">예약날짜</td>
		                    <td style="width:250px; height:70px;"><h1 id="selectedDateInf"></h1></td>
		                </tr>
		                <tr>
		                    <td colspan="2" style="padding-top:15px;">
		                        <div class="popup_btn" style="float: bottom;">
		                        <input type="hidden" id="selectedDate" name="bdate">
		                        <input type="hidden" name="id" value="<%=evo.getId() %>">
		                        <input type="submit" value="확인" class="button">
		                        </div>
		                    </td>
		                </tr>
		            </table>
                   <input type="hidden" id="rid" value="<%=id%>">
                    </div>
                </div>
            </div>
        </form>
    </div>
    <script type="text/javascript"> 
        function openPop() {
        		 if (usercheck == null) {
                     alert('날짜를 선택해주세요');
                 }
        		 else {
                     document.getElementById("popup_layer").style.display = "block";
                 }
        }
        //팝업 닫기
        function closePop() {
            location.href = 'Main.jsp?center=/Booking/BookingRegisterF.jsp';
        }
    </script>
</body>
</html>