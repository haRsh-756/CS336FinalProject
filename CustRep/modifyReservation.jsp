<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.air.*" import="java.util.*" import="java.sql.*"%>
<html>
<head>
    <meta charset="UTF-8">
    <title>Modify Reservation Data</title>
    <!-- Add any CSS or JS here if needed -->
</head>
<body>
<%@ page import ="java.sql.*" %>
    <form action="custRepLogout.jsp" method="post">
        <input type="submit" value="Logout">
    </form>
    <form action="custRepSuccess.jsp" method="post">
        <input type="submit" value="Back">
    </form>

    <h1>Modify Reservation Data</h1>

	<h2>Check Seats of Flight</h2>
	<form action="modifyReservation.jsp" method="post">
	    Flight Number: <input type="number" name="checkFlightNum"><br>
	    <button type="submit" name="action" value="checkSeats">Check Seats</button>
	</form>


    <h2>Create Customer Reservation</h2>
    <form action="modifyReservation.jsp" method="post">
        Username: <input type="text" name="username"><br>
        Flight Number: <input type="number" name="flightNum"><br>
        Class: <select name="class">
            <option value="Economy">Economy</option>
            <option value="Business">Business</option>
            <option value="First Class">First Class</option>
        </select><br>
        First Name: <input type="text" name="fName"><br>
        Last Name: <input type="text" name="lName"><br>
        Seat Number: <input type="number" name="seatNum"><br>
        <button type="submit" name="action" value="create">Create Reservation</button>
    </form>

    <h2>Edit Customer Reservation</h2>
	<form action="modifyReservation.jsp" method="post" id="editForm">
	    Ticket Number: <input type="number" name="ticketNum"><br>
	    Change Option: <select name="changeOption" id="changeOption" onchange="updateInputField()">
	        <option value="First Name">First Name</option>
	        <option value="Last Name">Last Name</option>
	        <option value="Class">Class</option>
	    </select><br>
	    <div id="newValueInput">
	        <!-- This will be filled based on JavaScript -->
	    </div>
	    <button type="submit" name="action" value="edit">Update Reservation</button>
	</form>
	
	<script>
	function updateInputField() {
	    var changeOption = document.getElementById('changeOption').value;
	    var inputDiv = document.getElementById('newValueInput');
	    if (changeOption === 'Class') {
	        inputDiv.innerHTML = 'Class: <select name="newValue"><option value="Economy">Economy</option><option value="Business">Business</option><option value="First Class">First Class</option></select><br>';
	    } else {
	        inputDiv.innerHTML = 'New Value: <input type="text" name="newValue"><br>';
	    }
	}
	window.onload = updateInputField; // Update on load
	</script>

    <% 
	    ApplicationDB db = new ApplicationDB();
		Connection conn = db.getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String message = "";

        try {
            Class.forName("com.mysql.jdbc.Driver");
            

            String action = request.getParameter("action");
            if ("create".equals(action)) {
                String username = request.getParameter("username");
                int flightNum = Integer.parseInt(request.getParameter("flightNum"));
                String classType = request.getParameter("class");
                String fName = request.getParameter("fName");
                String lName = request.getParameter("lName");
                int seatNum = Integer.parseInt(request.getParameter("seatNum"));

                // Fetch flight details from the flights table
                String flightQuery = "SELECT * FROM flights WHERE flight_num = ?";
                pstmt = conn.prepareStatement(flightQuery);
                pstmt.setInt(1, flightNum);
                rs = pstmt.executeQuery();

                if (rs.next()) {
                    // Assuming fare is directly available in the flights table
                    float fare = rs.getFloat(classType.toLowerCase().substring(0, 3) + "_price");
                    String fromAirport = rs.getString("from_airport");
                    String toAirport = rs.getString("to_airport");
                    String airlineId = rs.getString("airline_id");
                    String aircraftId = rs.getString("aircraft_id");
                    java.sql.Date fromDate = rs.getDate("from_date");
                    Time fromTime = rs.getTime("from_time");
                    int numStops = rs.getInt("num_stops");
                    java.sql.Date currentDate = new java.sql.Date(System.currentTimeMillis());
                    java.sql.Time currentTime = new java.sql.Time(System.currentTimeMillis());


                    // Create a new reservation in the ticket table
                    String insertTicket = "INSERT INTO ticket (username, from_airport, to_airport, from_date, from_time, airline_id, aircraft_id, flight_num, seat_num, class, f_Name, l_Name, total_fare, p_date, p_time, num_stops) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			        pstmt = conn.prepareStatement(insertTicket);
			        pstmt.setString(1, username);
			        pstmt.setString(2, fromAirport);
			        pstmt.setString(3, toAirport);
			        pstmt.setDate(4, fromDate);
			        pstmt.setTime(5, fromTime);
			        pstmt.setString(6, airlineId);
			        pstmt.setString(7, aircraftId);
			        pstmt.setInt(8, flightNum);
			        pstmt.setInt(9, seatNum);
			        pstmt.setString(10, classType);
			        pstmt.setString(11, fName);
			        pstmt.setString(12, lName);
			        pstmt.setFloat(13, fare + 150);
			        pstmt.setDate(14, currentDate); // Setting current date
			        pstmt.setTime(15, currentTime); // Setting current time
			        pstmt.setInt(16, numStops);

                    int result = pstmt.executeUpdate();
                    if (result > 0) {
                        message = "Reservation created successfully!";
                    } else {
                        message = "Failed to create reservation.";
                    }
                    
                } else {
                    message = "Flight not found.";
                }
                
            } else if ("edit".equals(action)) {
                int ticketNum = Integer.parseInt(request.getParameter("ticketNum"));
                String changeOption = request.getParameter("changeOption");
                String newValue = request.getParameter("newValue");

                if ("Class".equals(changeOption)) {
                    // First, fetch the new fare
                    String fareQuery = "SELECT " + newValue.toLowerCase().substring(0, 3) + "_price FROM flights WHERE flight_num = (SELECT flight_num FROM ticket WHERE id_num = ?)";
                    pstmt = conn.prepareStatement(fareQuery);
                    pstmt.setInt(1, ticketNum);
                    rs = pstmt.executeQuery();
                    float newFare = 0;
                    if (rs.next()) {
                        newFare = rs.getFloat(1) + 150; // Adding 150 as per your requirement
                    }
                    rs.close();
                    pstmt.close();

                    // Then, update the ticket
                    String updateQuery = "UPDATE ticket SET class = ?, total_fare = ? WHERE id_num = ?";
                    pstmt = conn.prepareStatement(updateQuery);
                    pstmt.setString(1, newValue);
                    pstmt.setFloat(2, newFare);
                    pstmt.setInt(3, ticketNum);
                } else {
                    // For other change options (First Name, Last Name)
                    String updateQuery = "UPDATE ticket SET ";
                    if ("First Name".equals(changeOption)) {
                        updateQuery += "f_Name = ? WHERE id_num = ?";
                    } else if ("Last Name".equals(changeOption)) {
                        updateQuery += "l_Name = ? WHERE id_num = ?";
                    }
                    pstmt = conn.prepareStatement(updateQuery);
                    pstmt.setString(1, newValue);
                    pstmt.setInt(2, ticketNum);
                }

                int result = pstmt.executeUpdate();
                if (result > 0) {
                    message = "Reservation updated successfully!";
                } else {
                    message = "Failed to update reservation or reservation not found.";
                }
                pstmt.close();
            } else if ("checkSeats".equals(action)) {
                int checkFlightNum = Integer.parseInt(request.getParameter("checkFlightNum"));

                // Get the seating capacity of the aircraft
                String capacityQuery = "SELECT num_seats FROM aircraft WHERE aircraft_id = (SELECT aircraft_id FROM flights WHERE flight_num = ?)";
                pstmt = conn.prepareStatement(capacityQuery);
                pstmt.setInt(1, checkFlightNum);
                rs = pstmt.executeQuery();
                int seatCapacity = 0;
                if (rs.next()) {
                    seatCapacity = rs.getInt("num_seats");
                }

                // Get the taken seats for the flight
                String takenSeatsQuery = "SELECT seat_num FROM ticket WHERE flight_num = ?";
                pstmt = conn.prepareStatement(takenSeatsQuery);
                pstmt.setInt(1, checkFlightNum);
                rs = pstmt.executeQuery();
                List<Integer> takenSeats = new ArrayList<>();
                while (rs.next()) {
                    takenSeats.add(rs.getInt("seat_num"));
                }

                message = "Seat Capacity: " + seatCapacity + "<br>Taken Seats: " + takenSeats.toString();
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