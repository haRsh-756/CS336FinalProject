<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.air.*" import="java.util.*" import="java.sql.*"%>
   <%@ page import="java.sql.*, java.util.*, javax.sql.*" %>
<%@ page import="javax.naming.InitialContext, javax.naming.Context" %>

<!DOCTYPE html>

<%
    String user = (String) session.getAttribute("user");
    String queryPast = "SELECT * FROM ticket WHERE username = ? AND from_date < CURDATE() ORDER BY from_date DESC, from_time DESC";
    String queryUpcoming = "SELECT * FROM ticket WHERE username = ? AND from_date >= CURDATE() ORDER BY from_date ASC, from_time ASC";
%>
<html>
<head>
    <title>Reservation Display</title>
    <style>
        table, th, td {
            border: 1px solid black;
            border-collapse: collapse;
            padding: 5px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
    </style>
    <script>
        function toggleReservations() {
            var select = document.getElementById("reservationType");
            var type = select.options[select.selectedIndex].value;
            var form = document.getElementById("reservationForm");
            form.action = type === "past" ? "reservationDisplay.jsp?past=true" : "reservationDisplay.jsp?upcoming=true";
            form.submit();
        }
    </script>
</head>
<body>
<%@ page import ="java.sql.*" %>
    <form action="../custLogout.jsp" method="post">
        <input type="submit" value="Logout">
    </form>
    <form action="../custSuccess.jsp" method="post">
        <input type="submit" value="Back">
    </form>


    <h2>Tickets from <%= user %></h2>
    <form id="reservationForm" method="post">
        <select id="reservationType" onchange="toggleReservations()">
            <option value="past" <%= request.getParameter("upcoming") == null ? "selected" : "" %>>Past Flights</option>
            <option value="upcoming" <%= request.getParameter("upcoming") != null ? "selected" : "" %>>Upcoming Flights</option>
        </select>
    </form>

    <%
        boolean past = request.getParameter("past") != null || request.getParameter("upcoming") == null;
        boolean upcoming = request.getParameter("upcoming") != null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            Context initContext = new InitialContext();
            Context envContext = (Context) initContext.lookup("java:/comp/env");
            ApplicationDB db = new ApplicationDB();
            conn = db.getConnection();

            pstmt = past ? conn.prepareStatement(queryPast) : conn.prepareStatement(queryUpcoming);
            pstmt.setString(1, user);
            rs = pstmt.executeQuery();

            if (!rs.isBeforeFirst()) {
                out.println(past ? "<p>No Past Flights</p>" : "<p>No Upcoming Flights</p>");
            } else {
    %>
                <table>
                    <tr>
                        <th>Purchase Date</th>
                        <th>ID Number</th>
                        <th>Airline ID</th>
                        <th>Flight Number</th>
                        <th>Class</th>
                        <th>From Airport</th>
                        <th>Departure Date</th>
                        <th>Departure Time</th>
                        <th>To Airport</th>
                        <th>Seat Number</th>
                        <th>Passenger Name</th>
                        <th>Total Fare</th>
                        <th>Action</th>
                    </tr>
    <%
                while (rs.next()) {
                    String ticketClass = rs.getString("class");
                    boolean isCancelable = "First Class".equals(ticketClass) || "Business".equals(ticketClass);
    %>
                    <tr>
                        <td><%= rs.getDate("p_date") %></td>
                        <td><%= rs.getInt("id_num") %></td>
                        <td><%= rs.getString("airline_id") %></td>
                        <td><%= rs.getInt("flight_num") %></td>
                        <td><%= ticketClass %></td>
                        <td><%= rs.getString("from_airport") %></td>
                        <td><%= rs.getDate("from_date") %></td>
                        <td><%= rs.getTime("from_time") %></td>
                        <td><%= rs.getString("to_airport") %></td>
                        <td><%= rs.getInt("seat_num") %></td>
                        <td><%= rs.getString("f_Name") %> <%= rs.getString("l_Name") %></td>
                        <td><%= rs.getFloat("total_fare") %></td>
                        <%
                            if (isCancelable) {
                        %>
                                <td><a href="cancelFlight.jsp?id=<%= rs.getInt("id_num") %>">Cancel Flight</a></td>
                        <%
                            } else {
                                out.print("<td></td>");
                            }
                        %>
                    </tr>
    <%
                }
            }
        } catch (Exception e) {
            out.println("Error: " + e.getMessage());
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException e) {}
            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) {}
            if (conn != null) try { conn.close(); } catch (SQLException e) {}
        }
    %>
                </table>
</body>
</html>
