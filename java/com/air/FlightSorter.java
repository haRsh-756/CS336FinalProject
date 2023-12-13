package com.air;

import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

public class FlightSorter{
	
}
//	public static List<Flight> sortAndFilterFlights(List<Flight> flights, String sortCriteria) {
//        // Implement your sorting and filtering logic here
//        // Use Collections.sort() for sorting and stream().filter() for filtering
//		
//        // Example:
//        if ("price".equals(sortCriteria)) {
//        	System.out.println("price");
//            // Sort by price
//            Collections.sort(flights, Comparator.comparing(Flight::getPrice));
//        } else if ("takeOffTime".equals(sortCriteria)) {
//            // Sort by take-off time
//            Collections.sort(flights, Comparator.comparing(flight -> flight.getAircraft().getDepartTime()));
//        }else if("landingTime".equals(sortCriteria)){
//        	Collections.sort(flights, Comparator.comparing(flight -> flight.getAircraft().getDepartTime()));
//        }else if("airline".equals(sortCriteria)) {
//        	Collections.sort(flights, Comparator.comparing(flight -> flight.getAirlineId()));
//        }else if("numStops".equals(sortCriteria)){
//        	Collections.sort(flights, Comparator.comparing(flight -> flight.getNumStops()));
//        }
//        return flights;
//     }
//}

//        if ("price".equals(filterCriteria)) {
//            // Filter by price
//            flights = flights.stream().filter(ticket -> ticket.getPrice() < 1000).collect(Collectors.toList());
//        } else if ("numStops".equals(filterCriteria)) {
//            // Filter by number of stops
//            flights = flights.stream().filter(ticket -> ticket.getFlight().getNumStops() == 0).collect(Collectors.toList());
//        }

        // Add more sorting and filtering criteria as needed

     