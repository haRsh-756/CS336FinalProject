<%@ page import="java.sql.*, java.text.SimpleDateFormat, java.util.Calendar" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.air.*" import="java.util.*" import="java.sql.*"%>
    
<!DOCTYPE html>
<html>
<head>
    <title>Monthly Sales Report</title>
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
    <%
        String month = request.getParameter("month");
        String year = request.getParameter("year");
        SimpleDateFormat sdf = new SimpleDateFormat("MMMM yyyy");
        Calendar cal = Calendar.getInstance();
        cal.set(Calendar.YEAR, Integer.parseInt(year));
        cal.set(Calendar.MONTH, Integer.parseInt(month) - 1); // Calendar month is 0-indexed, January is 0
        String readableMonthYear = sdf.format(cal.getTime());

        ApplicationDB db = new ApplicationDB();	
        Connection conn = db.getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.jdbc.Driver");

            // Top-selling airline
            String airlineQuery = "SELECT airline_id, COUNT(*) AS tickets_sold, SUM(total_fare) AS total_revenue FROM ticket WHERE YEAR(p_date) = ? AND MONTH(p_date) = ? GROUP BY airline_id ORDER BY total_revenue DESC LIMIT 1";
            // Top-selling from_airport
            String airportQuery = "SELECT from_airport, COUNT(*) AS tickets_sold, SUM(total_fare) AS total_revenue FROM ticket WHERE YEAR(p_date) = ? AND MONTH(p_date) = ? GROUP BY from_airport ORDER BY total_revenue DESC LIMIT 1";
            // Highest revenue date
            String dateQuery = "SELECT p_date, COUNT(*) AS tickets_sold, SUM(total_fare) AS total_revenue FROM ticket WHERE YEAR(p_date) = ? AND MONTH(p_date) = ? GROUP BY p_date ORDER BY total_revenue DESC LIMIT 1";

            // Begin display of report
            %><h2>Sales Report for <%= readableMonthYear %></h2><%

            // Top-selling airline section
            pstmt = conn.prepareStatement(airlineQuery);
            pstmt.setInt(1, Integer.parseInt(year));
            pstmt.setInt(2, Integer.parseInt(month));
            rs = pstmt.executeQuery();
            if(rs.next()) {
                String topAirline = rs.getString("airline_id");
                int ticketsSold = rs.getInt("tickets_sold");
                double totalRevenue = rs.getDouble("total_revenue");
                %><h3>Top Selling Airline</h3>
                <p>Airline ID: <%= topAirline %><br>
                Tickets Sold: <%= ticketsSold %><br>
                Total Revenue: $<%= totalRevenue %></p><%
            }

            // Reset the PreparedStatement for the next query
            pstmt.clearParameters();

            // Top-selling from_airport section
            pstmt = conn.prepareStatement(airportQuery);
            pstmt.setInt(1, Integer.parseInt(year));
            pstmt.setInt(2, Integer.parseInt(month));
            rs = pstmt.executeQuery();
            if(rs.next()) {
                String topAirport = rs.getString("from_airport");
                int ticketsSold = rs.getInt("tickets_sold");
                double totalRevenue = rs.getDouble("total_revenue");
                %><h3>Top Selling From Airport</h3>
                <p>From Airport: <%= topAirport %><br>
                Tickets Sold: <%= ticketsSold %><br>
                Total Revenue: $<%= totalRevenue %></p><%
            }

            // Reset the PreparedStatement for the next query
            pstmt.clearParameters();

            // Highest revenue date section
            pstmt = conn.prepareStatement(dateQuery);
            pstmt.setInt(1, Integer.parseInt(year));
            pstmt.setInt(2, Integer.parseInt(month));
            rs = pstmt.executeQuery();
            if(rs.next()) {
            	java.sql.Date highestRevenueDate = rs.getDate("p_date");
                int ticketsSold = rs.getInt("tickets_sold");
                double totalRevenue = rs.getDouble("total_revenue");
                %><h3>Highest Revenue Date</h3>
                <p>Date: <%= highestRevenueDate.toString() %><br>
                Tickets Sold: <%= ticketsSold %><br>
                Total Revenue: $<%= totalRevenue %></p><%
            }
            
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