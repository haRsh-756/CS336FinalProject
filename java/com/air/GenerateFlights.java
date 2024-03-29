package com.air;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Time;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.sql.Date;

//import jakarta.servlet.http.HttpServlet;

public class GenerateFlights{
//	private Aircraft [] acs = {
//    		new Aircraft("AA101","08:00","EWR", "BOS", 120, 140, "BOS", "EWR", 120),
//    		new Aircraft("AA102", "09:00", "EWR", "PHL", 90, 160, "PHL", "EWR",90),
//    		new Aircraft("AA103","10:00","EWR","LGA", 105, 120, "LGA", "EWR", 105),
//    		new Aircraft("DA401","09:30","EWR", "JFK", 60, 150, "JFK", "EWR" , 60),
//    		new Aircraft("DA402", "10:45", "PHL", "BOS", 150, 180, "BOS", "PHL", 150),
//    		new Aircraft("DA403", "11:00", "PHL", "LGA", 100, 120, "LGA", "PHL", 100),
//    		new Aircraft("UA501", "11:15", "PHL", "JFK", 90, 150, "JFK", "PHL", 90),
//    		new Aircraft("UA502", "10:30", "BOS", "LGA", 110, 190, "LGA", "BOS",110),
//    		new Aircraft("UA503", "12:30", "BOS", "JFK", 120, 140, "JFK", "BOS",120),
//    		new Aircraft("SA431", "10:30", "LGA", "JFK", 60, 160, "JFK", "LGA", 60),
//    		
//    		new Aircraft("SA432", "07:00", "PHL", "EWR", 90, 120, new ArrayList<>(Arrays.asList(new Connection("EWR", "JFK", 60, 140),
//    				new Connection("JFK", "BOS",120, 150))), "BOS")
//    		new Aircraft("SA432", "07:00", "EWR", "FLL", 150, 140, new ArrayList<>(Arrays.asList(new Connection("FLL","ATL", 60, 130))),"ATL"),
//    		new Aircraft("SA433", "08:00", "BOS", "EWR", 90, 120, new ArrayList<>(Arrays.asList(
//    				new Connection("EWR", "FLL", 120, 60),
//    				new Connection("FLL", "ATL", 45, 170)) ), "ATL")
    		
//    		new Aircraft("SA432","08:45","EWR", "BOS", 120, 165, "BOS", "EWR", 120),
//    		new Aircraft("SA433", "09:15", "EWR", "PHL", 90, 200, "PHL", "EWR",90),
//    		new Aircraft("AA104","10:30","EWR","LGA", 105, 200, "LGA", "EWR", 105),
//    		new Aircraft("DA404","10:15","EWR", "JFK", 60, 170, "JFK", "EWR" , 60),
//    		new Aircraft("UA504", "11:30", "PHL", "BOS", 150, 160, "BOS", "PHL", 150),
//    		new Aircraft("SA434", "11:45", "PHL", "LGA", 100, 160, "LGA", "PHL", 100),
//    		new Aircraft("FA201", "12:15", "PHL", "JFK", 90, 175, "JFK", "PHL", 90),
//    		new Aircraft("FA202", "12:30", "BOS", "LGA", 110, 190, "LGA", "BOS",110),
//    		new Aircraft("FA203", "11:00", "BOS", "JFK", 120, 180, "JFK", "BOS",120),
//    		new Aircraft("FA204", "13:45", "LGA", "JFK", 60, 160, "JFK", "LGA", 60),
//    		
//    		//new Aircraft("SA435")
//    		new Aircraft("SA435","09:30", "EWR", "BOS", 120, 190, "BOS", "EWR", 120),
//    		new Aircraft("AA105", "07:00", "EWR", "PHL", 90, 250, "PHL", "EWR", 90)
  //  };
//	public Aircraft[] getAcs() {
//		return acs;
//	}
//
//	public void setAcs(Aircraft[] acs) {
//		this.acs = acs;
//	}
	//private List<Flight> flights;
	/*public List<Flight> generateFlightsWithFlex(List<Flight> fls) {
		List<Flight> flights = new ArrayList<>();
		Random random = new Random();
		float ecoPrice;
		float busPrice;
		float firPrice;
		String[] stringArray = {"One Way", "Round Trip"};
		for(Flight flight: fls) {
		
			List<String> flexDates = getFlexibleDates(flight.getFromDate(),3);
			for(String date: flexDates) {
				ecoPrice = random.nextInt(500) + 100;
				busPrice = ecoPrice * 1.5f;
				firPrice = busPrice * 1.5f;
				
				Flight ft = new Flight(flight);
				ft.setFromDate(date);
				ft.setToDate(date);
				ft.setEcoPrice(ecoPrice);
				ft.setFirPrice(firPrice);
				ft.setBusPrice(busPrice);
				ft.setFlightType(stringArray[random.nextInt(stringArray.length)]);
				ft.setIsDomestic(random.nextInt(2));
				ft.setFromTime(generateAndFormatRandomTime());
				ft.setToTime(generateAndFormatRandomTime());
				ft.setNumStops(random.nextInt(3));
				ft.setFlightNum(DataManager.getInstance().generateFlightNum());
				//ft.setFlightNum(flight.getFlightNum());
				flights.add(ft);
			}
			//flights.add(flight);
		}
		return flights;
		//DataManager.getInstance().setFlights(this.flights);
	}*/
	/**
	 * `airline_id` varchar(5) NOT NULL,
  `aircraft_id` varchar(5) NOT NULL,
  `from_airport` varchar(5) NOT NULL,
  `from_date` date NOT NULL,
  `from_time` time NOT NULL,
  `to_airport` varchar(5) NOT NULL,
  `to_date` date NOT NULL,
  `to_time` time NOT NULL,
  `is_domestic` tinyint(1) NOT NULL,
  `flight_num` int NOT NULL,
  `flight_type` varchar(20) NOT NULL,
  `num_stops` int NOT NULL,
  `eco_price` float NOT NULL,
  `bus_price` float NOT NULL,
  `fir_price` float NOT NULL,
	 * @param flights
	 */
	/*public void pushCopiesToDB(List<Flight> flights) {
		ApplicationDB db = new ApplicationDB();	
		java.sql.Connection connection = db.getConnection();
		String insertQuery = "INSERT INTO flights (airline_id, aircraft_id, from_airport, from_date, from_time, " +
                "to_airport, to_date, to_time, is_domestic, flight_num, flight_type, num_stops, " +
                "eco_price, bus_price, fir_price) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		try (PreparedStatement preparedStatement = connection.prepareStatement(insertQuery)) {
            // Iterating over the list of Flight objects
            for (Flight flight : flights) {
                // Setting parameters for the prepared statement
                preparedStatement.setString(1, flight.getAirlineId());
                preparedStatement.setString(2, flight.getAircraftId());
                preparedStatement.setString(3, flight.getFromAirport());
                preparedStatement.setDate(4, Date.valueOf(flight.getFromDate()));
                preparedStatement.setTime(5, Time.valueOf(flight.getFromTime()));
                preparedStatement.setString(6, flight.getToAirport());
                preparedStatement.setDate(7, Date.valueOf(flight.getToDate()));
                preparedStatement.setTime(8, Time.valueOf(flight.getToTime()));
                preparedStatement.setInt(9, flight.getIsDomestic());
                preparedStatement.setInt(10, flight.getFlightNum());
                preparedStatement.setString(11, flight.getFlightType());
                preparedStatement.setInt(12, flight.getNumStops());
                preparedStatement.setFloat(13, flight.getEcoPrice());
                preparedStatement.setFloat(14, flight.getBusPrice());
                preparedStatement.setFloat(15, flight.getFirPrice());

                // Executing the query to insert data
                int rowsAffected = preparedStatement.executeUpdate();

                // Checking the result
                if (rowsAffected > 0) {
                    System.out.println("Data for Flight " + flight.getFlightNum() + " inserted successfully!");
                } else {
                    System.out.println("Failed to insert data for Flight " + flight.getFlightNum());
                }

                // Clear parameters for the next iteration
                preparedStatement.clearParameters();
            }
        } catch (SQLException e) {
        	e.printStackTrace();
        }
		//String selectQuery = "SELECT * FROM flights";
	}*/
	public List<Flight> getFlightsFromDB(){
		
		String selectQuery = "SELECT * FROM flights";
		List<Flight> fls = new ArrayList<>();
		try (java.sql.Connection connection = new ApplicationDB().getConnection()){
			try(PreparedStatement preparedStatement = connection.prepareStatement(selectQuery)){
				try(ResultSet resultSet = preparedStatement.executeQuery()){
					while (resultSet.next()) {
						
						 String airlineId = resultSet.getString("airline_id");
					     String aircraftId = resultSet.getString("aircraft_id");
					     String fromAirport = resultSet.getString("from_airport");
					     String fromDate = resultSet.getString("from_date");
					     String fromTime = resultSet.getString("from_time");
					     String toAirport = resultSet.getString("to_airport");
					     String toDate = resultSet.getString("to_date");
					     String toTime = resultSet.getString("to_time");
					     int isDomestic = resultSet.getInt("is_domestic");
					     int flightNum = resultSet.getInt("flight_num");
					     String flightType = resultSet.getString("flight_type");
					     int numStops = resultSet.getInt("num_stops");
					     float ecoPrice = resultSet.getFloat("eco_price");
					     float busPrice = resultSet.getFloat("bus_price");
					     float firPrice = resultSet.getFloat("fir_price");
					     int maxSeats = 0;
					     String maxSeatsQuery = "SELECT num_seats FROM aircraft WHERE aircraft_id = ?";
			                try (PreparedStatement preparedStatement1 = connection.prepareStatement(maxSeatsQuery)) {
			                    preparedStatement1.setString(1, aircraftId);
			                    try (ResultSet rs = preparedStatement1.executeQuery()) {
			                        if (rs.next()) {
			                            maxSeats = rs.getInt("num_seats");
			                        }
			                    }
			                }

			                // Check if the flight is full
			                String ticketCountQuery = "SELECT COUNT(*) as ticket_count FROM ticket WHERE flight_num = ?";
			                boolean isFull = false;
			                try (PreparedStatement preparedStatement2 = connection.prepareStatement(ticketCountQuery)) {
			                    preparedStatement2.setInt(1, flightNum);
			                    try (ResultSet rs = preparedStatement2.executeQuery()) {
			                        if (rs.next() && rs.getInt("ticket_count") >= maxSeats) {
			                            isFull = true;
			                        }
			                    }
			                }
					     Flight ft = new Flight(airlineId,aircraftId, fromAirport, fromDate, fromTime, toAirport, toDate, toTime, 
					    		 isDomestic, flightNum, flightType, numStops, ecoPrice, busPrice, firPrice,isFull);
					     ft.setAc(new Aircraft(aircraftId, maxSeats));
					     fls.add(ft);
					   //create flight with flex dates through out the session and storing into dataManager class instance
					}
				}
			} //create flight with flex dates through out the session and storing into dataManager class instanc
		} catch (SQLException e) {
				e.printStackTrace();
		} 
		//fls = generateFlightsWithFlex(fls);
		//pushCopiesToDB(fls);
		//create flight with flex dates through out the session basically copies of flight with manually changing dates, time, numstops
		DataManager.getInstance().setFlights(fls);
        return fls;
	}
	public List<String> getFlexibleDates(String inputDate, int days) {
        List<String> flexibleDates = new ArrayList<>();
        //DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MM-dd-yyyy");
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        LocalDate startDate = LocalDate.parse(inputDate, formatter);
        
        ZoneId estZone = ZoneId.of("America/New_York");
        // Generate flexible dates for the specified range in EST
        for (int i = -days; i <= days; i++) {
            LocalDate currentDate = startDate.plusDays(i).atStartOfDay(estZone).toLocalDate();
            if (!currentDate.isBefore(LocalDate.now(estZone))) {
                flexibleDates.add(currentDate.format(formatter));
            }
        }
        return flexibleDates;
    }
	/*private String generateAndFormatRandomTime() {
        // Generate a random hour, minute, and second
        int hour = (int) (Math.random() * 24);
        int minute = (int) (Math.random() * 60);
        int second = (int) (Math.random() * 60);

        LocalTime randomTime = LocalTime.of(hour, minute, second);

        // Define a DateTimeFormatter for the desired time format
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm:ss");

        // Format the LocalTime to a string
        return randomTime.format(formatter);
    }*/
	public List<Flight> getFlights(String departureAirport, String arrivalAirport, String flightType, 
			String cabinClass, String departDate, String returnDate){
		List<Flight> fls = getFlightsFromDB();
		List<Flight> resultFlights = new ArrayList<>();
		if(fls != null) {
			for(Flight flight: fls) {
				if(flightType.equals("One Way") || flightType.equals("Round Trip")) {
					if( (flight.getFromAirport().equals(departureAirport) && flight.getToAirport().equals(arrivalAirport) 
							&& flight.getFromDate().equals(departDate) && flight.getFlightType().equals(flightType) )) {
						flight.setCabinClass(cabinClass);
						resultFlights.add(flight);
					}
					else if((flight.getToAirport().equals(departureAirport) && flight.getFromAirport().equals(arrivalAirport) && flight.getToDate().equals(departDate) && flight.getFlightType().equals(flightType)) ) {
						Flight ft = flight;
						ft.setFromAirport(departureAirport);
						ft.setToAirport(arrivalAirport);
						ft.setCabinClass(cabinClass);
						resultFlights.add(ft);
						//flight.setFromAirport(departureAirport);
						//flight.setToAirport(arrivalAirport);
					}
				}				
				else {
					if(flight.getFromAirport().equals(departureAirport) && flight.getToAirport().equals(arrivalAirport)){
						flight.setCabinClass(cabinClass);
						resultFlights.add(flight);
					}
					else if(flight.getToAirport().equals(departureAirport) && flight.getFromAirport().equals(arrivalAirport)){
						Flight ft = flight;
						ft.setFromAirport(departureAirport);
						ft.setToAirport(arrivalAirport);
						ft.setCabinClass(cabinClass);
						resultFlights.add(ft);
					}
				}
			}
		}
		return resultFlights;
	}
	public List<Flight> filterFlights(String maxPrice, String maxStops, String airline, String takeOffTime, String landingTime, String fromAirport, String toAirport,
                                          String flightType, String cabinClass, String departDate, String returnDate){
		System.out.println(fromAirport + " to " + toAirport);
		if("flexibleOneWay".equals(flightType)) {
			flightType = "One Way";
		}
		else if("flexibleRound".equals(flightType)) {
			flightType = "Round Trip";
		}
		List<Flight> filteredFlights = new ArrayList<>();
		try(java.sql.Connection connection = new ApplicationDB().getConnection()){
			StringBuilder sql = new StringBuilder("SELECT * FROM flights WHERE 1=1");
			if (isNotEmpty(maxPrice)) {
		        sql.append(" AND (eco_price <= ? OR bus_price <= ? OR fir_price <= ?)");
		    }
		    if (isNotEmpty(maxStops)) {
		        sql.append(" AND num_stops <= ?");
		    }
		    if (isNotEmpty(airline)) {
		        sql.append(" AND airline_id = ?");
		    }
		    if (isNotEmpty(takeOffTime)) {
		        sql.append(" AND HOUR(from_time) >= ?");
		    }
		    if (isNotEmpty(landingTime)) {
		        sql.append(" AND HOUR(to_time) <= ?");
		    }
		    if (isNotEmpty(fromAirport)) {
		        sql.append(" AND from_airport = ?");
		    }
		    if (isNotEmpty(toAirport)) {
		        sql.append(" AND to_airport = ?");
		    }
		    if (isNotEmpty(flightType)) {
		        sql.append(" AND flight_type = ?");
		    }
		    if (isNotEmpty(departDate)) {
		        sql.append(" AND from_date >= ?");
		    }
		    if (isNotEmpty(returnDate)) {
		        sql.append(" AND to_date <= ?");
		    }
		    try (PreparedStatement preparedStatement = connection.prepareStatement(sql.toString())) {
				// Set parameters for the SQL statement

				int parameterIndex = 1;
		        if (isNotEmpty(maxPrice)) {
		            //preparedStatement.setFloat(parameterIndex++, Float.parseFloat(maxPrice));
		        	float maxPriceValue = Float.parseFloat(maxPrice);
		            preparedStatement.setFloat(parameterIndex++, maxPriceValue);
		            preparedStatement.setFloat(parameterIndex++, maxPriceValue);  // for bus_price
		            preparedStatement.setFloat(parameterIndex++, maxPriceValue);
		        }
		        if (isNotEmpty(maxStops)) {
		            preparedStatement.setInt(parameterIndex++, Integer.parseInt(maxStops));
		        }
		        if (isNotEmpty(airline)) {
		            preparedStatement.setString(parameterIndex++, airline);
		        }
		        if (isNotEmpty(takeOffTime)) {
		        	//int takeOffHourValue = Integer.parseInt(takeOffTime);
		            //preparedStatement.setInt(parameterIndex++, takeOffHourValue);
		        	
		            //preparedStatement.setString(parameterIndex++, takeOffTime);
		        	
		        	int takeOffHour = parseHour(takeOffTime);
		            preparedStatement.setInt(parameterIndex++, takeOffHour);
		        }
		        if (isNotEmpty(landingTime)) {
		            //preparedStatement.setString(parameterIndex, landingTime);
		        	//int landingHourValue = Integer.parseInt(landingTime);
		            //preparedStatement.setInt(parameterIndex, landingHourValue);
		        	int landingHour = parseHour(landingTime);
		            preparedStatement.setInt(parameterIndex++, landingHour);
		        }
		        if (isNotEmpty(fromAirport)) {
		            preparedStatement.setString(parameterIndex++, fromAirport);
		        }
		        if (isNotEmpty(toAirport)) {
		            preparedStatement.setString(parameterIndex++, toAirport);
		        }
		        if (isNotEmpty(flightType)) {
		            preparedStatement.setString(parameterIndex++, flightType);
		        }
		        if (isNotEmpty(departDate)) {
		        	java.sql.Date departDateValue = java.sql.Date.valueOf(departDate);
		            preparedStatement.setDate(parameterIndex++, departDateValue);
		        }
		        if (isNotEmpty(returnDate)) {
		        	java.sql.Date returnDateValue = java.sql.Date.valueOf(returnDate);
		            preparedStatement.setDate(parameterIndex, returnDateValue);
		        }
		        try (ResultSet resultSet = preparedStatement.executeQuery()) {
		            // Process the result set and populate the list of filtered flights
		            while (resultSet.next()) {
		                //Flight flight = new Flight();
		                //flight.setFlightNum(resultSet.getInt("flight_num"));
		                // Set other properties as needed
		                //filteredFlights.add(flight);
		            	 String airlineId = resultSet.getString("airline_id");
					     String aircraftId = resultSet.getString("aircraft_id");
					     fromAirport = resultSet.getString("from_airport");
					     String fromDate = resultSet.getString("from_date");
					     String fromTime = resultSet.getString("from_time");
					     toAirport = resultSet.getString("to_airport");
					     String toDate = resultSet.getString("to_date");
					     String toTime = resultSet.getString("to_time");
					     int isDomestic = resultSet.getInt("is_domestic");
					     int flightNum = resultSet.getInt("flight_num");
					     flightType = resultSet.getString("flight_type");
					     int numStops = resultSet.getInt("num_stops");
					     float ecoPrice = resultSet.getFloat("eco_price");
					     float busPrice = resultSet.getFloat("bus_price");
					     float firPrice = resultSet.getFloat("fir_price");
					     int maxSeats = 0;
					     
					     //System.out.println(ft.toString());
					     String maxSeatsQuery = "SELECT num_seats FROM aircraft WHERE aircraft_id = ?";
			                try (PreparedStatement preparedStatement1 = connection.prepareStatement(maxSeatsQuery)) {
			                    preparedStatement1.setString(1, aircraftId);
			                    try (ResultSet rs = preparedStatement1.executeQuery()) {
			                        if (rs.next()) {
			                            maxSeats = rs.getInt("num_seats");
			                        }
			                    }
			                }

			                // Check if the flight is full
		                String ticketCountQuery = "SELECT COUNT(*) as ticket_count FROM ticket WHERE flight_num = ?";
		                boolean isFull = false;
		                try (PreparedStatement preparedStatement2 = connection.prepareStatement(ticketCountQuery)) {
		                    preparedStatement2.setInt(1, flightNum);
		                    try (ResultSet rs = preparedStatement2.executeQuery()) {
		                        if (rs.next() && rs.getInt("ticket_count") >= maxSeats) {
		                            isFull = true;
		                        }
		                    }
		                }
					     Flight ft = new Flight(airlineId,aircraftId, fromAirport, fromDate, fromTime, toAirport, toDate, toTime, 
					    		 isDomestic, flightNum, flightType, numStops, ecoPrice, busPrice, firPrice,isFull);
					     ft.setAc(new Aircraft(aircraftId, maxSeats));
					     ft.setCabinClass(cabinClass);
					     filteredFlights.add(ft);
					     System.out.println(ft.toString());
		            }
		        }
		    }
		    
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return filteredFlights;
	}
	public List<Flight> filterFlights(String maxPrice, String maxStops, String airline,
        String takeOffTime, String landingTime) throws SQLException {
		List<Flight> filteredFlights = new ArrayList<>();
		
		// SQL query to filter flights based on criteria		
		try (java.sql.Connection connection = new ApplicationDB().getConnection()) {
			StringBuilder sql = new StringBuilder("SELECT * FROM flights WHERE 1=1");

			if (isNotEmpty(maxPrice)) {
		        //sql.append(" AND eco_price <= ?");
		        sql.append(" AND (eco_price <= ? OR bus_price <= ? OR fir_price <= ?)");
		    }
		    if (isNotEmpty(maxStops)) {
		        sql.append(" AND num_stops <= ?");
		    }
		    if (isNotEmpty(airline)) {
		        sql.append(" AND airline_id = ?");
		    }
		    if (isNotEmpty(takeOffTime)) {
		        //sql.append(" AND from_time >= ?");
		    	sql.append(" AND HOUR(from_time) >= ?");
		    }
		    if (isNotEmpty(landingTime)) {
		        //sql.append(" AND to_time <= ?");
		    	sql.append(" AND HOUR(to_time) <= ?");
		    }
			try (PreparedStatement preparedStatement = connection.prepareStatement(sql.toString())) {
				// Set parameters for the SQL statement

				int parameterIndex = 1;
		        if (isNotEmpty(maxPrice)) {
		            //preparedStatement.setFloat(parameterIndex++, Float.parseFloat(maxPrice));
		        	float maxPriceValue = Float.parseFloat(maxPrice);
		            preparedStatement.setFloat(parameterIndex++, maxPriceValue);
		            preparedStatement.setFloat(parameterIndex++, maxPriceValue);  // for bus_price
		            preparedStatement.setFloat(parameterIndex++, maxPriceValue);
		        }
		        if (isNotEmpty(maxStops)) {
		            preparedStatement.setInt(parameterIndex++, Integer.parseInt(maxStops));
		        }
		        if (isNotEmpty(airline)) {
		            preparedStatement.setString(parameterIndex++, airline);
		        }
		        if (isNotEmpty(takeOffTime)) {
		        	//int takeOffHourValue = Integer.parseInt(takeOffTime);
		            //preparedStatement.setInt(parameterIndex++, takeOffHourValue);
		        	
		            //preparedStatement.setString(parameterIndex++, takeOffTime);
		        	
		        	int takeOffHour = parseHour(takeOffTime);
		            preparedStatement.setInt(parameterIndex++, takeOffHour);
		        }
		        if (isNotEmpty(landingTime)) {
		            //preparedStatement.setString(parameterIndex, landingTime);
		        	//int landingHourValue = Integer.parseInt(landingTime);
		            //preparedStatement.setInt(parameterIndex, landingHourValue);
		        	int landingHour = parseHour(landingTime);
		            preparedStatement.setInt(parameterIndex, landingHour);
		        }
				
				// Execute the SQL statement
		        try (ResultSet resultSet = preparedStatement.executeQuery()) {
		            // Process the result set and populate the list of filtered flights
		            while (resultSet.next()) {
		                //Flight flight = new Flight();
		                //flight.setFlightNum(resultSet.getInt("flight_num"));
		                // Set other properties as needed
		                //filteredFlights.add(flight);
		            	 String airlineId = resultSet.getString("airline_id");
					     String aircraftId = resultSet.getString("aircraft_id");
					     String fromAirport = resultSet.getString("from_airport");
					     String fromDate = resultSet.getString("from_date");
					     String fromTime = resultSet.getString("from_time");
					     String toAirport = resultSet.getString("to_airport");
					     String toDate = resultSet.getString("to_date");
					     String toTime = resultSet.getString("to_time");
					     int isDomestic = resultSet.getInt("is_domestic");
					     int flightNum = resultSet.getInt("flight_num");
					     String flightType = resultSet.getString("flight_type");
					     int numStops = resultSet.getInt("num_stops");
					     float ecoPrice = resultSet.getFloat("eco_price");
					     float busPrice = resultSet.getFloat("bus_price");
					     float firPrice = resultSet.getFloat("fir_price");
					     int maxSeats = 0;
					     
					     //System.out.println(ft.toString());
					     String maxSeatsQuery = "SELECT num_seats FROM aircraft WHERE aircraft_id = ?";
			                try (PreparedStatement preparedStatement1 = connection.prepareStatement(maxSeatsQuery)) {
			                    preparedStatement1.setString(1, aircraftId);
			                    try (ResultSet rs = preparedStatement1.executeQuery()) {
			                        if (rs.next()) {
			                            maxSeats = rs.getInt("num_seats");
			                        }
			                    }
			                }

			                // Check if the flight is full
		                String ticketCountQuery = "SELECT COUNT(*) as ticket_count FROM ticket WHERE flight_num = ?";
		                boolean isFull = false;
		                try (PreparedStatement preparedStatement2 = connection.prepareStatement(ticketCountQuery)) {
		                    preparedStatement2.setInt(1, flightNum);
		                    try (ResultSet rs = preparedStatement2.executeQuery()) {
		                        if (rs.next() && rs.getInt("ticket_count") >= maxSeats) {
		                            isFull = true;
		                        }
		                    }
		                }
					     Flight ft = new Flight(airlineId,aircraftId, fromAirport, fromDate, fromTime, toAirport, toDate, toTime, 
					    		 isDomestic, flightNum, flightType, numStops, ecoPrice, busPrice, firPrice,isFull);
					     ft.setAc(new Aircraft(aircraftId, maxSeats));
					     filteredFlights.add(ft);
					     System.out.println(ft.toString());
		            }
		        }
			}
		}
		System.out.println("\n");
		return filteredFlights;
	}
	private static int parseHour(String time) {
	    LocalTime localTime = LocalTime.parse(time, DateTimeFormatter.ofPattern("H[:mm[:ss]]"));
	    return localTime.getHour();
	}
	private boolean isNotEmpty(String str) {
	    return str != null && !str.isEmpty();
	}
}
