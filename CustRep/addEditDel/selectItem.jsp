<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Select Item</title>
</head>
<body>

<%@ page import ="java.sql.*" %>
    <form action="../custRepLogout.jsp" method="post">
        <input type="submit" value="Logout">
    </form>
    <form action="../custRepSuccess.jsp" method="post">
        <input type="submit" value="Back">
    </form>
    
    
    <h1>Select Item to Add, Edit, or Delete</h1>

    <form action="aircraftModify.jsp" method="get">
        <button type="submit">Aircrafts</button>
    </form>

    <form action="airportModify.jsp" method="get">
        <button type="submit">Airports</button>
    </form>

    <form action="flightModify.jsp" method="get">
        <button type="submit">Flights</button>
    </form>
</body>
</html>
