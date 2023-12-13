<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.air.*" import="java.util.*" import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
    <title>Reservations List</title>
    <!-- Add any necessary CSS files or inline styles here -->
</head>
<body>
<%@ page import ="java.sql.*" %>
    <form action="adminLogout.jsp" method="post">
        <input type="submit" value="Logout">
    </form>
    <form action="flightFinanceSearch.jsp" method="post">
        <input type="submit" value="Back">
    </form>
    <h2>Reservations List (Ascending Order)</h2>
    <%
        String filterType = request.getParameter("filterType");
    ApplicationDB db = new ApplicationDB();	
    Connection conn = db.getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            
            String sql = "";
            if ("flightNumber".equals(filterType)) {
                sql = "SELECT flight_num, id_num AS ticket_num, username, airline_id, from_airport, class, from_date, f_Name, l_Name FROM ticket ORDER BY flight_num ASC";
            } else if ("userName".equals(filterType)) {
                sql = "SELECT username, id_num AS ticket_num, flight_num, airline_id, from_airport, class, from_date, f_Name, l_Name FROM ticket ORDER BY username ASC";
            }

            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            %>
            <table border="1">
                <tr>
                    <% if ("flightNumber".equals(filterType)) { %>
                        <th>Flight Number</th>
                        <th>Ticket Number</th>
                        <th>User Name</th>
                    <% } else if ("userName".equals(filterType)) { %>
                        <th>User Name</th>
                        <th>Ticket Number</th>
                        <th>Flight Number</th>
                    <% } %>
                    <th>Airline ID</th>
                    <th>From Airport</th>
                    <th>Class</th>
                    <th>From Date</th>
                    <th>First Name</th>
                    <th>Last Name</th>
                </tr>
            <%
            while (rs.next()) {
                %>
                <tr>
                    <% if ("flightNumber".equals(filterType)) { %>
                        <td><%= rs.getInt("flight_num") %></td>
                        <td><%= rs.getInt("ticket_num") %></td>
                        <td><%= rs.getString("username") %></td>
                    <% } else if ("userName".equals(filterType)) { %>
                        <td><%= rs.getString("username") %></td>
                        <td><%= rs.getInt("ticket_num") %></td>
                        <td><%= rs.getInt("flight_num") %></td>
                    <% } %>
                    <td><%= rs.getString("airline_id") %></td>
                    <td><%= rs.getString("from_airport") %></td>
                    <td><%= rs.getString("class") %></td>
                    <td><%= rs.getDate("from_date") %></td>
                    <td><%= rs.getString("f_Name") %></td>
                    <td><%= rs.getString("l_Name") %></td>
                </tr>
                <%
            }
            %>
            </table>
            <%
        } catch(Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    %>
</body>
</html>