
package com.air;
import java.util.*;
import java.text.SimpleDateFormat;
import java.time.Duration;
import java.time.LocalDateTime;
import java.time.LocalTime;

/* `airline_id` varchar(5) NOT NULL,
//`aircraft_id` varchar(5) NOT NULL,
//`from_airport` varchar(5) NOT NULL,
//`from_date` date NOT NULL,
//`from_time` time NOT NULL,
//`to_airport` varchar(5) NOT NULL,
//`to_date` date NOT NULL,
//`to_time` time NOT NULL,
//`is_domestic` tinyint(1) NOT NULL,
//`flight_num` int NOT NULL,
//`flight_type` varchar(20) NOT NULL,
//`num_stops` int NOT NULL,
//`eco_price` float NOT NULL,
//`bus_price` float NOT NULL,
//`fir_price` float NOT NULL,*/
public class Flight{
	private String airlineId;
	private String aircraftId;
	private String fromAirport;
	private String fromDate;
	private String fromTime;
	private String toAirport;
	private String toDate;
	private String toTime;
	private int isDomestic;
	private int flightNum;
	private String flightType;
	private int numStops;
	private float ecoPrice;
	private float busPrice;
	private float firPrice;
	private String cabinClass;
	private boolean isFull;
	
	public Flight(String airlineId, String aircraftId, String fromAirport, String fromDate, String fromTime,
			String toAirport, String toDate, String toTime, int isDomestic, int flightNum, String flightType,
			int numStops, float ecoPrice, float busPrice, float firPrice, boolean isFull) {
		
		this.airlineId = airlineId;
		this.aircraftId = aircraftId;
		this.fromAirport = fromAirport;
		this.fromDate = fromDate;
		this.fromTime = fromTime;
		this.toAirport = toAirport;
		this.toDate = toDate;
		this.toTime = toTime;
		this.isDomestic = isDomestic;
		this.flightNum = flightNum;
		this.flightType = flightType;
		this.numStops = numStops;
		this.ecoPrice = ecoPrice;
		this.busPrice = busPrice;
		this.firPrice = firPrice;
		this.isFull = isFull;
	}
	public Flight(Flight flight) {
		this.airlineId = flight.airlineId;
		this.aircraftId = flight.aircraftId;
		this.fromAirport = flight.fromAirport;
		this.fromDate = flight.fromDate;
		this.fromTime = flight.fromTime;
		this.toAirport = flight.toAirport;
		this.toDate = flight.toDate;
		this.toTime = flight.toTime;
		this.isDomestic = flight.isDomestic;
		this.flightNum = flight.flightNum;
		this.flightType = flight.flightType;
		this.numStops = flight.numStops;
		this.ecoPrice = flight.ecoPrice;
		this.busPrice = flight.busPrice;
		this.firPrice = flight.firPrice;
		this.isFull = flight.isFull;
	}
	
