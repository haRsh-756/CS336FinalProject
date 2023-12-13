<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.air.*" import="java.util.*" import="java.sql.*"%>
   <%@ page import="java.sql.*, java.util.*, javax.sql.*" %>
<%@ page import="javax.naming.InitialContext, javax.naming.Context" %>
<!DOCTYPE html>

<%
    String idNum = request.getParameter("id");
    String confirm = request.getParameter("confirm");
    String message = "";

    Context initContext = new InitialContext();
    Context envContext = (Context) initContext.lookup("java:/comp/env");
    ApplicationDB db = new ApplicationDB();
    Connection conn = db.getConnection();

    if ("YES".equals(confirm)) {
        String deleteQuery = "DELETE FROM ticket WHERE id_num = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(deleteQuery)) {
            pstmt.setInt(1, Integer.parseInt(idNum));
            int affectedRows = pstmt.executeUpdate();
            message = affectedRows > 0 ? "Cancellation Successful" : "Cancellation Unsuccessful";
        } catch (Exception e) {
            message = "Error: " + e.getMessage();
        }
    }

    String selectQuery = "SELECT * FROM ticket WHERE id_num = ?";
    ResultSet rs = null;
    try (PreparedStatement pstmt = conn.prepareStatement(selectQuery)) {
        pstmt.setInt(1, Integer.parseInt(idNum));
        rs = pstmt.executeQuery();
%>
<html>
<head>
    <title>Cancel Flight</title>
    <style>
        table {
            border-collapse: collapse;
            width: 100%;
        }
        th, td {
            border: 1px solid black;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
<%@ page import ="java.sql.*" %>
    <form action="../custLogout.jsp" method="post">
        <input type="submit" value="Logout">
    </form>
    <form action="reservationDisplay.jsp" method="post">
        <input type="submit" value="Back">
    </form>

<h2>Ticket Cancellation</h2>
    <%
        if (!"true".equals(confirm) && rs.next()) {
    %>
        <table>
            <tr>
                <th>ID Number</th>
                <th>From Airport</th>
                <th>To Airport</th>
                <th>Departure Date</th>
                <th>Departure Time</th>
                <th>Airline ID</th>
                <th>Aircraft ID</th>
                <th>Flight Number</th>
                <th>Seat Number</th>
                <th>Class</th>
                <th>Passenger Name</th>
                <th>Fare</th>
            </tr>
            <tr>
                <td><%= rs.getInt("id_num") %></td>
                <td><%= rs.getString("from_airport") %></td>
                <td><%= rs.getString("to_airport") %></td>
                <td><%= rs.getDate("from_date") %></td>
                <td><%= rs.getTime("from_time") %></td>
                <td><%= rs.getString("airline_id") %></td>
                <td><%= rs.getString("aircraft_id") %></td>
                <td><%= rs.getInt("flight_num") %></td>
                <td><%= rs.getInt("seat_num") %></td>
                <td><%= rs.getString("class") %></td>
                <td><%= rs.getString("f_Name") %> <%= rs.getString("l_Name") %></td>
                <td><%= rs.getFloat("total_fare") %></td>
            </tr>
        </table>
        <p>Are you sure you want to cancel your ticket?</p>
        <form action="cancelFlight.jsp" method="get">
            <input type="hidden" name="id" value="<%= idNum %>" />
            <input type="submit" name="confirm" value="YES" />
            <button type="button" onclick="location.href='reservationDisplay.jsp'">GO BACK</button>
        </form>
    <%
        } else {
            out.println("<p>" + message + "</p>");
            out.println("<button type='button' onclick='location.href=\"reservationDisplay.jsp\"'>Go Back</button>");
        }
        if (rs != null) rs.close();
        conn.close();
    %>
</body>
</html>
<%
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    }
%>
