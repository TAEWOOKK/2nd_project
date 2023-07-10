<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="kr.co.ezen.EZUserDAO"%>
<%@ page import="kr.co.ezen.EZUserVO"%>
<%@ page import="kr.co.ezen.BookingDAO"%>
<%@ page import="kr.co.ezen.BookingVO"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.*, java.text.*, java.time.YearMonth, kr.co.ezen.BookingDAO" %>
<%request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="jquery-3.6.4.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js@3.7.0/dist/chart.min.js"></script>
<%
int year = Integer.parseInt(request.getParameter("year"));
int month = Integer.parseInt(request.getParameter("month"));
%>
<style>
	body{
		width:100%;
	}
	.Calendar {
		display: grid;
		place-items: center;
		position:absolute;
		left: 24.5%;		
		text-align: center;
		/* border:1; 
		border-collapse:collapse; 
		border-width: 3px;
		border-style: solid; 
		border-color: grey; */ 
		padding: 1em 1em 1em 1em;
		width:25%;
		
	}
	.userInfo {
		display: grid;
		place-items: center;
		position:absolute;
		right: 24.5%;
		text-align: center;
		/* border:1; 
		border-collapse:collapse; 
		border-width: 3px;
		border-style: solid; 
		border-color: grey; */ 
		padding: 1em 1em 1em 1em;
		width:25%;
		height:480px;
	}
	tbody td {
		width: 60px;
		height: 60px;
	}
	/*위에 년도 글씨 진하게 만드는거  */
	.Calendar>thead>tr:first-child>td { 
		font-weight: bold; 
	}

	.Calendar>thead>tr:last-child>td {
		background-color: gray;
		color: white;
	}        

	.pastDay{ 
		background-color: lightgray; 
	}

	.today{            
		background-color: #FFCA64;            
		cursor: pointer;
	}

	.futureDay{            
		background-color: #FFFFFF;
		cursor: pointer;
	}

	.futureDay.choiceDay, .today.choiceDay{            
		background-color: #3E85EF;            
		color: #fff;
		cursor: pointer;
	}
	.button {
		border: none;
		font:12px;
		font-weight:bold;
		color:#ff0080;
		width:100%;
		height:70px;
	}
	table {
		border-collapse: collapse;
		text-align: center;
	}
	td {
		vertical-align: middle;
		
	}
	.BookingStatusT{
		height: 900px;
	}
	.gauge {
	  width: 90%;
	  height: 20px;
	  border: 1px solid #ccc;
	  position: relative;
	  border-radius: 10px;
	  margin: auto;
	}

	.gauge-fill {
	  border-radius: 10px;
	  position: absolute;
	  top: 0;
	  left: 0;
	  bottom: 0;
	  background-color: red;
	  width: calc(var(--value) / 20 * 100%);/*맥스 설정 코드  */
	  transition: width 0.5s ease-in-out;
	}

	.gauge-fill.blue {
	  background-color: blue;
	}
	.gauge-fill.green {
	  background-color: green;
	}
	.gauge-fill.yellow {
	  background-color: yellow;
	}
	.gauge-fill.red {
	  background-color: red;
	}
	.gauge-fill.skyblue {
	  background-color: skyblue;
	}
	.bookingChart {
		width: 70%;
	}
	
	.hr-sect {
		display: flex;
        flex-basis: 100%;
        justift-align: center;
        align-items: center;
        color: black;
        font-size: 20px;
        font-weight: bold;
        margin: 8px 0px;
	}
	.hr-sect::before,
	.hr-sect::after {
		content: "";
        flex-grow: 1;
        background: #dcdcdc;
        height: 3px;
        font-size: 1px;
        line-height: 0px;
        margin: 0px 16px;
	}
	#myChart {
  width: 100%;
  height: auto;
	}
