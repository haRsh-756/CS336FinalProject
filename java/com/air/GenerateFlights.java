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
	private Aircraft [] acs = {
    		new Aircraft("AA101","08:00","EWR", "BOS", 120, 140, "BOS", "EWR", 120),
    		new Aircraft("AA102", "09:00", "EWR", "PHL", 90, 160, "PHL", "EWR",90),
    		new Aircraft("AA103","10:00","EWR","LGA", 105, 120, "LGA", "EWR", 105),
    		new Aircraft("DA401","09:30","EWR", "JFK", 60, 150, "JFK", "EWR" , 60),
    		new Aircraft("DA402", "10:45", "PHL", "BOS", 150, 180, "BOS", "PHL", 150),
    		new Aircraft("DA403", "11:00", "PHL", "LGA", 100, 120, "LGA", "PHL", 100),
    		new Aircraft("UA501", "11:15", "PHL", "JFK", 90, 150, "JFK", "PHL", 90),
    		new Aircraft("UA502", "10:30", "BOS", "LGA", 110, 190, "LGA", "BOS",110),
    		new Aircraft("UA503", "12:30", "BOS", "JFK", 120, 140, "JFK", "BOS",120),
    		new Aircraft("SA431", "10:30", "LGA", "JFK", 60, 160, "JFK", "LGA", 60),
    		
    		new Aircraft("SA432", "07:00", "PHL", "EWR", 90, 120, new ArrayList<>(Arrays.asList(new Connection("EWR", "JFK", 60, 140),
    				new Connection("JFK", "BOS",120, 150))), "BOS")
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
    };
	public Aircraft[] getAcs() {
		return acs;
	}

	public void setAcs(Aircraft[] acs) {
		this.acs = acs;
	}
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
		ApplicationDB db = new ApplicationDB();	
		java.sql.Connection connection = db.getConnection();
		String selectQuery = "SELECT * FROM flights";
		List<Flight> fls = new ArrayList<>();
		try {
			PreparedStatement preparedStatement = connection.prepareStatement(selectQuery);
			ResultSet resultSet = preparedStatement.executeQuery();
		 
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
		     Flight ft = new Flight(airlineId,aircraftId, fromAirport, fromDate, fromTime, toAirport, toDate, toTime, 
		    		 isDomestic, flightNum, flightType, numStops, ecoPrice, busPrice, firPrice, new Random().nextBoolean());
		     
		     fls.add(ft);	
		     //create flight with flex dates through out the session and storing into dataManager class instance
        }
		 resultSet.close();
         preparedStatement.close();
         connection.close();
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
}





