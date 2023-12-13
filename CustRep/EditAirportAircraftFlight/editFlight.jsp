<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*, com.air.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Flight</title>
    <!-- Add any required CSS or JS -->
</head>
<body>

<%
    int flightNum = Integer.parseInt(request.getParameter("flight_num"));
    Flight flight = FlightDAO.getFlightByNum(flightNum); // Fetch the flight data
%>

<h3>Edit Flight</h3>

<!-- Form for editing a flight -->
<form action="EditFlightServlet" method="post">
    <input type="hidden" name="action" value="edit">
    <input type="hidden" name="flight_num" value="<%= flight.getFlightNum() %>">

    Airline ID: <input type="text" name="airline_id" value="<%= flight.getAirlineId() %>"><br>
    Aircraft ID: <input type="text" name="aircraft_id" value="<%= flight.getAircraftId() %>"><br>
    From Airport: <input type="text" name="from_airport" value="<%= flight.getFromAirport() %>"><br>
    From Date: <input type="date" name="from_date" value="<%= flight.getFromDate() %>"><br>
    From Time: <input type="time" name="from_time" value="<%= flight.getFromTime() %>"><br>
    To Airport: <input type="text" name="to_airport" value="<%= flight.getToAirport() %>"><br>
    To Date: <input type="date" name="to_date" value="<%= flight.getToDate() %>"><br>
    To Time: <input type="time" name="to_time" value="<%= flight.getToTime() %>"><br>
    Number of Seats: <input type="number" name="num_seats" value="<%= flight.getNumSeats() %>"><br>
    Is Domestic: <input type="checkbox" name="is_domestic" <%= flight.getIsDomestic() ? "checked" : "" %>><br>
    Flight Type: <input type="text" name="flight_type" value="<%= flight.getFlightType() %>"><br>
    Number of Stops: <input type="number" name="num_stops" value="<%= flight.getNumStops() %>"><br>
    Economy Price: <input type="text" name="eco_price" value="<%= flight.getEcoPrice() %>"><br>
    Business Price: <input type="text" name="bus_price" value="<%= flight.getBusPrice() %>"><br>
    First Class Price: <input type="text" name="fir_price" value="<%= flight.getFirPrice() %>"><br>
    <input type="submit" value="Update Flight">
</form>

</body>
</html>
