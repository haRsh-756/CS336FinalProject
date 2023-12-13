<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.air.*" import="java.util.*" import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
    <title>Revenue List</title>
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
    <h2>Revenue Generated List</h2>
    <%
        String revenueFilterType = request.getParameter("revenueFilterType");
    ApplicationDB db = new ApplicationDB();	
    Connection conn = db.getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            
            String sql = "";
            if ("flight".equals(revenueFilterType)) {
                sql = "SELECT flight_num, COUNT(*) AS tickets_sold, SUM(total_fare) AS total_revenue FROM ticket GROUP BY flight_num ORDER BY flight_num ASC";
            } else if ("airline".equals(revenueFilterType)) {
                sql = "SELECT airline_id, COUNT(*) AS tickets_sold, SUM(total_fare) AS total_revenue FROM ticket GROUP BY airline_id ORDER BY airline_id ASC";
            } else if ("customer".equals(revenueFilterType)) {
                sql = "SELECT username, COUNT(*) AS tickets_sold, SUM(total_fare) AS total_revenue FROM ticket GROUP BY username ORDER BY username ASC";
            }

            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            %>
            <table border="1">
                <tr>
                    <th><%= revenueFilterType.substring(0, 1).toUpperCase() + revenueFilterType.substring(1) %></th>
                    <th>Number of Tickets Sold</th>
                    <th>Total Revenue</th>
                </tr>
            <%
            while (rs.next()) {
                String identifier = "";
                if ("flight".equals(revenueFilterType)) {
                    identifier = rs.getString("flight_num");
                } else if ("airline".equals(revenueFilterType)) {
                    identifier = rs.getString("airline_id");
                } else if ("customer".equals(revenueFilterType)) {
                    identifier = rs.getString("username");
                }
                int ticketsSold = rs.getInt("tickets_sold");
                double totalRevenue = rs.getDouble("total_revenue");
                %>
                <tr>
                    <td><%= identifier %></td>
                    <td><%= ticketsSold %></td>
                    <td><%= totalRevenue %></td>
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