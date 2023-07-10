<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%@ page isErrorPage="true" %>
<%
//200 => 브라우져 처리 코드
response.setStatus(200);

String logid = (String)session.getAttribute("id"); 
String utype = (String)session.getAttribute("utype");

Boolean daosql = false;

if (exception.getClass().getName().contains("SQLException"))
	daosql = true;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예외처리 화면</title>
</head>
<style>
	body {
		margin-top: 12%;
	}
	.error {
		text-align: center;
		background-color: white;
		width: 45%;
		padding: 5%;
		border: 3px solid grey;
		align: center;
		box-shadow: 0px 5px 15px 0px rgba(0, 0, 0, 0.35);
	}
	.errorbtn {
		width: 100px;
		height: 40px;
		background-color: white;
		border: 2px solid grey;
		border-radius: 8%;
	}
	.errorbtn:hover {
		background-color: grey;
	}
	table {
		border-collapse: collapse;
		border-color: white;
	}
	hr {
		background-color: #fff;
		border-top: 2px dotted #bbb;
		width: 90%;
	}
</style>
<body>
<div align="center">
	<div class="error">
		<span><img src="https://cdn3.vectorstock.com/i/1000x1000/08/52/alert-on-computer-line-icon-computer-error-vector-23780852.jpg" style="width:60px; height:60px;">
		</span>&emsp;&emsp;
		<span style="font-size:50px; margin:0;"><b>Error</b></span>
		<br><br>

<%		if (!daosql) {	
%>			<h4>입력하신 데이터 처리 중 이상이 발생하였습니다.</h4>
			<h4>입력 내용이 이상 없을 경우 고객센터(TEL.02-255-8297)로 문의해주시기 바랍니다.</h4><br>
<%		
		} else {
%>			<h4>데이터 처리 중 오류가 발생하였습니다.</h4>
			<h4>빠른 시간내 복구할 예정이오니 잠시 기다려 주시기 바랍니다.</h4><br>
<%		}
%>		
		<hr>
		<br>
		
	<div align="center">	
		<table>
			<tr text-align="left" height="40px">
				<td style="font-weight:bold; color: red;">원&nbsp;&nbsp;인&nbsp;&nbsp;</td>
				<td><%=exception.getMessage() %></td>
			</tr>
			<tr text-align="left" height="40px">
				<td style="font-weight:bold; color: red;">유&nbsp;&nbsp;형&nbsp;&nbsp;</td>
				<td><%=exception.getClass().getName() %></td>
			</tr>
		</table>	
	</div>
	<br><br>
<%
		if(utype.equals("0")) {
%>	`		<button class="errorbtn" onclick="location.href='../Main.jsp'">Home</button>&emsp;&emsp;&emsp;
			<button class="errorbtn" onclick="location.href='../Main.jsp?center=User/AdminPageT.jsp'">Admin Page</button>&emsp;&emsp;&emsp;
			<input type="button" class="errorbtn" onClick="history.go(-1)" value="Back" /><br><br>
<%
		} else {
%>			<button class="errorbtn" onclick="location.href='../Main.jsp'">Home</button>&emsp;&emsp;&emsp;
			<input type="button" class="errorbtn" onClick="history.go(-1)" value="Back" /><br><br>
<%		}
%>
			
	</div>
</div>
</body>
</html>