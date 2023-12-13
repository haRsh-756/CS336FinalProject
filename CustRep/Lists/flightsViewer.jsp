<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.air.*" import="java.util.*" import="java.sql.*"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Flight List</title>
</head>
<body>

<%@ page import ="java.sql.*" %>
    <form action="../custRepLogout.jsp" method="post">
        <input type="submit" value="Logout">
    </form>
    <form action="ListSelect.jsp" method="post">
        <input type="submit" value="Back">
    </form>
    
     <% 
        // Retrieve the flight direction and airport ID from the request
        String flightDirection = request.getParameter("flightDirection");
        String airportId = request.getParameter("airport_id");

        // Database setup - replace with your database details
        ApplicationDB db = new ApplicationDB();	
    

        Connection con = db.getConnection();
        Statement stmt = null;
        ResultSet rs = null;

        String query = "";
    %>

    <h1>Flights <%= "Departing".equals(flightDirection) ? "Departing From" : "Arriving To" %>: <%= airportId %></h1>

    <table border="1">
        <tr>
            <th>From Airport</th>
            <th>To Airport</th>
            <th>Flight Number</th>
            <th>Airline ID</th>
            <th>Aircraft ID</th>
            <th>From Date</th>
            <th>From Time</th>
            <th>To Date</th>
            <th>To Time</th>
        </tr>
        <%
            try {
                Class.forName("com.mysql.jdbc.Driver");
                stmt = con.createStatement();

                if ("Departing".equals(flightDirection)) {
                    query = "SELECT * FROM flights WHERE from_airport = '" + airportId + "' ORDER BY from_date, from_time";
                } else {
                    query = "SELECT * FROM flights WHERE to_airport = '" + airportId + "' ORDER BY to_date, to_time";
                }

                rs = stmt.executeQuery(query);

                while (rs.next()) {
                    String fromAirport = rs.getString("from_airport");
                    String toAirport = rs.getString("to_airport");
                    String flightNum = rs.getString("flight_num");
                    String airlineId = rs.getString("airline_id");
                    String aircraftId = rs.getString("aircraft_id");
                    String fromDate = rs.getString("from_date");
                    String fromTime = rs.getString("from_time");
                    String toDate = rs.getString("to_date");
                    String toTime = rs.getString("to_time");
        %>
                    <tr>
                        <td><%= fromAirport %></td>
                        <td><%= toAirport %></td>
                        <td><%= flightNum %></td>
                        <td><%= airlineId %></td>
                        <td><%= aircraftId %></td>
                        <td><%= fromDate %></td>
                        <td><%= fromTime %></td>
                        <td><%= toDate %></td>
                        <td><%= toTime %></td>
                    </tr>
        <%
                }
            } catch (Exception e) {
                out.println("Error: " + e.getMessage());
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException e) {}
                if (stmt != null) try { stmt.close(); } catch (SQLException e) {}
                if (con != null) try { con.close(); } catch (SQLException e) {}
            }
        %>
    </table>
</body>
</html>