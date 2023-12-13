<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import = "com.air.*" import="java.util.*" import="java.time.*" 
    import="java.time.format.DateTimeFormatter" import="java.sql.*" import="java.sql.Date"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Confirmation Page</title>
</head>
<body>

<%
if ((session.getAttribute("user") == null)) {
%>
	You are not logged in<br/>
	<a href="../Login/landing.jsp">Please Login</a>
<%}
else {%>
		Welcome <%= session.getAttribute("user")%>
		<a href='custLogout.jsp'><button>Logout</button></a>
		<a href='flightSearch.jsp'><button>Back</button></a>
<%  
 String fname = request.getParameter("firstName");
 String lname = request.getParameter("lastName");
 String flightNum = (String)session.getAttribute("flightNum");
 String username = (String)session.getAttribute("user");
 
 ZoneId estZone = ZoneId.of("America/New_York");
 ZonedDateTime currentDateTimeInEST = ZonedDateTime.now(estZone);
 LocalDate currentDateInEST = currentDateTimeInEST.toLocalDate();
 LocalTime currentTimeInEST = currentDateTimeInEST.toLocalTime();
 DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
 DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("HH:mm:ss");
 String formattedDate = currentDateInEST.format(dateFormatter);
 String formattedTime = currentTimeInEST.format(timeFormatter);
 //int maxSeats = 0;
 List<Flight> flights = (List<Flight>) session.getAttribute("flightList");
 
 if(!flights.isEmpty()){
	for(Flight flight: flights){
		if(flightNum != null && flight.getFlightNum() == Integer.parseInt(flightNum)){
			if(!flight.isFull()){
				
				Customer customer = new Customer(DataManager.getInstance().getCusID(), username, fname, lname);
				int seatNum = flight.getAc().getNum_seats();
				flight.getAc().setNum_seats(--seatNum);
				if(flight.getAc().getNum_seats() <= 0){
					flight.setFull(true);
				}
				Ticket ticket = new Ticket(seatNum, flight, flight.getCabinClass(), customer, 
						flight.getPrice() + 150, formattedDate,formattedTime);
				customer.getFlightTickets().add(ticket);
				//ticket.setTicketNum(DataManager.getInstance().getTicketNum());
				
				String insertQuery = "INSERT INTO ticket (username, from_airport, to_airport, from_date, from_time, " +
	                    "airline_id, aircraft_id, flight_num, seat_num, class, f_Name, l_Name, " +
	                    "total_fare, p_date, p_time, num_stops) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
				try(java.sql.Connection connection = new ApplicationDB().getConnection()){
					try (PreparedStatement preparedStatement = connection.prepareStatement(insertQuery)) {
						preparedStatement.setString(1, username);
		                preparedStatement.setString(2, flight.getFromAirport());
		                preparedStatement.setString(3, flight.getToAirport());
		                preparedStatement.setDate(4, Date.valueOf(flight.getFromDate()));
		                preparedStatement.setTime(5, Time.valueOf(flight.getFromTime()));
		                preparedStatement.setString(6, flight.getAirlineId());
		                preparedStatement.setString(7, flight.getAircraftId());
		                preparedStatement.setInt(8, flight.getFlightNum());
		                preparedStatement.setInt(9, ticket.getSeatNum());
		                preparedStatement.setString(10, flight.getCabinClass());
		                preparedStatement.setString(11, customer.getFirstName());
		                preparedStatement.setString(12, customer.getLastName());
		                //preparedStatement.setInt(13, ticket.getTicketNum());
		                preparedStatement.setFloat(13, ticket.getTotalFare());
		                preparedStatement.setDate(14, Date.valueOf(ticket.getPurchaseDate()));
		                preparedStatement.setTime(15, Time.valueOf(ticket.getPurchaseTime()));
		                preparedStatement.setObject(16, flight.getNumStops());
		                int rowsAffected = preparedStatement.executeUpdate();
		                System.out.println(rowsAffected + " row(s) inserted successfully.");
		                if(rowsAffected > 0){
		                	//ticket.setTicketNum(DataManager.getInstance().getTicketNum());
		                	String query = "Select id_num from ticket where flight_num = '" + flightNum +"'";
		                	try(PreparedStatement stmt = connection.prepareStatement(query)){
		                		try(ResultSet rs = stmt.executeQuery()){
		                			int ticketNum = 0;
		                			while(rs.next()){
		                				ticketNum = rs.getInt("flight_num");
		                			}
		                			out.println("<p style= 'color: green;'>"+"Ticket has been created: have this for your reference:</p>" + ticketNum);
		                			ticket.setTicketNum(ticketNum);
		                		}
		                	}
		                }
					}
				}catch(SQLException e){
					e.printStackTrace();
				}
			}
			else{
				out.println("<p style= 'color: red;'>" + "Sorry Flight is Full! You have been added to waitlist" + "</p>");
				boolean exists = false;
				try (java.sql.Connection connection = new ApplicationDB().getConnection()) {
					String sql = "SELECT COUNT(*) FROM waitlist WHERE username = ? and flight_num = ? and f_name = ? and l_name = ?";
					try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
					    preparedStatement.setString(1, username);
					    preparedStatement.setString(2, flightNum);
					    preparedStatement.setString(3, fname);
					    preparedStatement.setString(4, lname);
					    try (ResultSet resultSet = preparedStatement.executeQuery()) {
					        if (resultSet.next()) {
					            int count = resultSet.getInt(1); // Get the count value
					            System.out.println("Count: " + count);
					            if (count > 0) {
					                exists = true; // The row exists if count > 0
					            }
					        }
					    }
					}
			        if(exists == false){
						String sql1 = "INSERT INTO waitlist (username, flight_num, f_name, l_name) VALUES (?, ?, ?, ?)";
						try (PreparedStatement preparedStatement = connection.prepareStatement(sql1)) {
			                // Set parameters for the SQL statement
			                preparedStatement.setString(1, username);
			                preparedStatement.setInt(2, flight.getFlightNum());
							preparedStatement.setString(3, fname);
							preparedStatement.setString(4, lname);
			                // Execute the SQL statement
			                int rowsAffected = preparedStatement.executeUpdate();
			                System.out.println(rowsAffected + " row(s) inserted into waitlist table.");
			            }
			        }
			        else{
			        	out.println("<p style= 'color: green;'>" + "Username already exists in the waitlist table.</p>");
			        }
		        } catch (SQLException e) {
		            e.printStackTrace();
		        }
			}
		}
	 }
  }else{
		out.println("Something went wrong !!!");
  }
}
%>
</body>
</html>
