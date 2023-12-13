<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*, com.air.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Airport</title>
    <!-- Add any required CSS or JS -->
</head>
<body>

<%
    String currentAirportId = request.getParameter("airport_id");
    // Assuming AirportDAO.getAirportById() fetches the airport data
    Airport airport = AirportDAO.getAirportById(currentAirportId);
%>

<h3>Edit Airport</h3>

<!-- Form for editing an airport -->
<form action="EditAirportServlet" method="post">
    <input type="hidden" name="action" value="edit">
    <input type="hidden" name="current_airport_id" value="<%= currentAirportId %>">

    New Airport ID: <input type="text" name="new_airport_id" value="<%= airport.getAirportId() %>"><br>
    <input type="submit" value="Update Airport">
</form>

</body>
</html>
