<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.air.*" import="java.util.*" import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Modify Flights Data</title>
    <!-- Add any CSS or JS here if needed -->
</head>
<body>

<%@ page import ="java.sql.*" %>
    <form action="../custRepLogout.jsp" method="post">
        <input type="submit" value="Logout">
    </form>
    <form action="selectItem.jsp" method="post">
        <input type="submit" value="Back">
    </form>
    <h1>Modify Flights Data</h1>

    <!-- Section for Adding Flight -->
    <h2>Add Flight</h2>
	<form action="flightModify.jsp" method="post">
	    Airline ID: <input type="text" name="airlineId" maxlength="5"><br>
	    Aircraft ID: <input type="text" name="aircraftId" maxlength="5"><br>
	    From Airport: <input type="text" name="fromAirport" maxlength="5"><br>
	    From Date: <input type="date" name="fromDate"><br>
	    From Time: <input type="time" name="fromTime"><br>
	    To Airport: <input type="text" name="toAirport" maxlength="5"><br>
	    To Date: <input type="date" name="toDate"><br>
	    To Time: <input type="time" name="toTime"><br>
	    Is Domestic: <input type="checkbox" name="isDomestic"><br>
	    Flight Type: 
		<select name="flightType">
		    <option value="One Way">One Way</option>
		    <option value="Round Trip">Round Trip</option>
		</select><br>
	    Number of Stops: <input type="number" name="numStops"><br>
	    Economy Price: <input type="number" step="0.01" name="ecoPrice"><br>
	    Business Price: <input type="number" step="0.01" name="busPrice"><br>
	    First Class Price: <input type="number" step="0.01" name="firPrice"><br>
	    <button type="submit" name="action" value="add">Add Flight</button>
	</form>

    <!-- Section for Editing Flight -->
<h2>Edit Flights (WARNING: MAY EFFECT CUSTOMER TICKETS)</h2>
<form action="flightModify.jsp" method="post">
    Flight Number: <input type="number" name="flightNumToEdit"><br>
    Field To Be Changed: <select name="fieldToEdit">
        <option value="aircraft_id">Aircraft ID</option>
        <option value="fromDate">From Date</option>
        <option value="fromTime">From Time</option>
        <option value="toDate">To Date</option>
        <option value="toTime">To Time</option>
        <option value="eco_price">Economy Price</option>
		<option value="bus_price">Business Price</option>
		<option value="fir_price">First Class Price</option>
    </select><br>
    New Value: <input type="text" name="newValue"><br>
    <button type="submit" name="action" value="edit">Update Flight</button>
