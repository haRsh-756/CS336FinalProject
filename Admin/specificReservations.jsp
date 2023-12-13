<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.air.*" import="java.util.*" import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Specific Reservation List</title>
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
        String searchType = request.getParameter("searchType");
        String searchValue = request.getParameter("searchValue");
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        // Assuming 'ApplicationDB' is a class that provides a connection to the database
        ApplicationDB db = new ApplicationDB(); 
        con = db.getConnection();

        String sql = "";
        boolean dataExists = false;

        if("flightNumber".equals(searchType)) {
            out.println("<h2>List of reservations from Flight: " + searchValue + "</h2>");
            sql = "SELECT username, id_num, airline_id, from_airport, class, f_Name, l_Name FROM ticket WHERE flight_num = ?";
        } else if("customerUsername".equals(searchType)) {
            out.println("<h2>List of reservations from: " + searchValue + "</h2>");
            sql = "SELECT flight_num, id_num, airline_id, from_airport, class, f_Name, l_Name FROM ticket WHERE username = ?";
        }

        pstmt = con.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
        pstmt.setString(1, searchValue);
        rs = pstmt.executeQuery();

        if(rs.next()) {
            dataExists = true;
            rs.beforeFirst(); // Reset cursor to the beginning
    %>

    <table border="1">
        <tr>
            <% if("flightNumber".equals(searchType)) { %>
                <th>Username</th>
            <% } else if("customerUsername".equals(searchType)) { %>
                <th>Flight Number</th>
            <% } %>
            <th>Ticket Number</th>
            <th>Airline ID</th>
            <th>From Airport</th>
            <th>Class</th>
            <th>First Name</th>
            <th>Last Name</th>
        </tr>

        <% while(rs.next()) { %>
            <tr>
                <% if("flightNumber".equals(searchType)) { %>
                    <td><%= rs.getString("username") %></td>
                <% } else if("customerUsername".equals(searchType)) { %>
                    <td><%= rs.getInt("flight_num") %></td>
                <% } %>
                <td><%= rs.getInt("id_num") %></td>
                <td><%= rs.getString("airline_id") %></td>
                <td><%= rs.getString("from_airport") %></td>
                <td><%= rs.getString("class") %></td>
                <td><%= rs.getString("f_Name") %></td>
                <td><%= rs.getString("l_Name") %></td>
            </tr>
        <% } %>
    </table>

    <% 
        } else {
            if("flightNumber".equals(searchType)) {
                out.println("<p>Flight does not exist, or was not purchased</p>");
            } else if("customerUsername".equals(searchType)) {
                out.println("<p>Username does not exist, or has no ticket history</p>");
            }
        }

        rs.close();
        pstmt.close();
        con.close();
    %>

    <form action="flightFinanceSearch.jsp">
        <input type="submit" value="Go Back">
    </form>
</body>
</html>
