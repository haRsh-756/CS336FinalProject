<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*, com.air.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Aircraft</title>
    <!-- Add any required CSS or JS -->
</head>
<body>

<%
    String aircraftId = request.getParameter("aircraft_id");
    Aircraft aircraft = AircraftDAO.getAircraftById(aircraftId); // Fetch the aircraft data
%>

<h3>Edit Aircraft</h3>

<!-- Form for editing an aircraft -->
<form action="AircraftServlet" method="post">
    <input type="hidden" name="action" value="edit">
    <input type="hidden" name="aircraft_id" value="<%= aircraft.getAircraftId() %>">

    Aircraft ID: <%= aircraft.getAircraftId() %><br>
    Number of Seats: <input type="number" name="num_seats" value="<%= aircraft.getNumSeats() %>"><br>
    <input type="submit" value="Update Aircraft">
</form>

</body>
</html>
