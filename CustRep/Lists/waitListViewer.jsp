<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.air.*" import="java.util.*" import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Waitlisted Customers</title>
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
        // Retrieve the flight number from the request
        String flightNum = request.getParameter("flight_num");

        // Database setup - replace with your database details
        ApplicationDB db = new ApplicationDB();	
    

        Connection conn = db.getConnection();
        Statement stmt = null;
        ResultSet rs = null;
    %>

    <h1>Waitlisted Customers for Flight: <%= flightNum %></h1>

    <table border="1">
        <tr>
            <th>Username</th>
            <th>First Name</th>
            <th>Last Name</th>
        </tr>
        <%
            try {
                Class.forName("com.mysql.jdbc.Driver");
                
                stmt = conn.createStatement();

                String query = "SELECT username, f_name, l_name FROM waitlist WHERE flight_num = " + flightNum;
                rs = stmt.executeQuery(query);

                while (rs.next()) {
                    String username = rs.getString("username");
                    String fName = rs.getString("f_name");
                    String lName = rs.getString("l_name");
        %>
                    <tr>
                        <td><%= username %></td>
                        <td><%= fName %></td>
                        <td><%= lName %></td>
                    </tr>
        <%
                }
            } catch (Exception e) {
                out.println("Error: " + e.getMessage());
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException e) {}
                if (stmt != null) try { stmt.close(); } catch (SQLException e) {}
                if (conn != null) try { conn.close(); } catch (SQLException e) {}
            }
        %>
    </table>
</body>
</html>