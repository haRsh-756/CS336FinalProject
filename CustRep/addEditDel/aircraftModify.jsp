<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.air.*" import="java.util.*" import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Modify Aircrafts Data</title>
</head>
<body>

<%@ page import ="java.sql.*" %>
    <form action="../custRepLogout.jsp" method="post">
        <input type="submit" value="Logout">
    </form>
    <form action="selectItem.jsp" method="post">
        <input type="submit" value="Back">
    </form>

    <h1>Modify Aircrafts Data</h1>

    <h2>Add Aircraft</h2>
    <form action="aircraftModify.jsp" method="post">
        Aircraft ID: <input type="text" name="newAircraftId" maxlength="5"><br>
        Number of Seats: <input type="number" name="newSeats"><br>
        <button type="submit" name="action" value="add">Add Aircraft</button>
    </form>

    <h2>Edit Aircraft</h2>
    <form action="aircraftModify.jsp" method="post">
        Aircraft ID: <input type="text" name="editAircraftId" maxlength="5"><br>
        New Number of Seats: <input type="number" name="editSeats"><br>
        <button type="submit" name="action" value="edit">Update Number of Seats</button>
    </form>

    <h2>Delete Aircraft</h2>
    <form action="aircraftModify.jsp" method="post">
        Aircraft ID: <input type="text" name="deleteAircraftId" maxlength="5"><br>
        <button type="submit" name="action" value="delete">Delete Aircraft</button>
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
                String aircraftId = "";
                int seats = 0;

                switch (action) {
                    case "add":
                        aircraftId = request.getParameter("newAircraftId");
                        seats = Integer.parseInt(request.getParameter("newSeats"));
                        pstmt = conn.prepareStatement("INSERT INTO aircraft (aircraft_id, num_seats) VALUES (?, ?)");
                        pstmt.setString(1, aircraftId);
                        pstmt.setInt(2, seats);
                        try {
                            pstmt.executeUpdate();
                            message = "Aircraft added successfully!";
                        } catch (SQLException e) {
                            message = "Aircraft already exists!";
                        }
                        break;

                    case "edit":
                        aircraftId = request.getParameter("editAircraftId");
                        seats = Integer.parseInt(request.getParameter("editSeats"));
                        pstmt = conn.prepareStatement("UPDATE aircraft SET num_seats = ? WHERE aircraft_id = ?");
                        pstmt.setInt(1, seats);
                        pstmt.setString(2, aircraftId);
                        int rowsUpdated = pstmt.executeUpdate();
                        if (rowsUpdated > 0) {
                            message = "Number of seats updated successfully!";
                        } else {
                            message = "Aircraft does not exist!";
                        }
                        break;

                    case "delete":
                        aircraftId = request.getParameter("deleteAircraftId");
                        pstmt = conn.prepareStatement("DELETE FROM aircraft WHERE aircraft_id = ?");
                        pstmt.setString(1, aircraftId);
                        int rowsDeleted = pstmt.executeUpdate();
                        if (rowsDeleted > 0) {
                            message = "Aircraft deleted successfully!";
                        } else {
                            message = "Aircraft does not exist!";
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