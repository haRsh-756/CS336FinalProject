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

			                Flight ft = new Flight(airlineId, aircraftId, fromAirport, fromDate, fromTime, toAirport, toDate, toTime, 
			                        isDomestic, flightNum, flightType, numStops, ecoPrice, busPrice, firPrice, isFull);
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
