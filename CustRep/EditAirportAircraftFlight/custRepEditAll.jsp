<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*, com.air.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Aircrafts, Airports, Flights</title>
    <style>
        /* Basic styling for tabs and tab content */
        .tab { overflow: hidden; border: 1px solid #ccc; background-color: #f1f1f1; }
        .tab button { background-color: inherit; float: left; border: none; outline: none; cursor: pointer; padding: 14px 16px; transition: 0.3s; }
        .tab button:hover { background-color: #ddd; }
        .tab button.active { background-color: #ccc; }
        .tabcontent { display: none; padding: 6px 12px; border: 1px solid #ccc; border-top: none; }
    </style>
</head>
<body>

<div class="tab">
    <button class="tablinks" onclick="openTab(event, 'Aircrafts')">Aircrafts</button>
    <button class="tablinks" onclick="openTab(event, 'Airports')">Airports</button>
    <button class="tablinks" onclick="openTab(event, 'Flights')">Flights</button>
</div>

<div id="Aircrafts" class="tabcontent">
    <h3>Aircrafts</h3>

    <!-- Form for adding a new aircraft -->
    <form action="AircraftServlet" method="post">
        <input type="hidden" name="action" value="add">
        Aircraft ID: <input type="text" name="aircraft_id"><br>
        Number of Seats: <input type="number" name="num_seats"><br>
        <input type="submit" value="Add Aircraft">
    </form>

    <%-- Existing aircrafts list --%>
    <%
        List<Aircraft> aircraftList = AircraftDAO.getAllAircrafts(); // Replace with your actual method
        for (Aircraft aircraft : aircraftList) {
    %>
        <div>
            Aircraft ID: <%= aircraft.getAircraftId() %><br>
            Number of Seats: <%= aircraft.getNumSeats() %><br>
            <!-- Edit and Delete links -->
            <a href="editAircraft.jsp?aircraft_id=<%= aircraft.getAircraftId() %>">Edit</a> |
            <a href="AircraftServlet?action=delete&aircraft_id=<%= aircraft.getAircraftId() %>">Delete</a>
        </div>
    <%
        }
    %>
</div>



<div id="Airports" class="tabcontent">
    <h3>Airports</h3>

    <!-- Form for adding a new airport -->
    <form action="EditAirportServlet" method="post">
        <input type="hidden" name="action" value="add">
        Airport ID: <input type="text" name="airport_id"><br>
        <input type="submit" value="Add Airport">
    </form>

    <%-- Existing airports list --%>
    <%
        List<Airport> airportList = AirportDAO.getAllAirports(); // Replace with your actual method
        for (Airport airport : airportList) {
    %>
        <div>
            Airport ID: <%= airport.getAirportId() %><br>
            <a href="editAirport.jsp?airport_id=<%= airport.getAirportId() %>">Edit</a> |
            <a href="EditAirportServlet?action=delete&airport_id=<%= airport.getAirportId() %>">Delete</a>
        </div>
    <%
        }
    %>
</div>


<div id="Flights" class="tabcontent">
    <h3>Flights</h3>

    <!-- Form for adding a new flight -->
    <form action="EditFlightServlet" method="post">
        <input type="hidden" name="action" value="add">
        Airline ID: <input type="text" name="airline_id"><br>
        Aircraft ID: <input type="text" name="aircraft_id"><br>
        From Airport: <input type="text" name="from_airport"><br>
        From Date: <input type="date" name="from_date"><br>
        From Time: <input type="time" name="from_time"><br>
        To Airport: <input type="text" name="to_airport"><br>
        To Date: <input type="date" name="to_date"><br>
        To Time: <input type="time" name="to_time"><br>
        Number of Seats: <input type="number" name="num_seats"><br>
        Is Domestic: <input type="checkbox" name="is_domestic"><br>
        Flight Number: <input type="number" name="flight_num"><br>
        Flight Type: <input type="text" name="flight_type"><br>
        Number of Stops: <input type="number" name="num_stops"><br>
        Economy Price: <input type="text" name="eco_price"><br>
        Business Price: <input type="text" name="bus_price"><br>
        First Class Price: <input type="text" name="fir_price"><br>
        <input type="submit" value="Add Flight">
    </form>

    <%-- Existing flights list --%>
    <%
        List<Flight> flightList = FlightDAO.getAllFlights(); // Replace with your actual method
        for (Flight flight : flightList) {
    %>
        <div>
            Flight Number: <%= flight.getFlightNum() %><br>
            Airline ID: <%= flight.getAirlineId() %><br>
            Aircraft ID: <%= flight.getAircraftId() %><br>
            From Airport: <%= flight.getFromAirport() %><br>
            From Date: <%= flight.getFromDate() %><br>
            From Time: <%= flight.getFromTime() %><br>
            To Airport: <%= flight.getToAirport() %><br>
            To Date: <%= flight.getToDate() %><br>
            To Time: <%= flight.getToTime() %><br>
            Number of Seats: <%= flight.getNumSeats() %><br>
            Is Domestic: <%= flight.getIsDomestic() ? "Yes" : "No" %><br>
            Flight Type: <%= flight.getFlightType() %><br>
            Number of Stops: <%= flight.getNumStops() %><br>
            Economy Price: <%= flight.getEcoPrice() %><br>
            Business Price: <%= flight.getBusPrice() %><br>
            First Class Price: <%= flight.getFirPrice() %><br>
            <a href="editFlight.jsp?flight_num=<%= flight.getFlightNum() %>">Edit</a> |
            <a href="EditFlightServlet?action=delete&flight_num=<%= flight.getFlightNum() %>">Delete</a>
        </div>
    <%
        }
    %>
</div>


<script>
    function openTab(evt, tabName) {
        var i, tabcontent, tablinks;
        tabcontent = document.getElementsByClassName("tabcontent");
        for (i = 0; i < tabcontent.length; i++) {
            tabcontent[i].style.display = "none";
        }
        tablinks = document.getElementsByClassName("tablinks");
        for (i = 0; i < tablinks.length; i++) {
            tablinks[i].className = tablinks[i].className.replace(" active", "");
        }
        document.getElementById(tabName).style.display = "block";
        evt.currentTarget.className += " active";
    }
</script>

</body>
</html>
