<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
/**
 @author harsh_patel, saad_farghani, hieu_nguyen
*/
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Success Page</title>
</head>
<body>
	<%
	if ((session.getAttribute("user") == null)) {
	%>
	You are not logged in<br/>
	<a href="custLogin.jsp">Please Login</a>
	<%} 
	else {
	%>
		Welcome <%=session.getAttribute("user")%> <% //this will display the username that is stored in the session.%>
		<!-- <a href='logout.jsp' class="button">Log out</a> -->
		<a href='custLogout.jsp'><button>Logout</button></a>
		<a href='flightSearch.jsp'><button>Flight Search</button></a>
		<a href='TicketHistory/reservationDisplay.jsp'><button>Reservations</button></a>
		<a href='Support/qnaSearch.jsp'><button>Support</button></a>
	<%
	}
	%>
</body>
</html>