/*public List<Flight> getAllFlights(String departureAirport, String arrivalAirport, String flightType, 
		String cabinClass, String departDate, String returnDate) {
	System.out.println(departureAirport + arrivalAirport + flightType + cabinClass + departDate + returnDate);
	List<Flight> fls = getFlightsFromDB();
	List<Flight> flights = new ArrayList<>();
	if(fls == null) {
		return null;
	}
	for(Flight flight: fls) {
		if(flightType.equals("flexibleOneWay") || flightType.equals("flexibleRound")) {
			if( (flight.getFromAirport().equals(departureAirport) && flight.getToAirport().equals(arrivalAirport)) 
					|| (flight.getToAirport().equals(departureAirport) && flight.getFromAirport().equals(arrivalAirport))) {
				if((flight.getToAirport().equals(departureAirport) && flight.getFromAirport().equals(arrivalAirport))) {
					flight.setFromAirport(departureAirport);
					flight.setToAirport(arrivalAirport);
				}
				final int days = 3;
				List<String> flexibleDepartDates = getFlexibleDates(departDate, days);
				if(flightType.equals("flexibleOneWay")) {
					for(String dep_date: flexibleDepartDates) {
						float ecoPrice = new Random().nextInt(500) + 100;
						float busPrice = ecoPrice * 1.5f;
						float firPrice = busPrice * 1.5f;
						Flight ft = new Flight(flight);
						ft.setFromDate(dep_date);
						ft.setEcoPrice(ecoPrice);
						ft.setFirPrice(firPrice);
						ft.setBusPrice(busPrice);
						ft.setCabinClass(cabinClass);
						ft.setFromTime(generateAndFormatRandomTime());
						ft.setToTime(generateAndFormatRandomTime());
						ft.setNumStops(new Random().nextInt(3));
						//ft.setFlightNum(DataManager.getInstance().generateFlightNum());
						ft.setFlightNum(flight.getFlightNum());
						flights.add(ft);
					}
				}
				else if(flightType.equals("flexibleRound")) {
					List<String> flexibleReturnDates = getFlexibleDates(returnDate, days);
					for(String dep_date: flexibleDepartDates) {
						for(String arr_date: flexibleReturnDates) {
							float ecoPrice = new Random().nextInt(500) + 100;
							float busPrice = ecoPrice * 1.5f;
							float firPrice = busPrice * 1.5f;
							Flight ft = new Flight(flight);
							ft.setFromDate(dep_date);
							ft.setToDate(arr_date);
							ft.setEcoPrice(ecoPrice);
							ft.setFirPrice(firPrice);
							ft.setBusPrice(busPrice);
							ft.setCabinClass(cabinClass);
							ft.setNumStops(new Random().nextInt(3));
							ft.setFlightNum(DataManager.getInstance().generateFlightNum());
							flights.add(ft);
						}
					}
				}
			}
		}else {
			if( (flight.getFromAirport().equals(departureAirport) && flight.getToAirport().equals(arrivalAirport)) 
					|| (flight.getToAirport().equals(departureAirport) && flight.getFromAirport().equals(arrivalAirport))) {
				if((flight.getToAirport().equals(departureAirport) && flight.getFromAirport().equals(arrivalAirport))) {
					flight.setFromAirport(departureAirport);
					flight.setToAirport(arrivalAirport);
				}
				//default record from table
				flight.setCabinClass(cabinClass);
				flights.add(flight);
			}
		}
	}	
	return flights;
}*/
	/* `airline_id` varchar(5) NOT NULL,
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
	  `fir_price` float NOT NULL,*/
//	 System.out.println("Airline: " + resultSet.getString("airline_id"));
//	 System.out.println("Aircraft: " + resultSet.getString("aircraft_id"));
//	 System.out.println(": " + resultSet.getString("from_airport"));
//	 System.out.println(": " + resultSet.getString("from_date"));
//	 System.out.println(": " + resultSet.getString("from_time"));
//	 System.out.println(": " + resultSet.getString("to_airport"));
//	 System.out.println(": " + resultSet.getString("to_date"));
//	 System.out.println(": " + resultSet.getString("to_time"));
//	 System.out.println(": " + resultSet.getString("is_domestic"));
//	 System.out.println(": " + resultSet.getString("flight_num"));
//	 System.out.println(": " + resultSet.getString("flight_type"));
//	 System.out.println(": " + resultSet.getString("num_stops"));
//	 System.out.println(": " + resultSet.getString("eco_price"));
//	 System.out.println(": " + resultSet.getString("bus_price"));
//	 System.out.println(": " + resultSet.getString("fir_price"));
	 			 	
