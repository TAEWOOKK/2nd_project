<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="kr.co.ezen.*" %>
<%@ page import="java.util.*, java.text.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
    <script defer src="./youtube.js"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Alkatra:wght@500&family=Black+Ops+One&family=Dongle&family=Gugi&family=Josefin+Sans:wght@700&family=Poor+Story&family=Rubik+Mono+One&family=Sigmar+One&family=Stylish&family=Sunflower:wght@300&family=Yeseva+One&display=swap" rel="stylesheet">
</head>
<style>
	.centerimg {
 	  background-image: url("images/snowbgimg.gif");
	  background-repeat:no-repeat;
	  background-position:0% 10%;
	  background-size:cover;
	  height:1000px;
	  width:100%;
	  margin-top:-150px;
	  position: relative;
	  margin-bottom:-250px;
	}
	.weather {
		top:18%;
		width:80%;
		height:37%;
		margin:auto;
		position: relative; 
		z-index:2;
		background-color: rgba(0,0,0,0.5);
		color: white;
		font-weight:bolder;
		text-align: right;
		padding: 0 20% 0 0;
	}
	.day1,
	.day2,
	.day3,
	.day4,
	.day5 {
		width: 10%;
		display: inline-block;
	}
	#my-image1,
	#my-image2,
	#my-image3,
	#my-image4,
	#my-image5 {
		width: 40%;
		height: 40%;
	}
	#my-temp1,
	#my-temp2,
	#my-temp3,
	#my-temp4,
	#my-temp5 {
		font-size: large;
		text-align: right;
	}
	#my-date1,
	#my-date2,
	#my-date3,
	#my-date4,
	#my-date5 {
		text-align: auto;
	}
	.notice {
		background-color:white;
		position: absolute;
		width:30%;
		height:29%;
		top:30%;
		z-index:3;
		left:15%;
		box-shadow: 5px 5px 5px;
		word-break:break-all;
		text-align:left;
		border-radius:20px;
	}
	.material-symbols-outlined {
	  font-variation-settings:
	  'FILL' 0,
	  'wght' 400,
	  'GRAD' 0,
	  'opsz' 48
	}
	.reservation {
		background-color:white;
		position: absolute;
		width:30%;
		height:29%;
		top:30%;
		right:15%;
		z-index:3;
		box-shadow: 5px 5px 5px;
		word-break:break-all;
		text-align:left;
		border-radius:20px;
	}
</style>
<body>
<%
	NBoardDAO nbDAO = new NBoardDAO();

	NBoardVO nbVO = nbDAO.getNotice();
%>
<div id="cover">

