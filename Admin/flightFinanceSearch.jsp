<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.air.*" import="java.util.*" import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Flight and Finance Search</title>

</head>
<body>
	<%@ page import ="java.sql.*" %>
    <form action="adminLogout.jsp" method="post">
        <input type="submit" value="Logout">
    </form>
    <form action="adminSuccess.jsp" method="post">
        <input type="submit" value="Back">
    </form>
	
	
    <% 
    ApplicationDB db = new ApplicationDB();	
    Connection con = db.getConnection();
    PreparedStatement pst = null;
	try {
		Class.forName("com.mysql.jdbc.Driver");
		
		//String sql = "SELECT username, f_Name, l_Name, SUM(total_fare) as total_revenue FROM ticket GROUP BY"
		//			+ " username, f_Name, l_Name ORDER BY total_revenue DESC LIMIT 1";
		String sql = "SELECT t1.username, t1.f_Name, t1.l_Name, t2.total_revenue FROM ticket t1 " +
					"INNER JOIN (SELECT username, SUM(total_fare) AS total_revenue FROM ticket GROUP BY username) t2 " +
					"ON t1.username = t2.username ORDER BY t2.total_revenue DESC LIMIT 1";
		pst = con.prepareStatement(sql);
		ResultSet rs = pst.executeQuery();
		if(rs.next()){
			String custUser = rs.getString("username");
			String custFName = rs.getString("f_name");
			String custLName = rs.getString("l_name");
			double revenue = rs.getDouble("total_revenue");
			%>
			<h2>Highest Revenue Customer: <%= custUser %></h2>
			<p>Total Revenue: <%= revenue %></p>
			<%
		}
	} catch(Exception e) {
		e.printStackTrace();
	}
    %>
    
     <% 
        PreparedStatement pstmt = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            String sql = "SELECT flight_num, COUNT(*) AS ticket_count FROM ticket GROUP BY flight_num ORDER BY ticket_count DESC LIMIT 5";
            pstmt = con.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();

            %>
            <h2>Top 5 Most Active Flights (Most Tickets Sold)</h2>
            <table>
                <tr>
                    <th>Flight Number</th>
                    <th>Number of Tickets Sold</th>
                </tr>
            <%
            while(rs.next()){
                int flightNumber = rs.getInt("flight_num");
                int ticketsSold = rs.getInt("ticket_count");
                %>
                <tr>
                    <td><%= flightNumber %></td>
                    <td><%= ticketsSold %></td>
                </tr>
                <%
            }
            %>
            </table>
            <%
            rs.close();
            pstmt.close();
            con.close();
        } catch(Exception e) {
            e.printStackTrace();
        }
    %>

    <h3>List of Reservations by:</h3>
    <form action="reservations.jsp" method="get">
        <select name="filterType">
            <option value="flightNumber">Flight Number</option>
            <option value="userName">User Name</option>
        </select>
        <input type="submit" value="Go to Reservation List">
    </form>

    <h3>List of Revenue Generated by:</h3>
    <form action="revenue.jsp" method="get">
        <select name="revenueFilterType">
            <option value="flight">Flight</option>
            <option value="airline">Airline</option>
            <option value="customer">Customer</option>
        </select>
        <input type="submit" value="Go to Revenue List">
    </form>
    
    <h3>Specified list of reservations</h3>
    <form action="specificReservations.jsp" method="get">
        <select name="searchType">
            <option value="flightNumber">Flight Number</option>
            <option value="customerUsername">Customer Username</option>
        </select>
        <input type="text" name="searchValue" placeholder="Enter value here">
        <input type="submit" value="Go to List">
    </form>
    
    <h2>Select Month and Year for Sales Report</h2>
    <form action="salesReport.jsp" method="post">
        <label for="monthSelect">Month:</label>
        <select id="monthSelect" name="month">
            <option value="01">January</option>
            <option value="02">February</option>
            <option value="03">March</option>
            <option value="04">April</option>
            <option value="05">May</option>
            <option value="06">June</option>
            <option value="07">July</option>
            <option value="08">August</option>
            <option value="09">September</option>
            <option value="10">October</option>
            <option value="11">November</option>
            <option value="12">December</option>
        </select>

        <label for="yearSelect">Year:</label>
        <select id="yearSelect" name="year">
            <% // Generate a list of years dynamically
            int currentYear = Calendar.getInstance().get(Calendar.YEAR);
            for (int i = currentYear+1; i >= 2000; i--) { %>
                <option value="<%= i %>"><%= i %></option>
            <% } %>
        </select>

        <input type="submit" value="Sales Report for Selected Month & Year">
    </form>
</body>
</html>
