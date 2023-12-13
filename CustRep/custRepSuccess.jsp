<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>success</title>
</head>
<body>
	<%
	if ((session.getAttribute("user") == null)) {
	%>
	You are not logged in<br/>
	<a href="custRepLogin.jsp">Please Login</a>
	<%} 
	else {
	%>
		Welcome <%=session.getAttribute("user")%> <% //this will display the username that is stored in the session.%>
		<!-- <a href='logout.jsp' class="button">Log out</a> -->
		<a href='custRepLogout.jsp'><button>Logout</button></a>
		<a href='NULL'><button>Reservation Editing</button></a>
		<a href='supportQuestions/questionList.jsp'><button>Customer Support</button></a>
		<a href='Lists/ListSelect.jsp'><button>Flight Airport and Wait Lists</button></a>
        <a href='EditAirportAircraftFlight/custRepEditAll.jsp'><button>Edit Aircrafts, Airports and Flight Information</button></a>
	<%
	}
	%>
</body>
</html>