<div class="centerimg">
		
	<div class="weather">
	
		<script type="text/javascript">
		const getJSON = function(url, callback) {
			  const xhr = new XMLHttpRequest();
			  xhr.open('GET', url, true);
			  xhr.responseType = 'json';
			  xhr.onload = function() {
			    const status = xhr.status;
			    if(status === 200) {
			      callback(null, xhr.response);
			    } else {
			      callback(status, xhr.response);
			    }
			  };
			  xhr.send();
			};
		
		getJSON('https://api.openweathermap.org/data/2.5/forecast?lat=37.517&lon=127.04&cnt=50&appid=64fd4b4f1ce02ba6d8292b616f13e439&units=metric', function(err, data) {
			  if(err !== null) {
			    alert('예상치 못한 오류 발생.' + err);
			  } else {
				  weather(data);
			  }
			});
			
			
		
		function weather(data){
			var strYoil = new Array('(일)','(월)','(화)','(수)','(목)','(금)','(토)');
			
			//day1
			var img1 = new Image();				
		    img1.src = "https://openweathermap.org/img/wn/"+data.list[0].weather[0].icon+"@2x.png";
		    img1.classList.add("weather-icon");
		    img1.id = "weather-icon-1";
		    //날씨아이콘
		    var imgUrl1 = img1.src;// img 요소 식별 후 src 속성에 변수 값 할당
			document.getElementById("my-image1").src = imgUrl1;
			//날짜&시간
		    var dt_txt1 = (data.list[0].dt_txt); // 예시 날짜 값
			var dateObj = new Date(dt_txt1);
			var mm = (dateObj.getMonth() + 1).toString().padStart(2, '0');
			var dd = dateObj.getDate().toString().padStart(2, '0');
			var formattedDate1 = mm + '/' + dd;
			document.getElementById('my-date1').innerHTML = formattedDate1;
			//온도
			var temp1 = (data.list[0].main.temp);
			document.getElementById('my-temp1').innerHTML = Math.round(temp1) + "°C"
			//요일
			var tyoil1 = new Date(dt_txt1).getDay();
			var yoil1 = strYoil[tyoil1];
			document.getElementById('yoil1').innerHTML = yoil1;
			
			
			
			//day2			    
		    var img2 = new Image();
		    img2.src = "https://openweathermap.org/img/wn/"+data.list[8].weather[0].icon+"@2x.png";
		    img2.classList.add("weather-icon");
		    img2.id = "weather-icon-2";
		    //날씨아이콘
		    var imgUrl2 = img2.src;
			document.getElementById("my-image2").src = imgUrl2;
			//날짜&시간
		    var dt_txt2 = (data.list[8].dt_txt); // 예시 날짜 값
			var dateObj = new Date(dt_txt2);
			var mm = (dateObj.getMonth() + 1).toString().padStart(2, '0');
			var dd = dateObj.getDate().toString().padStart(2, '0');
			var formattedDate2 = mm + '/' + dd;
			document.getElementById('my-date2').innerHTML = formattedDate2;
			//온도
			var temp2 = (data.list[8].main.temp);
			document.getElementById('my-temp2').innerHTML = Math.round(temp2) + "°C"; 
			//요일
			var tyoil2 = new Date(dt_txt2).getDay();
			var yoil2 = strYoil[tyoil2];
			document.getElementById('yoil2').innerHTML = yoil2;
			
			//day3
		    var img3 = new Image();
		    img3.src = "https://openweathermap.org/img/wn/"+data.list[16].weather[0].icon+"@2x.png";
		    img3.classList.add("weather-icon");
		    img3.id = "weather-icon-3";
		    //document.body.appendChild(img3);
		    var imgUrl3 = img3.src;// img 요소 식별 후 src 속성에 변수 값 할당
			document.getElementById("my-image3").src = imgUrl3;
			//날짜&시간
		    var dt_txt3 = (data.list[16].dt_txt); // 예시 날짜 값
			var dateObj = new Date(dt_txt3);
			var mm = (dateObj.getMonth() + 1).toString().padStart(2, '0');
			var dd = dateObj.getDate().toString().padStart(2, '0');
			var formattedDate3 = mm + '/' + dd;
			document.getElementById('my-date3').innerHTML = formattedDate3;
			//온도
			var temp3 = (data.list[16].main.temp);
			document.getElementById('my-temp3').innerHTML = Math.round(temp3) + "°C";
			//요일
			var tyoil3 = new Date(dt_txt3).getDay();
			var yoil3 = strYoil[tyoil3];
			document.getElementById('yoil3').innerHTML = yoil3;
			
			//day4
		    var img4 = new Image();
		    img4.src = "https://openweathermap.org/img/wn/"+data.list[24].weather[0].icon+"@2x.png";
		    img4.classList.add("weather-icon");
		    img4.id = "weather-icon-4";
		    //document.body.appendChild(img4);
		    var imgUrl4 = img4.src;// img 요소 식별 후 src 속성에 변수 값 할당
			document.getElementById("my-image4").src = imgUrl4;
			//날짜&시간
		    var dt_txt4 = (data.list[24].dt_txt); // 예시 날짜 값
			var dateObj = new Date(dt_txt4);
			var mm = (dateObj.getMonth() + 1).toString().padStart(2, '0');
			var dd = dateObj.getDate().toString().padStart(2, '0');
			var formattedDate4 = mm + '/' + dd;
			document.getElementById('my-date4').innerHTML = formattedDate4;
			//온도
			var temp4 = (data.list[34].main.temp);
			document.getElementById('my-temp4').innerHTML = Math.round(temp4) + "°C";
			//요일
			var tyoil4 = new Date(dt_txt4).getDay();
			var yoil4 = strYoil[tyoil4];
			document.getElementById('yoil4').innerHTML = yoil4;
			
			//day5
		    var img5 = new Image();
		    img5.src = "https://openweathermap.org/img/wn/"+data.list[32].weather[0].icon+"@2x.png";
		    img5.classList.add("weather-icon");
		    img5.id = "weather-icon-5";
		    //document.body.appendChild(img5);
		    var imgUrl5 = img5.src;// img 요소 식별 후 src 속성에 변수 값 할당
			document.getElementById("my-image5").src = imgUrl5;
			//날짜&시간
		    var dt_txt5 = (data.list[32].dt_txt); // 예시 날짜 값
			var dateObj = new Date(dt_txt5);
			var mm = (dateObj.getMonth() + 1).toString().padStart(2, '0');
			var dd = dateObj.getDate().toString().padStart(2, '0');
			var formattedDate5 = mm + '/' + dd;
			document.getElementById('my-date5').innerHTML = formattedDate5;
			//온도
			var temp5 = (data.list[32].main.temp);
			document.getElementById('my-temp5').innerHTML = Math.round(temp5) + "°C";
			//요일
			var tyoil5 = new Date(dt_txt5).getDay();
			var yoil5 = strYoil[tyoil5];
			document.getElementById('yoil5').innerHTML = yoil5;
		}
		</script>
		
		<span style="align-items: left; padding: 0 5% 10% 0; font-size:280%; font-weight:bold; font-family: 'Alkatra', cursive; color: Aliceblue">
			Weather's
		</span>
		
		<div class="day1">
			<div style="display: flex; justify-content:center; align-items: center;">
			<img id="my-image1" src="">
			<span id="my-temp1"></span></div>
			<div style="padding-right:25px;">
			<span id="my-date1"></span>
			<span id="yoil1"></span>
			</div>			
		</div>


		<div class="day2">
			<div style="display: flex; justify-content:center; align-items: center;">
			<img id="my-image2" src="">
			<span id="my-temp2"></span></div>
			<div style="padding-right:25px;">
			<span id="my-date2"></span>
			<span id="yoil2"></span>
			</div>	
		</div>
		
		
		<div class="day3">
			<div style="display: flex; justify-content:center; align-items: center;">
			<img id="my-image3" src="">
			<span id="my-temp3"></span></div>
			<div style="padding-right:25px;">
			<span id="my-date3"></span>
			<span id="yoil3"></span>
			</div>	
		</div>
		
		
		<div class="day4">
			<div style="display: flex; justify-content:center; align-items: center;">
			<img id="my-image4" src="">
			<span id="my-temp4"></span></div>
			<div style="padding-right:25px;">
			<span id="my-date4"></span>
			<span id="yoil4"></span>
			</div>	
		</div>
		
		
		<div class="day5">
			<div style="display: flex; justify-content:center; align-items: center;">
			<img id="my-image5" src="">
			<span id="my-temp5"></span></div>
			<div style="padding-right:25px;">
			<span id="my-date5"></span>
			<span id="yoil5"></span>
			</div>	
		</div>

	
	</div>
	
	<div class="notice"> 
		<br>
		<div>
			<span style="padding-left:2%;text-align:left;"><font color="royalblue" size="4px"><b>공지사항</b></font></span>
			<span class="material-symbols-outlined" style="padding-left:4%;"><a href="Main.jsp?center=Notice/NoticeListT.jsp">add_circle</a></span>
		</div>
		<br><br>
		<% if(nbVO.getTitle()==null) { %>
				<div style="text-align:center;">
				<span><font color="black" size="6px"><br><b>공지사항 없음</b></font></span>
				</div>
		<% } else {%>
		<div style="text-align:center;">
		
			<a href="Main.jsp?center=/Notice/NoticeDetailT.jsp?numb=<%=nbVO.getNumb() %>"><span><font color="black" size="6px">
			<br><b><%=nbVO.getTitle() %></b></font></span></a>
		</div>	
		<br><br><br><br><br><br>
		<div style="bottom:5%;">
			<span style="padding-left:10%; text-align:left;"><font color="#a0a0a0" size="4px"><%=nbVO.getWdate() %></font></span>
		</div>	
		<br>
		<% } %>
	</div>
		
	      <%
			Calendar cal = Calendar.getInstance();
			int year = cal.get(Calendar.YEAR);
			int month = cal.get(Calendar.MONTH)+1;
		%>	
	<div class="reservation">
		<br>
		<div>
			<span style="padding-left:2%;text-align:left;"><font color="royalblue" size="4px"><b>예약현황</b></font></span>
			<span class="material-symbols-outlined" style="padding-left:4%;"><a href="Main.jsp?center=Booking/BookingStatusT.jsp?year=<%=year %>&month=<%=month %>">add_circle</a></span><br>
		</div>
		
		<div style="text-align:center;">
			<jsp:include page="Booking/BookingChart.jsp"></jsp:include>
		</div>
	</div>
</div>
</div>
</body>
</html>