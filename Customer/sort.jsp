<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*" import="com.air.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
    // Retrieve flights from the session
    List<Flight> flights = (List<Flight>) session.getAttribute("flightList");
	System.out.println("sort.jsp");
    String sortCriteria = request.getParameter("sortCriteria");
    
        if ("price".equals(sortCriteria)) {
        	//System.out.println("price");
            Collections.sort(flights, Comparator.comparing(Flight::getPrice));
        } else if ("takeOffTime".equals(sortCriteria)) {
            Collections.sort(flights, Comparator.comparing(flight -> flight.getFromTime()));
        }else if("landingTime".equals(sortCriteria)){
        	Collections.sort(flights, Comparator.comparing(flight -> flight.getToTime()));
        }else if("airline".equals(sortCriteria)) {
        	Collections.sort(flights, Comparator.comparing(flight -> flight.getAirlineId()));
        }else if("numStops".equals(sortCriteria)){
        	Collections.sort(flights, Comparator.comparing(flight -> flight.getNumStops()));
        }else if("duration".equals(sortCriteria)){
        	Collections.sort(flights, Comparator.comparing(flight -> flight.duration()));
        }else if("airline".equals(sortCriteria)){
        	Collections.sort(flights, Comparator.comparing(flight -> flight.getAirlineId()));
        }
    
%>

<% for (Flight flight : flights) { %>
        <div class="flight-item">
            <div class="flight-info">
                <!-- Display flight details -->            
               <p>Flight Number: <%= flight.getFlightNum() %><br>
                Airline ID: <%= flight.getAirlineId() %><br>
                Aircraft ID: <%= flight.getAircraftId() %><br>
                Flight Type: <%= flight.getFlightType() %><br>
                Cabin Type: <%=  flight.getCabinClass() %><br>
                Depart Date: <%= flight.getFromDate() %><br>
                Route: <%= flight.getFromAirport() %> to <%= flight.getToAirport() %><br>
                Departure Time: <%= flight.getFromTime() %><br>
                Arrival Time: <%= flight.getToTime() %><br>
                Duration: <%= flight.duration() %><br>
                Number of Stops: <%= flight.getNumStops() %><br>
                Price: <%= flight.getPrice() %></p>
            </div>
            <!-- "Book Now" button with onclick event -->
            <button class="btn" onclick="handleBookNow('<%= flight.getFlightNum() %>')">Book Now</button>
        </div>
    <% } %>
</body>
</html>
<%--  <p>Flight Number: <%= flight.getFlightNum() %><br>
                Airline ID: <%= flight.getAirlineId() %><br>
                Aircraft ID: <%= flight.getAircraft().getAircraftId() %><br>
                Flight Type: <%= flight.getFlightType() %><br>
                Cabin Type: <%= flight.getCabinClass() %><br>
                Depart Date: <%= flight.getDepartDate() %><br>
                Route: <%= flight.getDepartureAirport() %> to <%= flight.getArrivalAirport() %><br>
                Departure Time: <%= flight.getAircraft().getDepartTime() %><br>
                Arrival Time: <%= flight.getAircraft().getArrivalTime() %><br>
                Price: <%= flight.getPrice() %></p> --%>