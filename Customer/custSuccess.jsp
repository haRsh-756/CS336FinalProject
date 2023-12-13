<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.air.*" import="java.util.*" import="java.sql.*"%>
<%
/**
 @author harsh_patel, saad_farghani, hieu_nguyen
*/
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Success Page</title>
</head>
<body>
    <%
    if ((session.getAttribute("user") == null)) {
    %>
        You are not logged in<br/>
        <a href="custLogin.jsp">Please Login</a>
    <%} else {
        String username = (String) session.getAttribute("user");
    %>
        Welcome <%= username %><br/>
        <a href='custLogout.jsp'><button>Logout</button></a>
        <a href='flightSearch.jsp'><button>Flight Search</button></a>
        <a href='TicketHistory/reservationDisplay.jsp'><button>Reservations</button></a>
        <a href='Support/qnaSearch.jsp'><button>Support</button></a>
        <br/>

        <%
        java.sql.Connection connection = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            connection = new ApplicationDB().getConnection();
            String waitlistQuery = "SELECT flight_num FROM waitlist WHERE username = ?";
            pstmt = connection.prepareStatement(waitlistQuery);
            pstmt.setString(1, username);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                int flightNum = rs.getInt("flight_num");

                String ticketCountQuery = "SELECT COUNT(*) as ticket_count FROM ticket WHERE flight_num = ?";
                PreparedStatement pstmtTicketCount = connection.prepareStatement(ticketCountQuery);
                pstmtTicketCount.setInt(1, flightNum);
                ResultSet rsTicketCount = pstmtTicketCount.executeQuery();

                int ticketCount = 0;
                if (rsTicketCount.next()) {
                    ticketCount = rsTicketCount.getInt("ticket_count");
                }
                rsTicketCount.close();
                pstmtTicketCount.close();

                String seatsQuery = "SELECT num_seats FROM aircraft WHERE aircraft_id = (SELECT aircraft_id FROM flights WHERE flight_num = ?)";
                PreparedStatement pstmtSeats = connection.prepareStatement(seatsQuery);
                pstmtSeats.setInt(1, flightNum);
                ResultSet rsSeats = pstmtSeats.executeQuery();

                int numSeats = 0;
                if (rsSeats.next()) {
                    numSeats = rsSeats.getInt("num_seats");
                }
                rsSeats.close();
                pstmtSeats.close();

                if (ticketCount < numSeats) {
                    out.println("Waitlist Opening for flight: " + flightNum + "! ");
                    out.println("<a href='waitListBook.jsp?flightNum=" + flightNum + "'><button>Book Now</button></a><br/>");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (connection != null) try { connection.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }
    %>
</body>
</html>