//	public void getFlexibleDatesFlights(Aircraft ac, String departureAirport, String arrivalAirport, String flightType, 
//	String cabinClass, String departDate, String returnDate, int days) {
//List<String> flexibleDepartDates = getFlexibleDates(departDate, days);
//if(flightType.equals("flexibleOneWay")) {
//	for(String dep_date: flexibleDepartDates) {
//		float ecoPrice = new Random().nextInt(500) + 100;
//		float busPrice = ecoPrice * 1.5f;
//		float firPrice = busPrice * 1.5f;
//		if(ac != null) {
//			//Flight ft = new Flight(ac, departureAirport, arrivalAirport, ac.getAirlineId(), flightType, cabinClass, dep_date, 
//			//		returnDate, ecoPrice, busPrice, firPrice);
//			//ft.setFlightNum(DataManager.getInstance().generateFlightNum());
//			//flights.add(ft);
//		}
//	}
//}
//if(returnDate != null && flightType.equals("flexibleRound")) {
//	List<String> flexibleReturnDates = getFlexibleDates(returnDate, days);
//	for(String dep_date: flexibleDepartDates) {
//		for(String ret_date: flexibleReturnDates) {
//			float ecoPrice = new Random().nextInt(500) + 100;
//			float busPrice = ecoPrice * 1.5f;
//			float firPrice = busPrice * 1.5f;
//			if(ac != null) {
//			//	Flight ft = new Flight(ac, departureAirport, arrivalAirport, ac.getAirlineId(), flightType, cabinClass, dep_date, 
//			//			ret_date, ecoPrice, busPrice, firPrice);
//			//	ft.setFlightNum(DataManager.getInstance().generateFlightNum());
//			//	flights.add(ft);
//			}
//		}
//	}
//}
//}
//	public void getFlexibleDatesFlights(Aircraft ac, String departureAirport, String arrivalAirport, String flightType, 
//	String cabinClass, String departDate, String returnDate, int days) {
//List<String> flexibleDepartDates = getFlexibleDates(departDate, days);
//if(flightType.equals("flexibleOneWay")) {
//	for(String dep_date: flexibleDepartDates) {
//		float ecoPrice = new Random().nextInt(500) + 100;
//		float busPrice = ecoPrice * 1.5f;
//		float firPrice = busPrice * 1.5f;
//		if(ac != null) {
//			//Flight ft = new Flight(ac, departureAirport, arrivalAirport, ac.getAirlineId(), flightType, cabinClass, dep_date, 
//			//		returnDate, ecoPrice, busPrice, firPrice);
//			//ft.setFlightNum(DataManager.getInstance().generateFlightNum());
//			//flights.add(ft);
//		}
//	}
//}
//if(returnDate != null && flightType.equals("flexibleRound")) {
//	List<String> flexibleReturnDates = getFlexibleDates(returnDate, days);
//	for(String dep_date: flexibleDepartDates) {
//		for(String ret_date: flexibleReturnDates) {
//			float ecoPrice = new Random().nextInt(500) + 100;
//			float busPrice = ecoPrice * 1.5f;
//			float firPrice = busPrice * 1.5f;
//			if(ac != null) {
//			//	Flight ft = new Flight(ac, departureAirport, arrivalAirport, ac.getAirlineId(), flightType, cabinClass, dep_date, 
//			//			ret_date, ecoPrice, busPrice, firPrice);
//			//	ft.setFlightNum(DataManager.getInstance().generateFlightNum());
//			//	flights.add(ft);
//			}
//		}
//	}
//}
//}
//	if(ac != null) {
//	//Flight ft = new Flight(ac, departureAirport, arrivalAirport, ac.getAirlineId(), flightType, cabinClass, dep_date, 
//	//		returnDate, ecoPrice, busPrice, firPrice);
//	//ft.setFlightNum(DataManager.getInstance().generateFlightNum());
//	//flights.add(ft);
//}	
//	public List<Aircraft> findAircraft(String departAirport, String arrivalAirport) {
//		List<Aircraft> acList = new ArrayList<Aircraft>();
//		for(int i  = 0; i < acs.length; i++) {
////			if((acs[i].getRoute1From().equals(departAirport) && acs[i].getRoute1To().equals(arrivalAirport))
////					|| (acs[i].getRoute2From().equals(departAirport) && acs[i].getRoute2To().equals(arrivalAirport)) ) {
////				//return acs[i];
////				acList.add(acs[i]);
////			}
//			if(acs[i].getRoute1From().equals(departAirport) && acs[i].getRoute1To().equals(arrivalAirport)) {
//				acs[i].setRoute1(true);
//				acList.add(acs[i]);
//			}
//			else if(acs[i].getRoute2From().equals(departAirport) && acs[i].getRoute2To().equals(arrivalAirport)) {
//				acs[i].setRoute2(true);
//				acList.add(acs[i]);
//			}
//		}
//		return acList; 
//	}

