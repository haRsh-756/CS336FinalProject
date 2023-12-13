<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import = "com.air.*" import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
if ((session.getAttribute("user") == null)) {
%>
	You are not logged in<br/>
	<a href="../Login/landing.jsp">Please Login</a>
<%}
else {%>
		Welcome <%= session.getAttribute("user")%>
		<a href='custLogout.jsp'><button>Logout</button></a>
		<a href='flightSearch.jsp'><button>Back</button></a>
<pre>
	<%
    // Retrieve flight details from the session
    List<Flight> flights = (List<Flight>) session.getAttribute("flightList");
	/* int flightNum = Integer.parseInt((String)session.getAttribute("flightNumber")); */
	/* String flightNum = (String)session.getAttribute("flightNumber");
	System.out.println(flightNum); */
	String flightNumber = request.getParameter("flightNumber");
	System.out.println(flightNumber);
	session.setAttribute("flightNum",flightNumber);
    // Display flight details
    if (flights != null && !flights.isEmpty()) {
        out.println("<h2>Flight Details</h2>");
        for (Flight flight : flights) {
        	 if(flight.getFlightNum() == Integer.parseInt(flightNumber)){ 
	            out.println("<p>Flight Number: " + flight.getFlightNum() + "<br>");
	            out.println("Airline ID: " + flight.getAirlineId() + "<br>");
	            out.println("Aircraft ID:" + flight.getAircraftId() + "<br>");
	            out.println("Flight Type:" + flight.getFlightType() + "<br>");
	            out.println("Cabin Type: " + flight.getCabinClass() + "<br>");
	            out.println("Depart Date: " + flight.getFromDate() + "<br>");
	            out.println("Route: " + flight.getFromAirport() + " to " + flight.getToAirport() + "<br>");
	            out.println("Departure Time:" + flight.getFromTime() + "<br>");
	            out.println("Arrival Time:" + flight.getToTime() + "<br>");
	            out.println("Duration: " + flight.duration() + "<br>");
	            out.println("Number of Stops: " + flight.getNumStops() + "<br>");
	            out.println("Price: " + flight.getPrice() + "</p>");
	            break;
        	}
        }
    } else {
        out.println("<p>No flight details available.</p>");
    }
%>
	</pre>
		<form action="confirmation.jsp" method="post">
	    <label for="firstName">First Name:</label>
	    <input type="text" id="firstName" name="firstName" required><br>
	
	    <label for="lastName">Last Name:</label>
	    <input type="text" id="lastName" name="lastName" required><br>
	
	    <!-- Add more input fields for other customer information as needed -->
	
	    <input type="submit" value="Confirm">
	</form>
</body>
</html>
<%}%>