	public boolean isFull() {
		return isFull;
	}
	public void setFull(boolean isFull) {
		this.isFull = isFull;
	}
	public float getPrice (){
		switch(this.cabinClass){
		case "Business":
			return this.busPrice;
		case "FirstClass":
			return this.firPrice;
		default:
			return this.ecoPrice;
		}
	}
	public String duration() {
		LocalTime fromTime = LocalTime.parse(this.fromTime);
        LocalTime toTime = LocalTime.parse(this.toTime);

        // Calculate the duration between fromTime and toTime
        Duration duration = Duration.between(fromTime, toTime);

        // Format and print the result
        long hours = duration.toHours();
        long minutes = duration.toMinutesPart();
		return String.format("%02d:%02d", hours, minutes);
	}
	public void setCabinClass(String cabinClass) {
		this.cabinClass = cabinClass;
	}
	public String getCabinClass() {
		return this.cabinClass;
	}
	public String getAirlineId() {
		return airlineId;
	}
	public void setAirlineId(String airlineId) {
		this.airlineId = airlineId;
	}
	public String getAircraftId() {
		return aircraftId;
	}
	public void setAircraftId(String aircraftId) {
		this.aircraftId = aircraftId;
	}
	public String getFromAirport() {
		return fromAirport;
	}
	public void setFromAirport(String fromAirport) {
		this.fromAirport = fromAirport;
	}
	public String getFromDate() {
		return fromDate;
	}
	public void setFromDate(String fromDate) {
		this.fromDate = fromDate;
	}
	public String getFromTime() {
		return fromTime;
	}
	public void setFromTime(String fromTime) {
		this.fromTime = fromTime;
	}
	public String getToAirport() {
		return toAirport;
	}
	public void setToAirport(String toAirport) {
		this.toAirport = toAirport;
	}
	public String getToDate() {
		return toDate;
	}
	public void setToDate(String toDate) {
		this.toDate = toDate;
	}
	public String getToTime() {
		return toTime;
	}
	public void setToTime(String toTime) {
		this.toTime = toTime;
	}
	public int getIsDomestic() {
		return isDomestic;
	}
	public void setIsDomestic(int isDomestic) {
		this.isDomestic = isDomestic;
	}
	public int getFlightNum() {
		return flightNum;
	}
	public void setFlightNum(int flightNum) {
		this.flightNum = flightNum;
	}
	public String getFlightType() {
		return flightType;
	}
	public void setFlightType(String flightType) {
		this.flightType = flightType;
	}
	public int getNumStops() {
		return numStops;
	}
	public void setNumStops(int numStops) {
		this.numStops = numStops;
	}
	public float getEcoPrice() {
		return ecoPrice;
	}
	public void setEcoPrice(float ecoPrice) {
		this.ecoPrice = ecoPrice;
	}
	public float getBusPrice() {
		return busPrice;
	}
	public void setBusPrice(float busPrice) {
		this.busPrice = busPrice;
	}
	public float getFirPrice() {
		return firPrice;
	}
	public void setFirPrice(float firPrice) {
		this.firPrice = firPrice;
	}
	@Override
	public String toString() {
		return "Flight [airlineId=" + airlineId + ", aircraftId=" + aircraftId + ", fromAirport=" + fromAirport
				+ ", fromDate=" + fromDate + ", fromTime=" + fromTime + ", toAirport=" + toAirport + ", toDate="
				+ toDate + ", toTime=" + toTime + ", isDomestic=" + isDomestic + ", flightNum=" + flightNum
				+ ", flightType=" + flightType + ", numStops=" + numStops + ", ecoPrice=" + ecoPrice + ", busPrice="
				+ busPrice + ", firPrice=" + firPrice + "]";
	}
	
}




