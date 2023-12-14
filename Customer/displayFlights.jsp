<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import= "com.air.*" import="java.util.*"%>    
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Flight List View</title>
  <style>
    /* Style the list item */
    .flight-item {
      border: 1px solid #ddd;
      padding: 10px;
      margin: 5px;
      box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
      border-radius: 8px;
      background-color: #fff;
    }

    .flight-info {
      flex-grow: 1;
    }

    /* Style the button */
    .btn {
      background-color: #4CAF50;
      color: white;
      border: none;
      padding: 8px;
      text-align: center;
      text-decoration: none;
      display: inline-block;
      font-size: 14px;
      cursor: pointer;
      border-radius: 4px;
    }
  </style>
</head>
<body>
<%
	if ((session.getAttribute("user") == null)) {
	%>
	You are not logged in<br/>
	<a href="custLogin.jsp">Please Login</a>
	<%}
	else {%>
		Welcome <%= session.getAttribute("user")%>
		<a href='custLogout.jsp'><button>Logout</button></a>
		<a href='flightSearch.jsp'><button>Back</button></a>
	<%}%>

<pre>
<% 
		String fromAirport = request.getParameter("selectedDepartAirport");
		String toAirport = request.getParameter("selectedArrivalAirport");
		String depDate = request.getParameter("departDate");
		String retDate = request.getParameter("returnDate");
		String cabinClass = request.getParameter("cabinClass");
		String flightType = request.getParameter("flightType");
		String sortCriteria = request.getParameter("sortCriteria");
		String filterButton = request.getParameter("filterButton");
		String searchButton = request.getParameter("searchButton");
		
		List<Flight> flights = null;
		
		if ("Search Flights".equals(searchButton)) {
			
			
			out.println("<p>Departure: " + fromAirport);
			out.println("Arrival: " + toAirport);
			out.println("Departure date:" + depDate);
			out.println("Arrival date: " + retDate);
			out.println("Cabin class: "  + cabinClass);
			out.println("FlightType: " + flightType + "</p>");
			out.println();
			flights = new GenerateFlights().getFlights(fromAirport, toAirport, flightType, cabinClass, depDate, retDate);
			session.setAttribute("flightList", flights);
			
		}else if("Filter Flights".equals(filterButton)){
			String maxPrice = request.getParameter("maxPrice");
	        String maxStops = request.getParameter("maxStops");
	        String airline = request.getParameter("airline");
	        String takeOffTime = request.getParameter("takeOffTime");
	        String landingTime = request.getParameter("landingTime");
	        out.println();
	        flights = new GenerateFlights().filterFlights(maxPrice, maxStops, airline, takeOffTime, landingTime,
	        		fromAirport, toAirport, flightType, cabinClass, depDate, retDate);
	        session.setAttribute("flightList", flights);
		}
		//List<Flight> sortedFlights = (List<Flight>) session.getAttribute("sortedFlightList");
		/* session.setAttribute("sortedFlightList", flights);
		List<Flight> sortedFlights = (List<Flight>) session.getAttribute("sortedFlightList");
		if(sortedFlights != null){
			flights = sortedFlights;
		} */
		//out.println(fls.displayFlights(fromAirport, toAirport, flightType, cabinClass, depDate, retDate));		
		%>
</pre>
<%if(flights != null && !flights.isEmpty()){ %>
	<form id="sortForm" action="sort.jsp" method="get">
        <label for="sortCriteria">Sort by:</label>
        <select id="sortCriteria" name="sortCriteria" onchange="applySortFilter()">
        	<option value="" disabled selected>Select</option>
            <option value="price">Price</option>
            <option value="takeOffTime">Take-off Time</option>
            <option value="landingTime">Landing Time</option>
            <option value="duration">Duration of Flight</option>
            <option value="numStops">Num of Stops</option>
            <option value="airline"> Airline</option>
        </select>
    </form>
 
<!-- List view dynamically generated from flights data -->
	<div id="flightList">
	 
	    <% for (Flight flight : flights) { %>
	        <div class="flight-item">
	            <div class="flight-info">
	                <!-- Display flight details -->
	             
	                <p>Flight Number: <%= flight.getFlightNum() %><br>
	                Airline ID: <%= flight.getAirlineId() %><br>
	                Aircraft ID: <%= flight.getAircraftId() %><br>
	                Flight Type: <%= flight.getFlightType() %><br>
	                <% if(flight.getCabinClass() != null){%>
	                Cabin Type: <%=  flight.getCabinClass() %><br>
	                <%}%>
	                Depart Date: <%= flight.getFromDate() %><br>
	                Route: <%= flight.getFromAirport() %> to <%= flight.getToAirport() %><br>
	                Departure Time: <%= flight.getFromTime() %><br>
	                Arrival Time: <%= flight.getToTime() %><br>
	                Duration: <%= flight.duration() %><br>
	                Number of Stops: <%= flight.getNumStops() %><br>
	               	<% if(flight.getCabinClass() != null){%>
	                Price: $<%= flight.getPrice() %>
	                <%}else{%>
	                 Economy Price: $<%= flight.getEcoPrice()%><br>
	                 Business Price: $<%= flight.getBusPrice()%><br>
	                 First Class Price: $<%= flight.getFirPrice()%>
	                <%}%>
	                </p>
	            </div>
	            <!-- "Book Now" button with onclick event -->
	            <button class="btn" onclick="handleBookNow('<%= flight.getFlightNum() %>')">Book Now</button>
	        </div>
	    <% } %>
	  <%} else { out.println("<p> No Flights Founds!!" + "<br>" + "Check dates closer to today's date</p>");} %>
	</div>
<script>
	function applySortFilter() {
	   
		var sortCriteria = document.getElementById("sortCriteria").value;

        var xhr = new XMLHttpRequest();
        xhr.open("GET", "sort.jsp?sortCriteria=" + sortCriteria, true);

        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4 && xhr.status === 200) {
                // Update the flightList div with the received sorted list content
                document.getElementById("flightList").innerHTML = xhr.responseText;
            }
        };

        xhr.send();
	}
	function handleBookNow(flightNumber) {
		
        var confirmBooking = confirm('Are you sure you want to book Flight ' + flightNumber + '?');
        if (confirmBooking) {
            // Redirect to customerInfo.jsp
           
            /* window.location.href = 'customerInfo.jsp'; */
            window.location.href = 'customerInfo.jsp?flightNumber='+ flightNumber;
        } else {
            // Show alert for action cancellation
            alert('Action Cancelled');
           
        }
    }
</script>

</body>
</html>
