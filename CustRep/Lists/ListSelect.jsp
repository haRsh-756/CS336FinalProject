<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>List Viewer</title>
</head>
<body>


<%@ page import ="java.sql.*" %>
    <form action="../custRepLogout.jsp" method="post">
        <input type="submit" value="Logout">
    </form>
    <form action="../custRepSuccess.jsp" method="post">
        <input type="submit" value="Back">
    </form>

    <h1>List Viewer</h1>

    <h2>List of Waitlisted Customers</h2>
    <form action="waitListViewer.jsp" method="GET">
        Flight Number: <input type="text" name="flight_num" required/>
        <input type="submit" value="GO"/>
    </form>

    <h2>List of Flights by Airport</h2>
    <form action="flightsViewer.jsp" method="GET">
        <label for="flightDirection">Flight Direction:</label>
        <select name="flightDirection" id="flightDirection">
            <option value="Departing">Departing</option>
            <option value="Arriving">Arriving</option>
        </select>
        <br>
        Airport ID: <input type="text" name="airport_id" required/>
        <input type="submit" value="GO"/>
    </form>
</body>
</html>