//public class Flight {
//	private Aircraft ac;
//	private int flightNum;
//	private String airlineId;
//	private String departureAirport;
//	private String arrivalAirport;
//	private String cabinClass;
//	private float ecoPrice;
//    private float busPrice;
//    private float firPrice;
//    private String flightType;
//    private String departDate;
//    private String returnDate;
//    
//	public Flight(Aircraft ac, String departureAirport, String arrivalAirport, String airlineId, 
//			String flightType, String cabinClass, String departDate, String returnDate, 
//			float ecoPrice, float busPrice, float firPrice) {
//		//this.flightNum++;
//		this.ac = ac;
//		this.departureAirport = departureAirport;
//		this.arrivalAirport = arrivalAirport;
//		this.departDate = departDate;
//		this.returnDate = returnDate;
//		this.flightType = flightType;
//		this.cabinClass = cabinClass;
//		this.airlineId = airlineId;
//		this.ecoPrice = ecoPrice;
//		this.busPrice = busPrice;
//		this.firPrice = firPrice;
//	}
//	/* `airline_id` varchar(5) NOT NULL,
//	  `aircraft_id` varchar(5) NOT NULL,
//	  `from_airport` varchar(5) NOT NULL,
//	  `from_date` date NOT NULL,
//	  `from_time` time NOT NULL,
//	  `to_airport` varchar(5) NOT NULL,
//	  `to_date` date NOT NULL,
//	  `to_time` time NOT NULL,
//	  `is_domestic` tinyint(1) NOT NULL,
//	  `flight_num` int NOT NULL,
//	  `flight_type` varchar(20) NOT NULL,
//	  `num_stops` int NOT NULL,
//	  `eco_price` float NOT NULL,
//	  `bus_price` float NOT NULL,
//	  `fir_price` float NOT NULL,*/
//	public Flight(String airlineId, String aircraftId, String fromAirport, Date fromDate, Date fromTime,
//            String toAirport, Date toDate, Date toTime, boolean isDomestic, int flightNum,
//            String flightType, int numStops, float ecoPrice, float busPrice, float firPrice) {
//		  this.airlineId = airlineId;
//		  this.aircraftId = aircraftId;
//		  this.fromAirport = fromAirport;
//		  this.fromDate = fromDate;
//		  this.fromTime = fromTime;
//		  this.toAirport = toAirport;
//		  this.toDate = toDate;
//		  this.toTime = toTime;
//		  this.isDomestic = isDomestic;
//		  this.flightNum = flightNum;
//		  this.flightType = flightType;
//		  this.numStops = numStops;
//		  this.ecoPrice = ecoPrice;
//		  this.busPrice = busPrice;
//		  this.firPrice = firPrice;
//	}
//	public Aircraft getAircraft() {
//		return ac;
//	}
//	public String takeOffTime(){
//		return this.ac.getDepartTime();
//	}
//	public String landingTime() {
//		return this.ac.getArrivalTime();
//	}
//	public int getNumStops() {
//		return this.ac.getIntermediateConnections().size();
//	}
//
//	public void setAc(Aircraft ac) {
//		this.ac = ac;
//	}
//
//	public int getFlightNum() {
//		return flightNum;
//	}
//
//	public void setFlightNum(int flightNum) {
//		this.flightNum = flightNum;
//	}
//
//	public String getAirlineId() {
//		return airlineId;
//	}
//
//	public void setAirlineId(String airlineId) {
//		this.airlineId = airlineId;
//	}
//
//	public String getDepartureAirport() {
//		return departureAirport;
//	}
//
//	public void setDepartureAirport(String departureAirport) {
//		this.departureAirport = departureAirport;
//	}
//
//	public String getArrivalAirport() {
//		return arrivalAirport;
//	}
//
//	public void setArrivalAirport(String arrivalAirport) {
//		this.arrivalAirport = arrivalAirport;
//	}
//
//	public String getCabinClass() {
//		return cabinClass;
//	}
//
//	public void setCabinClass(String cabinClass) {
//		this.cabinClass = cabinClass;
//	}
//
//	public float getEcoPrice() {
//		return ecoPrice;
//	}
//
//	public void setEcoPrice(float ecoPrice) {
//		this.ecoPrice = ecoPrice;
//	}
//
//	public float getBusPrice() {
//		return busPrice;
//	}
//
//	public void setBusPrice(float busPrice) {
//		this.busPrice = busPrice;
//	}
//
//	public float getFirPrice() {
//		return firPrice;
//	}
//
//	public void setFirPrice(float firPrice) {
//		this.firPrice = firPrice;
//	}
//
//	public String getFlightType() {
//		return flightType;
//	}
//
//	public void setFlightType(String flightType) {
//		this.flightType = flightType;
//	}
//
//	public String getDepartDate() {
//		return departDate;
//	}
//
//	public void setDepartDate(String departDate) {
//		this.departDate = departDate;
//	}
//
//	public String getReturnDate() {
//		return returnDate;
//	}
//
//	public void setReturnDate(String returnDate) {
//		this.returnDate = returnDate;
//	}
//
//	public float getPrice() {
//		switch(cabinClass) {
//    		case "Business":
//    			return busPrice;
//    		case "FirstClass":
//    			return firPrice;
//    		default:
//    			return ecoPrice;
//    	}
//	}
//}
//    public String toString() {
//    	if(returnDate == null) {
//	    	return "Flight number: " + flightNum 
//	    			+ "\n" + "Airline ID: " + airlineId
//	    			+ "\n" + "Aircraft ID: " + ac.getAircraftId()
//	    			+ "\n" + "Flight Type: " + flightType
//	    			+ "\n" + "cabin:"  + cabinClass
//	    			+ "\n" + "Depart Date: " + departDate
//	    			+ "\n" + departureAirport + " to " + arrivalAirport 
//	    			+ "\n" + departureAirport + ": " + ac.getDepartureTimeRoute1()
//	    			+ "\n" + arrivalAirport + ": " + ac.getArrivalTimeRoute1()
//					+ "\n" + "price:"  + getPrice();
//    	}else {
//    		return "Flight number: " + flightNum 
//	    			+ "\n" + "Airline ID: " + airlineId
//	    			+ "\n" + "Aircraft ID: " + ac.getAircraftId()
//	    			+ "\n" + "Flight Type: " + flightType
//	    			+ "\n" + "cabin:"  + cabinClass
//	    			+ "\n" + "Depart Date: " + departDate
//	    			+ "\n" + departureAirport + " to " + arrivalAirport 
//	    			+ "\n" + departureAirport + ": " + ac.getDepartureTimeRoute1()
//	    			+ "\n" + arrivalAirport + ": " + ac.getArrivalTimeRoute1()
//	    			+ "\n=================================="
//	    			+ "\n" + "Return Date: " + returnDate
//	    			+ "\n" + arrivalAirport + " to " + departureAirport
//	    			+ "\n" + arrivalAirport + ": " + ac.getDepartureTimeRoute2()
//	    			+ "\n" + departureAirport + ": " + ac.getArrivalTimeRoute2()
//					+ "\n" + "price:"  + getPrice();
//    	}
//    }
   