//	public List<Aircraft> findAircraft(String departAirport, String arrivalAirport){
//		List<Aircraft> acList = new ArrayList<Aircraft>();
//		for(Aircraft ac: acs) {
//			if( (ac.getFrom().equals(departAirport) && ac.getTo().equals(arrivalAirport) && ac.isDirect())
//					|| (ac.getTo().equals(departAirport) && ac.getFrom().equals(arrivalAirport) && ac.isDirect())  ) {
//				acList.add(ac);
//			}
//			else if( !ac.isDirect() &&  ac.getDestAirport() != null && ((ac.getFrom().equals(departAirport) && ac.getDestAirport().equals(arrivalAirport)) 
//					|| (ac.getDestAirport().equals(departAirport) && ac.getFrom().equals(arrivalAirport))) ) {
//				acList.add(ac);
//			}
//		}
////		for(Aircraft ac: acs) {
////			if(ac.isDirect() && ac.getFrom().equals(departAirport) && ac.getTo().equals(arrivalAirport)) {
////				acList.add(ac);
////			}
////		}
//		for(Aircraft ac: acList) {
//			System.out.println(ac.getAircraftId());
//		}
//		return acList;
//	}
//	public void getFlexibleDatesFlights(Aircraft ac, String departureAirport, String arrivalAirport, String flightType, 
//			String cabinClass, String departDate, String returnDate, int days) {
//		List<String> flexibleDepartDates = getFlexibleDates(departDate, days);
//		if(flightType.equals("flexibleOneWay")) {
//			for(String dep_date: flexibleDepartDates) {
//				float ecoPrice = new Random().nextInt(500) + 100;
//				float busPrice = ecoPrice * 1.5f;
//				float firPrice = busPrice * 1.5f;
//				if(ac != null) {
//					//Flight ft = new Flight(ac, departureAirport, arrivalAirport, ac.getAirlineId(), flightType, cabinClass, dep_date, 
//					//		returnDate, ecoPrice, busPrice, firPrice);
//					//ft.setFlightNum(DataManager.getInstance().generateFlightNum());
//					//flights.add(ft);
//				}
//			}
//		}
//		if(returnDate != null && flightType.equals("flexibleRound")) {
//			List<String> flexibleReturnDates = getFlexibleDates(returnDate, days);
//			for(String dep_date: flexibleDepartDates) {
//				for(String ret_date: flexibleReturnDates) {
//					float ecoPrice = new Random().nextInt(500) + 100;
//					float busPrice = ecoPrice * 1.5f;
//					float firPrice = busPrice * 1.5f;
//					if(ac != null) {
//					//	Flight ft = new Flight(ac, departureAirport, arrivalAirport, ac.getAirlineId(), flightType, cabinClass, dep_date, 
//					//			ret_date, ecoPrice, busPrice, firPrice);
//					//	ft.setFlightNum(DataManager.getInstance().generateFlightNum());
//					//	flights.add(ft);
//					}
//				}
//			}
//		}
//	}
//	public List<Flight> getFlights(String departureAirport, String arrivalAirport, String flightType, 
//			String cabinClass, String departDate, String returnDate) {
//		System.out.println(departureAirport + arrivalAirport + flightType + cabinClass + departDate + returnDate);
//		List<Flight> fls = getFlightsFromDB();
		
