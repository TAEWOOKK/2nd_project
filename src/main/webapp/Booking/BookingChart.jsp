<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.util.Date, java.text.SimpleDateFormat" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.sql.*" %>
<%@ page import="kr.co.ezen.BookingDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<title>Insert title here</title>
</head>
<body>
<style>

 .chart-container {
  margin-top:10%;
  width: 85%;
  height: 40%;
  margin: 0 auto;
}  

#line-chart {
  
  width: 60%;
  height: 40%;
}
</style>

	
  <div class="chart-container"> 
	  <canvas id="line-chart"></canvas>
 </div> 

<%

LocalDate dayone = LocalDate.now();
String dayoneString = dayone.toString();
int month1 = dayone.getMonthValue();
int day1 = dayone.getDayOfMonth();
String oneday = month1 + "/" + day1;

LocalDate daytwo = dayone.plusDays(1);
String daytwoString = daytwo.toString();
int month2 = daytwo.getMonthValue();
int day2 = daytwo.getDayOfMonth();
String twoday = month2 + "/" + day2;

LocalDate daythree = dayone.plusDays(2);
String daythreeString = daythree.toString();
int month3 = daythree.getMonthValue();
int day3 = daythree.getDayOfMonth();
String threeday = month3 + "/" + day3;

LocalDate dayfour = dayone.plusDays(3);
String dayfourString = dayfour.toString();
int month4 = dayfour.getMonthValue();
int day4 = dayfour.getDayOfMonth();
String fourday = month4 + "/" + day4;

LocalDate dayfive = dayone.plusDays(4);
String dayfiveString = dayfive.toString();
int month5 = dayfive.getMonthValue();
int day5 = dayfive.getDayOfMonth();
String fiveday = month5 + "/" + day5;

LocalDate daysix = dayone.plusDays(5);
String daysixString = daysix.toString();
int month6 = daysix.getMonthValue();
int day6 = daysix.getDayOfMonth();
String sixday = month6 + "/" + day6;

%>

<jsp:useBean id="bvo" class="kr.co.ezen.BookingVO">
	<jsp:setProperty property="*" name="bvo" />
</jsp:useBean>

	<%
	BookingDAO bdao = new BookingDAO();
	int x1 = bdao.selectCountBooking(dayoneString);
	int x2 = bdao.selectCountBooking(daytwoString);
	int x3 = bdao.selectCountBooking(daythreeString);
	int x4 = bdao.selectCountBooking(dayfourString);
	int x5 = bdao.selectCountBooking(dayfiveString);
	int x6 = bdao.selectCountBooking(daysixString);
	%>

<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js"></script>
<script type="text/javascript">
const data = {
		labels: ["<%=oneday%>", "<%=twoday%>", "<%=threeday%>", "<%=fourday%>", "<%=fiveday%>"],
		datasets: [{
		    label: "예약 인원수",
		    data: [<%=x1%>, <%=x2%>, <%=x3%>, <%=x4%>, <%=x5%>, <%=x6%>],
			backgroundColor: "rgba(255, 99, 132, 0.2)",
			borderColor: "rgba(255, 99, 132, 1)",
			borderWidth: 2,
			pointBackgroundColor: "rgba(255, 99, 132, 1)",
			pointRadius: 3,
			pointHoverRadius: 5,
	    }]
	};

	const config = {
		type: "line",
		data: data,
		options: {
			scales: {
				y: {
				  min: 0,
				  max: 10,
				  stepSize: 1 
				},
				yAxes:[{
					ticks:{
						display:false
				 	}
				}]
			},
		},
	};

const chart = new Chart(document.getElementById("line-chart"), config);
</script>


</body>
</html>