//    private int number;
//    private boolean isDomestic;
//    private String departure;
//    private String destination;
//    private LocalDateTime arrivalTime;
//    private LocalDateTime departureTime;
//    private List<Customer> waitlist;
//
//    // Constructor
//    public Flight(int number, boolean isDomestic, Airport departure, Airport destination, LocalDateTime arrivalTime, LocalDateTime departureTime) {
//        this.number = number;
//        this.isDomestic = isDomestic;
//        this.departure = departure;
//        this.destination = destination;
//        this.arrivalTime = arrivalTime;
//        this.departureTime = departureTime;
//        this.waitlist = new ArrayList<>();
//    }
//
//    // Getters
//    public int getNumber() {
//        return number;
//    }
//
//    public boolean isDomestic() {
//        return isDomestic;
//    }
//
//    public Airport getDeparture() {
//        return departure;
//    }
//
//    public Airport getDestination() {
//        return destination;
//    }
//
//    public LocalDateTime getArrivalTime() {
//        return arrivalTime;
//    }
//
//    public LocalDateTime getDepartureTime() {
//        return departureTime;
//    }
//
//    public List<Customer> getWaitlist() {
//        return new ArrayList<>(waitlist); // Return a copy to prevent external modification
//    }
//
//    // Setters
//    public void setNumber(int number) {
//        this.number = number;
//    }
//
//    public void setDomestic(boolean isDomestic) {
//        this.isDomestic = isDomestic;
//    }
//
//    public void setDeparture(Airport departure) {
//        this.departure = departure;
//    }
//
//    public void setDestination(Airport destination) {
//        this.destination = destination;
//    }
//
//    public void setArrivalTime(LocalDateTime arrivalTime) {
//        this.arrivalTime = arrivalTime;
//    }
//
//    public void setDepartureTime(LocalDateTime departureTime) {
//        this.departureTime = departureTime;
//    }
//
//    public void setWaitlist(List<Customer> waitlist) {
//        this.waitlist = new ArrayList<>(waitlist); // Set a copy to prevent external modification
//    }

    // Additional methods can be added as needed
//}