//		List<Aircraft> aircrafts = findAircraft(departureAirport, arrivalAirport);
//		flights = new ArrayList<Flight>();
//		
//		for(Aircraft ac: aircrafts) {
//			if(flightType.equals("oneWay") || flightType.equals("roundTrip")) {
//				float ecoPrice = new Random().nextInt(500) + 100;
//				float busPrice = ecoPrice * 1.5f;
//				float firPrice = busPrice * 1.5f;
//				if(ac != null) {
//					//Flight ft = new Flight(ac, departureAirport, arrivalAirport, ac.getAirlineId(), flightType, cabinClass, departDate, 
//					//		returnDate, ecoPrice, busPrice, firPrice);
//					//ft.setFlightNum(DataManager.getInstance().generateFlightNum());
//					//flights.add(ft);
//					//System.out.println(flights);
//				}
//			}
//			else {
//				final int days = 3;
//				getFlexibleDatesFlights(ac, departureAirport, arrivalAirport, flightType, cabinClass, departDate, returnDate, days);
//			}
//		}
//		//System.out.println("flights check: "+ flights);
//		return flights;
//	}
//	public List<Flight> getFlights(String departureAirport, String arrivalAirport, String flightType, 
//			String cabinClass, String departDate, String returnDate) {
//		System.out.println(departureAirport + arrivalAirport + flightType + cabinClass + departDate + returnDate);
//		List<Aircraft> aircrafts = findAircraft(departureAirport, arrivalAirport);
//		flights = new ArrayList<Flight>();
//		
//		for(Aircraft ac: aircrafts) {
//			if(flightType.equals("oneWay") || flightType.equals("roundTrip")) {
//				float ecoPrice = new Random().nextInt(500) + 100;
//				float busPrice = ecoPrice * 1.5f;
//				float firPrice = busPrice * 1.5f;
//				if(ac != null) {
//					//Flight ft = new Flight(ac, departureAirport, arrivalAirport, ac.getAirlineId(), flightType, cabinClass, departDate, 
//					//		returnDate, ecoPrice, busPrice, firPrice);
//					//ft.setFlightNum(DataManager.getInstance().generateFlightNum());
//					//flights.add(ft);
//					//System.out.println(flights);
//				}
//			}
//			else {
//				final int days = 3;
//				getFlexibleDatesFlights(ac, departureAirport, arrivalAirport, flightType, cabinClass, departDate, returnDate, days);
//			}
//		}
//		//System.out.println("flights check: "+ flights);
//		return flights;
//	}

//List<String> flexibleArrivalDates = 
//for(Aircraft ac: acs) {
//	if(flightType.equals("flexibleOneWay")) {
//		for(String dep_date: flexibleDepartDates) {
//			float ecoPrice = new Random().nextInt(500) + 100;
//			float busPrice = ecoPrice * 1.5f;
//			float firPrice = busPrice * 1.5f;
//			if(ac != null) {
//				Flight ft = new Flight(ac, departureAirport, arrivalAirport, ac.getAirlineId(), flightType, cabinClass, dep_date, 
//						returnDate, ecoPrice, busPrice, firPrice);
//				ft.setFlightNum(DataManager.getInstance().generateFlightNum());
//				flights.add(ft);
//			}
//		}
//	}
//	if(returnDate != null && flightType.equals("flexibleRound")) {
//		List<String> flexibleReturnDates = getFlexibleDates(returnDate, days);
//		for(String dep_date: flexibleDepartDates) {
//			for(String ret_date: flexibleReturnDates) {
//				float ecoPrice = new Random().nextInt(500) + 100;
//				float busPrice = ecoPrice * 1.5f;
//				float firPrice = busPrice * 1.5f;
//				if(ac != null) {
//					Flight ft = new Flight(ac, departureAirport, arrivalAirport, ac.getAirlineId(), flightType, cabinClass, dep_date, 
//							ret_date, ecoPrice, busPrice, firPrice);
//					ft.setFlightNum(DataManager.getInstance().generateFlightNum());
//					flights.add(ft);
//				}
//			}
//		}
//	}
//}

