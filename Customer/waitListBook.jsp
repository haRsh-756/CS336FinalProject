<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.air.*" import="java.util.*" import="java.sql.*"%>
<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>Waitlist Booking for Flight</title>
<script type="text/javascript">
    function disableButton(btn){
        btn.disabled = true;
        btn.form.submit();
    }
</script>
</head>
<body>
    <% 
    String user = (String) session.getAttribute("user");
    int flightNum = Integer.parseInt(request.getParameter("flightNum"));
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    String message = "";
    try {
        conn = new ApplicationDB().getConnection();
        
        // Fetch flight information
        String flightQuery = "SELECT * FROM flights WHERE flight_num = ?";
        pstmt = conn.prepareStatement(flightQuery);
        pstmt.setInt(1, flightNum);
        rs = pstmt.executeQuery();
        float ecoPrice = 0.0f, busPrice = 0.0f, firPrice = 0.0f;

        if (rs.next()) {
            %>
            <h1>Waitlist Booking for Flight: <%= flightNum %></h1>
            <h2>Flight Information</h2>
            Airline ID: <%= rs.getString("airline_id") %><br/>
            Aircraft ID: <%= rs.getString("aircraft_id") %><br/>
            From Airport: <%= rs.getString("from_airport") %><br/>
            From Date: <%= rs.getString("from_date") %><br/>
            From Time: <%= rs.getString("from_time") %><br/>
            To Airport: <%= rs.getString("to_airport") %><br/>
            To Date: <%= rs.getString("to_date") %><br/>
            To Time: <%= rs.getString("to_time") %><br/>
            Flight Type: <%= rs.getString("flight_type") %><br/>
            ecoPrice = Economy Price: <%= rs.getFloat("eco_price") %><br/>
            busPrice = Business Price: <%= rs.getFloat("bus_price") %><br/>
            firPrice = First Class Price: <%= rs.getFloat("fir_price") %><br/>
            <%
        }

        // Fetch logged name from waitlist
        String waitlistQuery = "SELECT f_name, l_name FROM waitlist WHERE username = ? AND flight_num = ?";
        pstmt = conn.prepareStatement(waitlistQuery);
        pstmt.setString(1, user);
        pstmt.setInt(2, flightNum);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            %>
            <h2>Logged Name</h2>
            First Name: <%= rs.getString("f_name") %><br/>
            Last Name: <%= rs.getString("l_name") %><br/>
            <%
        }

        // Class selection and ticket booking form
        %>
        <h2>Class Selection</h2>
        <form action="waitListBook.jsp?flightNum=<%= flightNum %>" method="post">
            Class: 
            <select name="class">
                <option value="Economy">Economy</option>
                <option value="Business">Business</option>
                <option value="First Class">First Class</option>
            </select><br/>
            <input type="submit" name="action" value="Book Ticket"/>
        </form>
        <%

        if ("Book Ticket".equals(request.getParameter("action"))) {
            String classType = request.getParameter("class");
            java.sql.Date currentDate = new java.sql.Date(System.currentTimeMillis());
            java.sql.Time currentTime = new java.sql.Time(System.currentTimeMillis());
            
            try {
                // Calculate next available seat number
                String seatQuery = "SELECT MAX(seat_num) as max_seat FROM ticket WHERE flight_num = ?";
                pstmt = conn.prepareStatement(seatQuery);
                pstmt.setInt(1, flightNum);
                rs = pstmt.executeQuery();
                int nextSeatNum = 1;
                if (rs.next()) {
                    nextSeatNum = rs.getInt("max_seat") + 1;
                }
                
                

                // Insert new ticket
                String insertTicket = "INSERT INTO ticket (username, from_airport, to_airport, from_date, from_time, airline_id, aircraft_id, flight_num, seat_num, class, f_Name, l_Name, total_fare, p_date, p_time, num_stops) SELECT ?, from_airport, to_airport, from_date, from_time, airline_id, aircraft_id, ?, ?, ?, f_name, l_name, ?, ?, ?, num_stops FROM flights, waitlist WHERE flights.flight_num = ? AND waitlist.username = ? AND waitlist.flight_num = ?";
		        pstmt = conn.prepareStatement(insertTicket);
		        pstmt.setString(1, user);
		        pstmt.setInt(2, flightNum);
		        pstmt.setInt(3, nextSeatNum);
		        pstmt.setString(4, classType);
		        float totalFare = classType.equals("Economy") ? ecoPrice : classType.equals("Business") ? busPrice : firPrice;
		        pstmt.setFloat(5, totalFare);
		        pstmt.setDate(6, currentDate);
		        pstmt.setTime(7, currentTime);
		        pstmt.setInt(8, flightNum);
		        pstmt.setString(9, user);
		        pstmt.setInt(10, flightNum);
		        int ticketResult = pstmt.executeUpdate();
                
                

                // Delete user from waitlist
                if (ticketResult > 0) {
                    String deleteWaitlist = "DELETE FROM waitlist WHERE username = ? AND flight_num = ?";
                    pstmt = conn.prepareStatement(deleteWaitlist);
                    pstmt.setString(1, user);
                    pstmt.setInt(2, flightNum);
                    pstmt.executeUpdate();


                    message = "Ticket booked successfully!";
                } else {
                    message = "Failed to book ticket.";
                }
            } catch (SQLException e) {
                e.printStackTrace();
                message = "Error occurred while booking ticket: " + e.getMessage();
            }
            
            out.println("<p>" + message + "</p>");
        }

    } catch (Exception e) {
        e.printStackTrace();
        out.println("<p>Error occurred: " + e.getMessage() + "</p>");
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
    %>
</body>
</html>