</form>

    <!-- Section for Deleting Flight -->
    <h2>Delete Flight (WARNING: MAY EFFECT CUSTOMER TICKETS)</h2>
    <form action="flightModify.jsp" method="post">
        Flight Number: <input type="number" name="flightNumToDelete"><br>
        <button type="submit" name="action" value="delete">Delete Flight</button>
    </form>

    <% 
    ApplicationDB db = new ApplicationDB();
	Connection conn = db.getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String message = "";

        try {
            Class.forName("com.mysql.jdbc.Driver");
            

            String action = request.getParameter("action");
            if (action != null) {
                switch (action) {
                case "add":
                    String airlineId = request.getParameter("airlineId");
                    String aircraftId = request.getParameter("aircraftId");
                    String fromAirport = request.getParameter("fromAirport");
                    String fromDate = request.getParameter("fromDate");
                    String fromTime = request.getParameter("fromTime");
                    String toAirport = request.getParameter("toAirport");
                    String toDate = request.getParameter("toDate");
                    String toTime = request.getParameter("toTime");
                    boolean isDomestic = request.getParameter("isDomestic") != null;
                    String flightType = request.getParameter("flightType");
                    int numStops = Integer.parseInt(request.getParameter("numStops"));
                    float ecoPrice = Float.parseFloat(request.getParameter("ecoPrice"));
                    float busPrice = Float.parseFloat(request.getParameter("busPrice"));
                    float firPrice = Float.parseFloat(request.getParameter("firPrice"));

                    // Validate the input values here as per your requirements

                    pstmt = conn.prepareStatement("INSERT INTO flights (airline_id, aircraft_id, from_airport, from_date, from_time, to_airport, to_date, to_time, is_domestic, flight_type, num_stops, eco_price, bus_price, fir_price) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
                    pstmt.setString(1, airlineId);
                    pstmt.setString(2, aircraftId);
                    pstmt.setString(3, fromAirport);
                    pstmt.setString(4, fromDate);
                    pstmt.setString(5, fromTime);
                    pstmt.setString(6, toAirport);
                    pstmt.setString(7, toDate);
                    pstmt.setString(8, toTime);
                    pstmt.setBoolean(9, isDomestic);
                    pstmt.setString(10, flightType);
                    pstmt.setInt(11, numStops);
                    pstmt.setFloat(12, ecoPrice);
                    pstmt.setFloat(13, busPrice);
                    pstmt.setFloat(14, firPrice);

                    try {
                        pstmt.executeUpdate();
                        message = "Flight added successfully!";
                    } catch (SQLException e) {
                        message = "Error adding flight: " + e.getMessage();
                    }
                    break;

                case "edit":
                    try {
                        String fieldToEdit = request.getParameter("fieldToEdit");
                        String newValue = request.getParameter("newValue");
                        int flightNumToEdit = Integer.parseInt(request.getParameter("flightNumToEdit"));

                        // Update the flights table
                        String updateFlightSql = String.format("UPDATE flights SET %s = ? WHERE flight_num = ?", fieldToEdit);
                        pstmt = conn.prepareStatement(updateFlightSql);

                        // Handle different data types for the flights table
                        if (fieldToEdit.equals("eco_price") || fieldToEdit.equals("bus_price") || fieldToEdit.equals("fir_price")) {
                            pstmt.setFloat(1, Float.parseFloat(newValue));
                        } else if (fieldToEdit.equals("aircraft_id")) {
                            pstmt.setString(1, newValue);
                        } else {
                            pstmt.setString(1, newValue); // For date and time fields
                        }
                        pstmt.setInt(2, flightNumToEdit);
                        int flightsUpdated = pstmt.executeUpdate();
                        message = "Flight updated: " + flightsUpdated + " row(s) affected.";

                        // Update the ticket table if the field is relevant
                        if (fieldToEdit.equals("from_date") || fieldToEdit.equals("from_time") ||
                            fieldToEdit.equals("to_date") || fieldToEdit.equals("to_time") || 
                            fieldToEdit.equals("aircraft_id")) {

                            String updateTicketSql = String.format("UPDATE ticket SET %s = ? WHERE flight_num = ?", fieldToEdit);
                            pstmt = conn.prepareStatement(updateTicketSql);

                            if (fieldToEdit.endsWith("Date") || fieldToEdit.endsWith("Time")) {
                                pstmt.setString(1, newValue);
                            } else if (fieldToEdit.equals("aircraft_id")) {
                                pstmt.setString(1, newValue);
                            }
                            pstmt.setInt(2, flightNumToEdit);
                            int ticketsUpdated = pstmt.executeUpdate();

                            message += " Tickets updated: " + ticketsUpdated + " row(s) affected.";
                        } 
                    } catch (NumberFormatException | SQLException e) {
                        message = "Error updating flight: " + e.getMessage();
                        e.printStackTrace();
                    }
                    break;
                case "delete":
                    int flightNumToDelete = Integer.parseInt(request.getParameter("flightNumToDelete"));

                    try {
                        // Start transaction
                        conn.setAutoCommit(false);

                        // Delete related tickets from the ticket table
                        pstmt = conn.prepareStatement("DELETE FROM ticket WHERE flight_num = ?");
                        pstmt.setInt(1, flightNumToDelete);
                        int ticketsDeleted = pstmt.executeUpdate();

                        // Delete flight from the flights table
                        pstmt = conn.prepareStatement("DELETE FROM flights WHERE flight_num = ?");
                        pstmt.setInt(1, flightNumToDelete);
                        int flightsDeleted = pstmt.executeUpdate();

                        // Commit transaction
                        conn.commit();

                        if (flightsDeleted > 0) {
                            message = "Flight and related tickets deleted successfully. Flights deleted: " + flightsDeleted + ", Tickets deleted: " + ticketsDeleted;
                        } else {
                            message = "No flight found with the specified flight number.";
                        }
                    } catch (Exception e) {
                        // Rollback in case of error
                        if (conn != null) {
                            try {
                                conn.rollback();
                            } catch (SQLException ex) {
                                message = "Error during rollback: " + ex.getMessage();
                            }
                        }
                        message = "Error deleting flight: " + e.getMessage();
                        e.printStackTrace();
                    } finally {
                        // Reset default commit behavior
                        if (conn != null) {
                            try {
                                conn.setAutoCommit(true);
                            } catch (SQLException ex) {
                                message = "Error resetting auto-commit: " + ex.getMessage();
                            }
                        }
                    }
                    break;
                }
            }
        } catch (Exception e) {
            message = "Error: " + e.getMessage();
            e.printStackTrace();
        } finally {
            if (pstmt != null) { pstmt.close(); }
            if (conn != null) { conn.close(); }
            if (rs != null) { rs.close(); }
        }
    %>
    <p><%= message %></p>
</body>
</html>