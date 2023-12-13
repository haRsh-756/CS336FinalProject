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
	<a href="../login.jsp">Please Login</a>
<%}
else {%>
		Welcome <%= session.getAttribute("user")%>
		<a href='displayFlights.jsp'><button>Logout</button></a>
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
 
 List<Flight> flights = (List<Flight>) session.getAttribute("flightList");
 if(!flights.isEmpty()){
	for(Flight flight: flights){
		if(flightNum != null && flight.getFlightNum() == Integer.parseInt(flightNum)){
			if(!flight.isFull()){
				Customer customer = new Customer(DataManager.getInstance().getCusID(), username, fname, lname);
				Ticket ticket = new Ticket((new Random().nextInt(20))+1 , flight, flight.getCabinClass(), customer, 
						flight.getPrice() + 150, formattedDate,formattedTime);
				customer.getFlightTickets().add(ticket);
				
				String insertQuery = "INSERT INTO ticket (username, from_airport, to_airport, from_date, from_time, " +
	                    "airline_id, aircraft_id, flight_num, seat_num, class, f_Name, l_Name, id_num, " +
	                    "total_fare, p_date, p_time, num_stops) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
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
		                preparedStatement.setInt(13, customer.getCustomerID());
		                preparedStatement.setFloat(14, ticket.getTotalFare());
		                preparedStatement.setDate(15, Date.valueOf(ticket.getPurchaseDate()));
		                preparedStatement.setTime(16, Time.valueOf(ticket.getPurchaseTime()));
		                preparedStatement.setObject(17, flight.getNumStops());
		                int rowsAffected = preparedStatement.executeUpdate();
		                System.out.println(rowsAffected + " row(s) inserted successfully.");
		                if(rowsAffected > 0){
		                	ticket.setTicketNum(DataManager.getInstance().getTicketNum());
		                	out.println("Ticket has been created: have this for your reference: " + ticket.getTicketNum());
		                	
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
					String sql = "SELECT COUNT(*) FROM waitlist WHERE username = ? and flight_num = ?";
			        try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
			            preparedStatement.setString(1, username);
			            preparedStatement.setString(2, flightNum);
			            try (ResultSet resultSet = preparedStatement.executeQuery()) {
			                if (resultSet.next()) {
			                    int count = resultSet.getInt(1);
			                    exists = true;
			                }
			            }
			        }
			        if(exists == false){
						String sql1 = "INSERT INTO waitlist (username, flight_num) VALUES (?, ?)";
						try (PreparedStatement preparedStatement = connection.prepareStatement(sql1)) {
			                // Set parameters for the SQL statement
			                preparedStatement.setString(1, username);
			                preparedStatement.setInt(2, flight.getFlightNum());
	
			                // Execute the SQL statement
			                int rowsAffected = preparedStatement.executeUpdate();
			                System.out.println(rowsAffected + " row(s) inserted into waitlist table.");
			            }
			        }
			        else{
			        	out.println("<p style= 'color: green;'>" + "Username already exists in the waitlist table.");
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