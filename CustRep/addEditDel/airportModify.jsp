<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.air.*" import="java.util.*" import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Modify Airports Data</title>
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

    <h1>Modify Airports Data</h1>

    <!-- Section for Adding Airport -->
    <h2>Add Airport</h2>
    <form action="airportModify.jsp" method="post">
        Airport ID: <input type="text" name="newAirportId" maxlength="3"><br>
        <button type="submit" name="action" value="add">Add Airport</button>
    </form>

    <!-- Section for Deleting Airport -->
    <h2>Delete Airport</h2>
    <form action="airportModify.jsp" method="post">
        Airport ID: <input type="text" name="deleteAirportId" maxlength="3"><br>
        <button type="submit" name="action" value="delete">Delete Airport</button>
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
                String airportId = "";

                switch (action) {
                    case "add":
                        airportId = request.getParameter("newAirportId");
                        pstmt = conn.prepareStatement("INSERT INTO airport (airport_id) VALUES (?)");
                        pstmt.setString(1, airportId);
                        try {
                            pstmt.executeUpdate();
                            message = "Airport added successfully!";
                        } catch (SQLException e) {
                            message = "Airport already exists!";
                        }
                        break;

                    case "delete":
                        airportId = request.getParameter("deleteAirportId");
                        pstmt = conn.prepareStatement("DELETE FROM airport WHERE airport_id = ?");
                        pstmt.setString(1, airportId);
                        int rowsDeleted = pstmt.executeUpdate();
                        if (rowsDeleted > 0) {
                            message = "Airport deleted successfully!";
                        } else {
                            message = "Airport does not exist!";
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