//float ecoPrice = new Random().nextInt(500) + 100;
//float busPrice = ecoPrice * 1.5f;
//float firPrice = busPrice * 1.5f;
//if(ac != null) {
//	Flight ft = new Flight(ac, departureAirport, arrivalAirport, ac.getAirlineId(), flightType, cabinClass, departDate, 
//			returnDate, ecoPrice, busPrice, firPrice);
//	ft.setFlightNum(DataManager.getInstance().generateFlightNum());
//	flights.add(ft);
//}
//float ecoPrice = new Random().nextInt(500) + 100;
//float busPrice = ecoPrice * 1.5f;
//float firPrice = busPrice * 1.5f;
//if(ac != null) {
//	ft = new Flight(ac, departureAirport, arrivalAirport, ac.getAirlineId(), flightType, cabinClass, departDate, 
//			returnDate, ecoPrice, busPrice, firPrice);
//	return ft.toString();
//}
//return "No flights Found from " + departureAirport + " to " + arrivalAirport;
//	private static String[] airlines = {"AA", "UA", "DA"};
//	private static String[] aircrafts = {"AA101", "AA102","AA103", "DA401", "DA402", "DA403","UA501", "UA502","UA503"};
//	private static String[] airports = {"EWR", "LGA", "PHL", "BOS", "JFK"};
//	public static void main(String[] args) {
//		initializeDepartureArrivalTimes();
//	}
//	private static void initializeDepartureArrivalTimes() {
//		Random random = new Random();
//        // Initialize departure and arrival times for each airport and airline
////        for (String aircraft : aircrafts) {
////        	String departAirport = airports[random.nextInt(airports.length)];
////            String arrivalAirport = airports[random.nextInt(airports.length)];
////
////            // Ensure departure and arrival airports are different
////            while (departAirport.equals(arrivalAirport)) {
////                arrivalAirport = airports[random.nextInt(airports.length)];
////            }
////            String departureTime = getDepartureTime(departAirport);
////            String arrivalTime = getArrivalTime(departureTime, arrivalAirport);
////            String key = aircraft + " " + departAirport + " " + arrivalAirport;
////            //departureTimes.put(key, departureTime);
////            //arrivalTimes.put(key, arrivalTime);
////            System.out.println(key + " " + departureTime + " "  + arrivalTime);
////        }
//		for(String aircraft: aircrafts) {
//			String departAirport = "PHL";
//			String arrivalAirport = "BOS";
//			String departureTime = getDepartureTime(departAirport);
//            String arrivalTime = getArrivalTime(departureTime, arrivalAirport);
//			System.out.println(aircraft + " " + departAirport + " " + arrivalAirport + " " + departureTime  + " " + arrivalTime);
//		}
//		
//		
//		
//	
//		//Aircraft ac1 = new Aircraft("aa101", "departure time route 1: 08:00:00", arrival time based on travel time: 120 minutes , "route1: ewr to bos", "route2: bos to ewr", 
//			//	gap time: 140 minutes,"departure time route2:" based on gap time, and arrival time based on travel time: 120 minutes);
//		/*
//		 * aircraft object will have id and fix departure time and arrival time is manually entered
//		 *  aircrafts = {"AA101", "AA102","AA103", "DA401", "DA402", "DA403","UA501", "UA502","UA503"} assigned the time for each aircraft and from airport
//		 *  aircraft aa101 : route: ewr to bos, gap time, bos to ewr
//		 *  aircraft aa102 : route: ewr to phl, gap time, phl to ewr
//		 *  aircraft aa103 : route: ewr to lga, gap time, lga to ewr
//		 *  //aircraft aa104 : route: ewr to jfk, gap time 
//		 */
//    }
//	private static String changeTime(String aircraft) {
//		int timeGap = 0;
//		if(aircraft.startsWith("AA") && aircraft.endsWith("02")) {
//			timeGap = 30;
//		}
//		return null;
//	}
//	private static String getDepartureTime(String fromAirport) {
//        // Set departure time based on the airport (you can customize this)
//        switch (fromAirport) {
//            case "EWR":
//                return "08:00:00";
//            case "LGA":
//                return "09:30:00";
//            case "PHL":
//                return "10:45:00";
//            case "BOS":
//                return "11:15:00";
//            case "JFK":
//                return "11:45:00";
//            case "BDL": 
//            	return "12:30:00";
//            default:
//                return "08:00:00"; // Default departure time
//        }
//    }
//
//    private static String getArrivalTime(String departTime, String toAirport) {
//        // Set arrival time based on the departure time and destination airport (you can customize this)
//        switch (toAirport) {
//            case "EWR":
//                return addTime(departTime, 120); // Add 2 hours for simplicity
//            case "LGA":
//                return addTime(departTime, 90);  // Add 1.5 hours for simplicity
//            case "PHL":
//                return addTime(departTime, 105); // Add 1.75 hours for simplicity
//            case "BOS":
//                return addTime(departTime, 135); // Add 2.25 hours for simplicity
//            case "JFK":
//                return addTime(departTime, 180); // Add 3 hours for simplicity
//            default:
//                return departTime; // Return depart time if destination is unknown
//        }
//    }
//    private static String addTime(String baseTime, int minutesToAdd) {
//        SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss");
//        try {
//            Date baseDate = (Date) sdf.parse(baseTime);
//            Calendar calendar = Calendar.getInstance();
//            calendar.setTime(baseDate);
//            calendar.add(Calendar.MINUTE, minutesToAdd);
//            return sdf.format(calendar.getTime());
//        } catch (Exception e) {
//            e.printStackTrace();
//            return baseTime; // Return base time in case of error
//        }
//    }