.calInfo {
background: #ECE9E6;  /* fallback for old browsers */
background: -webkit-linear-gradient(to right, #FFFFFF, #ECE9E6);  /* Chrome 10-25, Safari 5.1-6 */
background: linear-gradient(to right, #FFFFFF, #ECE9E6); /* W3C, IE 10+/ Edge, Firefox 16+, Chrome 26+, Opera 12+, Safari 7+ */



}
#load {
    width: 100%;
    height: 100%;
    top: 0;
    left: 0;
    position: fixed;
    display: block;
/*     opacity: 0.8; */
    background: white;
    z-index: 99;
    text-align: center;
}

#load > img {
    position: absolute;
    top: 50%;
    left: 50%;
    z-index: 100;
}
.fade-out {
  opacity: 0.5;
  transition: opacity 0.5s ease-out;
}
</style>

<script>	
	window.onload = function () { buildCalendar(); }    // 웹 페이지가 로드되면 buildCalendar 실행
	 
	let nowMonth = new Date();  // 현재 달을 페이지를 로드한 날의 달로 초기화
	let today = new Date();     // 페이지를 로드한 날짜를 저장
	today.setHours(0,0,0,0);    // 비교 편의를 위해 today의 시간을 초기화

	// 달력 생성 : 해당 달에 맞춰 테이블을 만들고, 날짜를 채워 넣는다.
	function buildCalendar() {
		const loadElement = document.getElementById("load");
		loadElement.classList.add("fade-out");
		setTimeout(() => {
		  loadElement.style.display = "none";
		}, 500);
		let firstDate = new Date(nowMonth.getFullYear(), nowMonth.getMonth(), 1);     // 이번달 1일
		let lastDate = new Date(nowMonth.getFullYear(), nowMonth.getMonth() + 1, 0);  // 이번달 마지막날

		let tbody_Calendar = document.querySelector(".Calendar > tbody");
		document.getElementById("calYear").innerText = nowMonth.getFullYear();             // 연도 숫자 갱신
		document.getElementById("calMonth").innerText = leftPad(nowMonth.getMonth() + 1);  // 월 숫자 갱신

		while (tbody_Calendar.rows.length > 0) {                        // 이전 출력결과가 남아있는 경우 초기화
			tbody_Calendar.deleteRow(tbody_Calendar.rows.length - 1);
		}

		let nowRow = tbody_Calendar.insertRow();        // 첫번째 행 추가           

		for (let j = 0; j < firstDate.getDay(); j++) {  // 이번달 1일의 요일만큼
			let nowColumn = nowRow.insertCell();        // 열 추가
		}

		for (let nowDay = firstDate; nowDay <= lastDate; nowDay.setDate(nowDay.getDate() + 1)) {   // day는 날짜를 저장하는 변수, 이번달 마지막날까지 증가시키며 반복  

			let nowColumn = nowRow.insertCell();        // 새 열을 추가하고
			nowColumn.innerText = leftPad(nowDay.getDate());      // 추가한 열에 날짜 입력
                
            
			if (nowDay.getDay() == 0) {                 // 일요일인 경우 글자색 빨강으로
				nowColumn.style.color = "#DC143C";
			}
			if (nowDay.getDay() == 6) {                 // 토요일인 경우 글자색 파랑으로 하고
				nowColumn.style.color = "#0000CD";
				nowRow = tbody_Calendar.insertRow();    // 새로운 행 추가
			}

			if (nowDay < today) {                       // 지난날인 경우
				nowColumn.className = "pastDay";
			} else if (nowDay.getFullYear() == today.getFullYear() && nowDay.getMonth() == today.getMonth() && nowDay.getDate() == today.getDate()) { // 오늘인 경우           
				nowColumn.className = "today";
				nowColumn.onclick = function () { choiceDate(this); }
			} else {                                      // 미래인 경우
				nowColumn.className = "futureDay";
				nowColumn.onclick = function () { choiceDate(this); }
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
        	  
		// 선택한 날짜의 정보 전달
		window.location.href = "Main.jsp?center=Booking/BookingStatusT.jsp?selectedDate=" + selectedDate + 
				"&calenderyeargogo=" + calenderyeargogo + "&calendermonthgogo=" + calendermonthgogo
				+ "&year=" + <%=year%> + "&month=" + <%=month%> +"#section1";
	
	}
        
	// 이전달 버튼 클릭
	function prevCalendar() {
		nowMonth = new Date(nowMonth.getFullYear(), nowMonth.getMonth() - 1, nowMonth.getDate());   // 현재 달을 1 감소
		buildCalendar();    // 달력 다시 생성
	}
        
	// 다음달 버튼 클릭
	function nextCalendar() {
		nowMonth = new Date(nowMonth.getFullYear(), nowMonth.getMonth() + 1, nowMonth.getDate());   // 현재 달을 1 증가
		buildCalendar();    // 달력 다시 생성
	}

	// input값이 한자리 숫자인 경우 앞에 '0' 붙혀주는 함수
	function leftPad(value) {
		if (value < 10) {
			value = "0" + value;
			return value;
		}
		return value;
	}
	function monthchoice(){
		
		  var year = document.getElementById("calYear").innerHTML; // 년도 값 가져오기
		    var month = document.getElementById("calMonth").innerHTML; // 월 값 가져오기
		    
		 location.href = "Main.jsp?center=Booking/BookingStatusC.jsp?year=" + year + "&month=" + month;
	}
	
</script>
</head>
<body>
<div id="load">
    <img src="images/Iphone-spinner-2.gif" alt="loading">
</div>
<section id="section1">
<div class = "BookingStatusT">
	<div align="center"><font size="20px"><b>예약 현황</b></font></div><br><br><br>
			<div align="center"><font size="3px" color="#969696">
				눈치게임은 이제 그만!<br><br>
				일정을 선택하여 확인하고 예약하세요!</font><br>
				<img style="  padding: 0px 0px 0px 700px;" src="./images/스키안내.png" height="150" width="300 alt="스키안내"></div>	
				<hr style="width:70%; color:#dcdcdc;"/>

	<div align="center" style="padding-top:3%; width:53%;">
		<div class="hr-sect" style="width:100%;">일별 예약 현황</div><br><br>
	</div>	
	<br><br>
	
	<div style="border:1px solid black; width:55%; height:500px; border-radius:20px;" class="calInfo">
	<table class="Calendar">
       <thead>
			<tr>
				<td onClick="prevCalendar();" style="cursor:pointer; width:60px; height:60px;">&#60;</td>
				<td colspan="5" onclick="monthchoice()">
					<font size="4px"><span id="calYear" style="cursor: pointer;"></span>년
					<span id="calMonth" style="cursor: pointer;"></span>월</font>
				</td>
				<td onClick="nextCalendar();" style="cursor:pointer; width:60px; height:60px;">&#62;</td>
					<!-- <p id="demo"></p> -->
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
	<%
	String selectedDate = request.getParameter("selectedDate");
	String years = request.getParameter("calenderyeargogo");
	String months = request.getParameter("calendermonthgogo");
	String date = (years+"-"+months+"-"+selectedDate);
	if(selectedDate==null) {
		date = "날짜를 입력해주세요";
	}
	BookingDAO edao= new BookingDAO();
	
	int x = edao.selectCountBooking(date);
	
	String a = "날짜를 입력해주세요";
	if(x>13){
		a ="<font color=red>혼 잡</font>";
	}
	else if(x<=13 && x>=8){
		a ="<font color=orange>보 통</font>";
	}
	else if(x<8 && x>=0 && years!=null){
		a ="<font color=green>원 활</font>";
	}
	else if(x<8 && x>=0 && years==null){
		a = "";
	}
	%>
	<table class="userInfo">
		<tr>
			<td colspan="2">
             	<font size="4px" style="font-weight:bold;">예약 현황<br><br></font>
                <hr style="background-color: black; height:2px;">
			</td>
		</tr>
		<tr>
			<td style="width:100px; height:60px;">&nbsp;<b>선택날짜</b></td>
		    <td style="width:250px; height:60px;" readonly="readonly">&nbsp;<%=date %></td>
		</tr>
		<tr>
			<td>예약인원</td>
			<td>
			<%if(years==null){ %>
			 명
			 <%
			}
			else{
			 %>
			<%=x%> 명
			<%
			}
			%>
			</td>
		</tr>
		<tr>
			<td>혼잡도</td>
			<td style=" font-weight:bolder;"><%=a%> </td>
		</tr>
		<tr>
			<td colspan="2">
			<div class="gauge">
	  		<div class="gauge-fill"></div></div></td>
		</tr>
	</table>
	</div>
</div>
<section id="section2">
</section>
<br><br><br><br><br><br><br><br><br><br>
</section>
<script type="text/javascript">
const gaugeFill = document.querySelector('.gauge-fill');

function setGaugeValue(value) {
	  gaugeFill.style.setProperty('--value', value);
	  if (value >= 14) {
	    gaugeFill.classList.add('red');
	    gaugeFill.classList.remove('yellow', 'green',);
	  } else if (value >= 8) {
	    gaugeFill.classList.add('yellow');
	    gaugeFill.classList.remove('red', 'green',);
	  } else {
	    gaugeFill.classList.add('green');
	    gaugeFill.classList.remove('red', 'yellow');
	  } 
	}
// Example usage:
setGaugeValue(<%=x%>);
</script>
<div align="center" style="width:53%;">

	<div>
		<div class="hr-sect" style="width:100%;">월별 예약 현황</div><br><br>
	</div>

<%
	
    // 이전 달과 다음 달의 년, 월을 계산합니다.
    Calendar cal = Calendar.getInstance();
    cal.set(year, month - 1, 1);
    cal.add(Calendar.MONTH, -1);
    int prevYear = cal.get(Calendar.YEAR);
    int prevMonth = cal.get(Calendar.MONTH) + 1;
    cal.add(Calendar.MONTH, 2);
    int nextYear = cal.get(Calendar.YEAR);
    int nextMonth = cal.get(Calendar.MONTH) + 1;

    // BookingDAO 클래스의 getBookingCountByDate 메소드를 호출하여
    // 현재 월의 예약 현황을 가져옵니다.
    BookingDAO dao = new BookingDAO();
    Map<Integer, Integer> bookingCountByDate = dao.getBookingCountByDate(year, month);

    // 예약 현황을 차트로 그립니다.
    // 차트는 Chart.js 라이브러리를 사용합니다.
    // 차트를 그리기 위해 데이터 배열과 레이블 배열을 생성합니다.
   int daysInMonth = YearMonth.of(year, month).lengthOfMonth();
	int[] data = new int[daysInMonth];
	String[] labels = new String[daysInMonth];
	for (int i = 0; i < daysInMonth; i++) {
	    int count = bookingCountByDate.getOrDefault(i + 1, 0);
	    data[i] = count;
	    labels[i] = Integer.toString(i + 1);
	}
%>
<a href="Main.jsp?center=Booking/BookingStatusT.jsp?year=<%=prevYear%>&month=<%=prevMonth%>&#section2" style="font-weight: bold;">&lt;&emsp;&emsp;</a>
<span style="font-size:20px; font-weight:bolder;"><%=year%>년 <%=month %>월	</span>
<a href="Main.jsp?center=Booking/BookingStatusT.jsp?year=<%=nextYear%>&month=<%=nextMonth%>&#section2" style="font-weight: bold;"><b>&emsp;&emsp;&gt;</b></a>
<br><br><br>
<!-- 예약 현황 차트 -->
<canvas id="myChart"></canvas>
<script>
var ctx = document.getElementById('myChart');
var chart = new Chart(ctx, {
  type: 'bar',
  data: {
    labels: <%=Arrays.toString(labels)%>,
    datasets: [{
      label: '예약자 수',
      data: <%=Arrays.toString(data)%>,
      backgroundColor: 'rgba(54, 162, 235, 0.2)',
      borderColor: 'rgba(54, 162, 235, 1)',
      borderWidth: 1
    }]
  },
  options: {
	    scales: {
	      yAxes: [{
	        afterDataLimits: function(axis) {
	          axis.max = 10;
	          axis.min = 0;
	          axis.stepSize = 1;
	        },
	        ticks: {
	          display: true
	        },
	        gridLines: {
	          display: false
	        }
	      }],
	      xAxes: [{
	        ticks: {
	          display: true
	        },
	        gridLines: {
	          display: false
	        }
	      }]
	    },
	    title: {
	      display: true,
	      text: '<%=year%> year <%=month%> month reservation status'
	    }
	  }
	});

	// Chart.js에서 사용하는 backgroundColor 값을 변경합니다.
	chart.data.datasets[0].backgroundColor = 'rgba(255, 99, 132, 0.2)';
	chart.update();
</script>
</div>
</body>
</html>