//public class GenerateFlights{
//	private static Map<String, String> departureTimes = new HashMap<>();
//    private static Map<String, String> arrivalTimes = new HashMap<>();
//    private static int timeGapMinutes = 60; // Adjust the time gap as needed
//    private static String[] airlines = {"AA", "UA", "DA"};
//    private static String[] aircraft = {"AA101", "AA102", "DA401", "DA402", "UA501", "UA502"};
//    private static String[] airports = {"EWR", "LGA", "PHL", "BOS", "JFK"};
//	public static void main(String[] args) {
////		String[] airlines = {"AA", "UA", "DA"};
////	    String[] aircraft = {"AA101", "AA102", "DA401", "DA402", "UA501", "UA502"};
////	    String[] airports = {"EWR", "LGA", "PHL", "BOS", "JFK"};
////	    
////	    
////		try(Connection conn = new ApplicationDB().getConnection()){
////			String flightType = "roundTrip";
////			String departAirport = "EWR";
////			String arrivalAirport = "BOS";
////			String cabinClass = "Economy";
////			String departDate = "12/4/2023";
////			String arrivalDate = "";  
////			List<String> airlineIds = new ArrayList<>();
////			
////			Statement st = conn.createStatement();
////		     ResultSet rs = st.executeQuery("SELECT airline_id FROM airline");
////		     while (rs.next()) {
////		        airlineIds.add(rs.getString("airline_id"));
////		     }
////		     System.out.println(airlineIds);
////		} catch (SQLException e) {
////            e.printStackTrace();
////        }catch(Exception e1) {
////        	e1.printStackTrace();
////        }
//		initializeDepartureArrivalTimes();
//		departureTimes.forEach((key, value) -> System.out.println(key + " " + value));
//		System.out.println("\n");
//		arrivalTimes.forEach((key, value) -> System.out.println(key + " " + value));
//	}
//	private static void initializeDepartureArrivalTimes() {
//        // Initialize departure and arrival times for each airport and airline
//        for (String airline : airlines) {
//            for (String airport : airports) {
//                String departureTime = getDepartureTime(airport);
//                String arrivalTime = getArrivalTime(departureTime, airport);
//                String key = airline + airport;
//                departureTimes.put(key, departureTime);
//                arrivalTimes.put(key, arrivalTime);
//            }
//        }
//    }
//	private static String getDepartureTime(String fromAirport) {
//        // Set departure time based on the airport (you can customize this)
//        switch (fromAirport) {
//            case "EWR":
//                return departureTimes.put(getRandomAirline() + fromAirport, "08:00:00");
//            case "LGA":
//                return departureTimes.put(getRandomAirline() + fromAirport, "09:30:00");
//            case "PHL":
//                return departureTimes.put(getRandomAirline() + fromAirport, "10:45:00");
//            case "BOS":
//            	return departureTimes.put(getRandomAirline() + fromAirport, "11:15:00");
//            case "JFK":
//                return departureTimes.put(getRandomAirline() + fromAirport, "12:30:00");
//            default:
//            	return departureTimes.getOrDefault(getRandomAirline() + fromAirport, "08:00:00");// Default departure time
//        }
//    }
//	private static String getArrivalTime(String departTime, String toAirport) {
//		switch (toAirport) {
//	        case "EWR":
//	            return arrivalTimes.put(getRandomAirline() + toAirport,addTime(departTime,120)); // Add 2 hours for simplicity
//	        case "LGA":
//	        	return arrivalTimes.put(getRandomAirline() + toAirport,addTime(departTime,90));  // Add 1.5 hours for simplicity
//	        case "PHL":
//	        	return arrivalTimes.put(getRandomAirline() + toAirport,addTime(departTime,105)); // Add 1.75 hours for simplicity
//	        case "BOS":
//	        	return arrivalTimes.put(getRandomAirline() + toAirport,addTime(departTime,135)); // Add 2.25 hours for simplicity
//	        case "JFK":
//	        	return arrivalTimes.put(getRandomAirline() + toAirport,addTime(departTime,180)); // Add 3 hours for simplicity
//	        default:
//	        	return arrivalTimes.getOrDefault(getRandomAirline() +toAirport,departTime); // Return depart time if destination is unknown
//		}
//        // Retrieve arrival time based on departure time and destination airport
////        String key = getRandomAirline() + toAirport;
////        return arrivalTimes.getOrDefault(key, departTime); // Default to depart time if arrival time is not set
//    }
//
//    private static String getRandomAirline() {
//        // Get a random airline
//        return airlines[new Random().nextInt(airlines.length)];
//    }
////	private static String getArrivalTime(String departTime, String toAirport) {
////        // Set arrival time based on the departure time and destination airport (you can customize this)
////        switch (toAirport) {
////            case "EWR":
////                return addTime(departTime, 120); // Add 2 hours for simplicity
////            case "LGA":
////                return addTime(departTime, 90);  // Add 1.5 hours for simplicity
////            case "PHL":
////                return addTime(departTime, 105); // Add 1.75 hours for simplicity
////            case "BOS":
////                return addTime(departTime, 135); // Add 2.25 hours for simplicity
////            case "JFK":
////                return addTime(departTime, 180); // Add 3 hours for simplicity
////            default:
////                return departTime; // Return depart time if destination is unknown
////        }
////    }
//
//    private static String addTime(String baseTime, int minutesToAdd) {
//        SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss");
//        try {
//            Date baseDate = (Date) sdf.parse(baseTime);
//            Calendar calendar = Calendar.getInstance();
//            calendar.setTime(baseDate);
//            calendar.add(Calendar.MINUTE, minutesToAdd);
//            return sdf.format(calendar.getTime());
//        } catch (Exception e) {
//            e.printStackTrace();
//            return baseTime; // Return base time in case of error
//        }
//    }
//	
//}