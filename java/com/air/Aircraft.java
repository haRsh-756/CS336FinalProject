package com.air;

import java.time.Duration;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;


public class Aircraft {
    
    // public String getDepartureTime() {
    //     // Assume departure time is the same as the arrival time of the previous connection
    //     return LocalTime.MIN.toString();  // You may need to adjust this based on your logic
    // }

    // public String getArrivalTime() {
    //     // Calculate arrival time based on departure time, travel time, and gap time
    //     LocalTime calculatedTime = LocalTime.parse(getDepartureTime()).plusMinutes(travelTime + gapTime);
    //     return calculatedTime.toString();
    // }
    /*public String getDepartureTime(String previousArrivalTime) {
        // Departure time is based on the previous airport's arrival time and gap time
        return LocalTime.parse(previousArrivalTime).plusMinutes(gapTime).toString();
    }*/
    /*public String getDepartureTime(String previousArrivalTime){
        return LocalTime.parse(previousArrivalTime).toString();
    }

    public String getArrivalTime(String departureTime) {
        // Arrival time is based on departure time and travel time
        return LocalTime.parse(departureTime).plusMinutes(travelTime).toString();
    }*/
    
    private String aircraftId;
    private String departTime;
    private String arrivalTime;
    private int gapTime;
    private List<Connection> intermediateConnections;
    private int travelTime;
    private String destAirport;
    private String from;
    private String to;
    private boolean isDirect;
    
    public Aircraft(String aircraftId, String departTime, String from , String to, 
            int travelTime, int gapTime, String from1, String to1, int travelTime1){
        this.aircraftId = aircraftId;
        this.departTime = departTime;
        this.from = from;
        this.to = to;
        this.travelTime = travelTime;
        this.gapTime = gapTime;
        this.isDirect = true;
    }
    public Aircraft(String aircraftId, String departTime, String from, String to, int travelTime, int gapTime, List<Connection> connections, String destAirport){
        this.aircraftId = aircraftId;
        this.departTime = departTime;
        this.from = from;
        this.to = to;
        this.intermediateConnections = connections;
        this.travelTime = travelTime;
        this.gapTime = gapTime;
        this.destAirport = destAirport;
        this.isDirect = false;
    }
    public void setDirect(boolean direct){
        this.isDirect = direct;
    }
    public boolean isDirect(){
        return this.isDirect;
    }
    public void setFrom(String from){
        this.from = from;
    }
    public String getFrom(){
        return this.from;
    }
    public void setTo(String to){
        this.to = to;
    }
    public String getTo(){
        return this.to;
    }
    public String getDestAirport(){
        return this.destAirport;
    }
    public int getTravelTime(){
        return this.travelTime;
    }
    
    public void setArrivalTime(String departTime, int travelTime){
        this.arrivalTime = LocalTime.parse(departTime).plusMinutes(travelTime).toString();
    }
    public String getArrivalTime(){
        return this.arrivalTime;
    }
    public void setDepartTime(String arrivalTime, int gapTime){
        this.departTime = LocalTime.parse(arrivalTime).plusMinutes(gapTime).toString();
    }
    public void setDepartTime(String departTime){
        this.departTime = departTime;
    }
    public String getDepartTime(){
        return this.departTime;
    }
    
    public String getAircraftId() {
        return aircraftId;
    }
    public String getAirlineId() {
    	return aircraftId.substring(0, 2);
    }
    public String getGapTime() {
        Duration duration = Duration.ofMinutes(gapTime);
        long hours = duration.toHours();
        long minutes = duration.toMinutesPart();

        return String.format("%02d:%02d", hours, minutes);
    }
    public int getGapTimeAsInt(){
        return this.gapTime;
    }
    public List<Connection> getIntermediateConnections() {
        return intermediateConnections;
    }
 
    public static void main(String[] args){
    	
        List<Connection> connections = new ArrayList<>();
        connections.add(new Connection("PHL", "JFK", 45, 180));
        connections.add(new Connection("JFK", "BOS", 60, 90));
        Aircraft ac1 = new Aircraft("AA101", "08:00", "EWR", "BOS", 120, 90, "BOS", "EWR", 120);
        Aircraft ac2 = new Aircraft("AA102", "07:00", "EWR", "PHL", 90, 120, connections, "BOS");
        Aircraft [] acs = {ac1, ac2};
        String departAirport = "EWR";
        String arrivalAirport = "BOS";
        for(Aircraft ac: acs){
            if(ac.isDirect()){
                System.out.println("Direct flight:");
                if(ac.getFrom().equals(departAirport) && ac.getTo().equals(arrivalAirport)){
                    System.out.println("Departure time: " + ac.getDepartTime());
                    ac.setArrivalTime(ac.getDepartTime(), ac.getTravelTime());
                     System.out.println("Arrival time: " + ac.getArrivalTime());
                     System.out.println("GapTime: " + ac.getGapTime());
                }
                else if(ac.getTo().equals(departAirport) && ac.getFrom().equals(arrivalAirport)){
                    ac.setArrivalTime(ac.getDepartTime(), ac.getTravelTime());
                    System.out.println("Return route" + ac.getTo() + " to " + ac.getFrom());
                    System.out.println("Gap time: " + ac.getGapTimeAsInt());
                    //System.out.println("arrivalTime: " + ac.getArrivalTime());
                    ac.setDepartTime(ac.getArrivalTime(), ac.getGapTimeAsInt());
                    System.out.println("Depart time: " + ac.getDepartTime());
                    ac.setArrivalTime(ac.getDepartTime(), ac.getTravelTime());
                    System.out.println("Arrival time: " + ac.getArrivalTime());
                }
                //acs[i].setArrivalTime(ac1.getDepartTime(), ac1.getTravelTime());
            }
            
            else if(!ac.intermediateConnections.isEmpty()){
            	if((ac.getFrom().equals(departAirport) && ac.getDestAirport().equals(arrivalAirport)) 
                        || (ac.getDestAirport().equals(departAirport) && ac.getFrom().equals(arrivalAirport))){
                    // if(ac.getFrom().equals(departAirport) && ac.getDestAirport().equals(arrivalAirport)){
                    System.out.println("Aircraft ID: " + ac.getAircraftId());
                    System.out.println("route: " + ac.getFrom() + " to " + ac.getTo());
                
                    System.out.println("Departure Time: " + ac.getDepartTime());
                    ac.setArrivalTime(ac.getDepartTime(),ac.getTravelTime());
                    System.out.println("Arrival Time: " + ac.getArrivalTime());
                    System.out.println("Gap Time: " + ac.getGapTime());
                    
                    List<Connection> intermediateConnections = ac.getIntermediateConnections();
                    String dep_TimeForConnection = LocalTime.parse(ac.getArrivalTime()).plusMinutes(ac.getGapTimeAsInt()).toString();
                    String lastArrivalTime="";
                    int lastGapTime=-1;
                    String lastAirport = "";

                    for (int i = 0; i < intermediateConnections.size(); i++) {
                        Connection connection = intermediateConnections.get(i);
                        connection.setDepartTime(dep_TimeForConnection);
                        connection.setArrivalTime(connection.getDepartTime());
                        System.out.println("Intermediate Connection " + (i + 1) + ": " + connection.getFromAirport() +
                                " to " + connection.getToAirport());
                        // System.out.println("Departure Time: " + connection.getDepartTime(dep_TimeForConnection));
                        // System.out.println("Arrival Time: " + connection.getArrivalTime(dep_TimeForConnection));
                        System.out.println("Departure Time: " + connection.getDepartTime());
                        System.out.println("Arrival Time: " + connection.getArrivalTime());
                        System.out.println("Gap Time: " + connection.getGapTime());
                        dep_TimeForConnection = LocalTime.parse(connection.getArrivalTime()).plusMinutes(connection.getGapTime()).toString();
                        lastArrivalTime = connection.getArrivalTime();
                        lastGapTime = connection.getGapTime();
                    }
                    System.out.println("Dest Airport: " + ac.getDestAirport());
                    //}
                    if(ac.getDestAirport().equals(departAirport) && ac.getFrom().equals(arrivalAirport)){
                        System.out.println("\nreverse checking\n");
                         String returnDepTime = LocalTime.parse(lastArrivalTime).plusMinutes(lastGapTime).toString();
                        for(int i= intermediateConnections.size()-1; i >= 0; i--){
                            Connection connection = intermediateConnections.get(i);
                            connection.setDepartTime(returnDepTime);
                            connection.setArrivalTime(connection.getDepartTime());

                            //connection.setFromAirport(connection.getToAirport());
                            String from = connection.getToAirport();
                            String to = connection.getFromAirport();

                            connection.setFromAirport(from);
                            connection.setToAirport(to);
                            System.out.println("Intermediate Connection " + (i + 1) + ": " + connection.getFromAirport() +
                                    " to " + connection.getToAirport());
                            // System.out.println("Departure Time: " + connection.getDepartTime(dep_TimeForConnection));
                            // System.out.println("Arrival Time: " + connection.getArrivalTime(dep_TimeForConnection));
                            System.out.println("Departure Time: " + connection.getDepartTime());
                            System.out.println("Arrival Time: " + connection.getArrivalTime());
                            System.out.println("Gap Time: " + connection.getGapTime());
                            returnDepTime = LocalTime.parse(connection.getArrivalTime()).plusMinutes(connection.getGapTime()).toString();
                            lastArrivalTime = connection.getArrivalTime();
                            lastGapTime = connection.getGapTime();
                            lastAirport = connection.getToAirport();
                        }
                        ac.setDepartTime(lastArrivalTime, lastGapTime);
                        System.out.println("route: " + lastAirport + " to " + ac.getFrom());
                        System.out.println("Departure time: " + ac.getDepartTime());
                        ac.setArrivalTime(ac.getDepartTime(),ac.getTravelTime());
                        System.out.println("Arrival time: " + ac.getArrivalTime());
                    }
                    //else if(ac.getDestAirport().equals(departAirport)){

                    //}
            	}
            }
         }
    }
    
}
    


















//public class Aircraft {
//    private String aircraftId;
//    private String departTime;
//    private String arrivalTime;
//    private String route1From;
//    private String route1To;
//    private int route1TravelTime;
//    private int gapTime;
//    private List<Connection> intermediateConnections;
//    private String route2From;
//    private String route2To;
//    private int route2TravelTime;
//    private boolean isRoute1;
//    private boolean isRoute2;
//
//    public Aircraft(String aircraftId, String departureTime, String route1From, String route1To, int route1TravelTime,
//                    int gapTime, List<Connection> intermediateConnections, String route2From, String route2To, int route2TravelTime) {
//        this.aircraftId = aircraftId;
//        this.departTime = departureTime;
//        this.route1From = route1From;
//        this.route1To = route1To;
//        this.route1TravelTime = route1TravelTime;
//        this.gapTime = gapTime;
//        this.intermediateConnections = intermediateConnections;
//        this.route2From = route2From;
//        this.route2To = route2To;
//        this.route2TravelTime = route2TravelTime;
//    }
//    public Aircraft(String aircraftId, String departureTime, String route1From, String route1To, int route1TravelTime, int gapTime,
//                    String route2From, String route2To, int route2TravelTime) {
//        this.aircraftId = aircraftId;
//        this.departTime = departureTime;
//        this.route1From = route1From;
//        this.route1To = route1To;
//        this.route1TravelTime = route1TravelTime;
//        this.gapTime = gapTime;
//        this.route2From = route2From;
//        this.route2To = route2To;
//        this.route2TravelTime = route2TravelTime;
//    }
//    public void setArrivalTime(String departTime, int travelTime){
//        this.arrivalTime = LocalTime.parse(departTime).plusMinutes(travelTime).toString();
//    }
//    public String getArrivalTime(){
//        return this.arrivalTime;
//    }
//    public void setDepartTime(String arrivalTime, int gapTime){
//        this.departTime = LocalTime.parse(arrivalTime).plusMinutes(gapTime).toString();
//    }
//    public void setDepartTime(String departTime){
//        this.departTime = departTime;
//    }
//    public String getDepartTime(){
//        return this.departTime;
//    }
//    
//    public String getAircraftId() {
//        return aircraftId;
//    }
//
//    public boolean isRoute1() {
//        return isRoute1;
//    }
//
//    public void setRoute1(boolean isRoute1) {
//        this.isRoute1 = isRoute1;
//    }
//
//    public boolean isRoute2() {
//        return isRoute2;
//    }
//
//    public void setRoute2(boolean isRoute2) {
//        this.isRoute2 = isRoute2;
//    }
//
//    public String getAirlineId() {
//        return aircraftId.substring(0, 2);
//    }
//
//    public String getRoute1From() {
//        return route1From;
//    }
//
//    public String getRoute1To() {
//        return route1To;
//    }
//
//    public int getRoute1TravelTime() {
//        return route1TravelTime;
//    }
//
//    public String getGapTime() {
//        Duration duration = Duration.ofMinutes(gapTime);
//        long hours = duration.toHours();
//        long minutes = duration.toMinutesPart();
//
//        return String.format("%02d:%02d", hours, minutes);
//    }
//    public int getGapTimeAsInt(){
//        return this.gapTime;
//    }
//
//    public String getRoute2From() {
//        return route2From;
//    }
//
//    public String getRoute2To() {
//        return route2To;
//    }
//
//    public int getRoute2TravelTime() {
//        return route2TravelTime;
//    }
//    
//    public List<Connection> getIntermediateConnections() {
//        return intermediateConnections;
//    }
//
//    public static void main(String[] args){
//        Aircraft ac = new Aircraft("AA101","08:00","EWR", "BOS", 90, 120, "BOS", "EWR", 90);
//        print1(ac);
//    }
//    public static void print1(Aircraft ac1) {
//    	System.out.println("Aircraft ID: " + ac1.getAircraftId());
//        System.out.println("Route 1: " + ac1.getRoute1From() + " to " + ac1.getRoute1To());
//        System.out.println("Departure Time Route 1: " +ac1.getDepartTime());
//        ac1.setArrivalTime(ac1.getDepartTime(), ac1.getGapTimeAsInt());
//        System.out.println("Arrival Time Route 1: " + ac1.getArrivalTime());
//        System.out.println("Gap Time: " + ac1.getGapTime());
//        System.out.println("Route 2: " + ac1.getRoute2From() + " to " + ac1.getRoute2To());
//        ac1.setDepartTime(ac1.getArrivalTime(), ac1.getGapTimeAsInt());
//        System.out.println("Departure Time Route 2: " + ac1.getDepartTime());
//        ac1.setArrivalTime(ac1.getDepartTime(), ac1.getRoute2TravelTime());
//        System.out.println("Arrival Time Route 2: " + ac1.getArrivalTime());
//        System.out.println("\n");
//    }
//    public static void main1(String[] args) {
//        List<Connection> intermediateConnections = new ArrayList<>();
//        intermediateConnections.add(new Connection("LGA", "EWR", 45, 15));
//        intermediateConnections.add(new Connection("EWR", "JFK", 30, 10));
//
//        Aircraft ac = new Aircraft("AA201", "08:30", "JFK", "LGA", 60, 30,
//                intermediateConnections, "JFK", "BOS", 60);
//
//        // Print the details of the Aircraft
//        print(ac);
//    }
//
//    public static void print(Aircraft aircraft) {
//        System.out.println("Aircraft ID: " + aircraft.getAircraftId());
//        System.out.println("Route 1: " + aircraft.getRoute1From() + " to " + aircraft.getRoute1To());
//        // String dep_Time = aircraft.setDepartTime(aircraft.getDepartTime());
//        System.out.println("Departure Time Route 1: " + aircraft.getDepartTime());
//         aircraft.setArrivalTime(aircraft.getDepartTime(), aircraft.getRoute1TravelTime());
//        System.out.println("Arrival Time Route 1: " + aircraft.getArrivalTime());
//        System.out.println("Gap Time: " + aircraft.getGapTime());
//        // System.out.println("Departure Time Route 1: " + aircraft.getDepartureTimeRoute1());
//        // System.out.println("Arrival Time Route 1: " + aircraft.getArrivalTimeRoute1());
//        // System.out.println("Gap Time: " + aircraft.getGapTime());
//
//        List<Connection> intermediateConnections = aircraft.getIntermediateConnections();
//        String dep_TimeForConnection = LocalTime.parse(aircraft.getArrivalTime()).plusMinutes(aircraft.getGapTimeAsInt()).toString();
//        for (int i = 0; i < intermediateConnections.size(); i++) {
//            Connection connection = intermediateConnections.get(i);
//            connection.setDepartTime(dep_TimeForConnection);
//            connection.setArrivalTime(connection.getDepartTime());
//            System.out.println("Intermediate Connection " + (i + 1) + ": " + connection.getFromAirport() +
//                    " to " + connection.getToAirport());
//            // System.out.println("Departure Time: " + connection.getDepartTime(dep_TimeForConnection));
//            // System.out.println("Arrival Time: " + connection.getArrivalTime(dep_TimeForConnection));
//            System.out.println("Departure Time: " + connection.getDepartTime());
//            System.out.println("Arrival Time: " + connection.getArrivalTime());
//            System.out.println("Gap Time: " + connection.getGapTime());
//            dep_TimeForConnection = LocalTime.parse(connection.getArrivalTime()).plusMinutes(connection.getGapTime()).toString();
//        }
//         Connection lastConnection = intermediateConnections.get(intermediateConnections.size()-1);
//        // aircraft.calculateDepartureTime(lastConnection.getArrivalTime(), lastConnection.getGapTime());
//        aircraft.setDepartTime(lastConnection.getArrivalTime(), lastConnection.getGapTime());
//        System.out.println("Route 2: " + aircraft.getRoute2From() + " to " + aircraft.getRoute2To());
//        // System.out.println("Departure Time Route 2: " + aircraft.getDepartureTimeRoute2());
//        // System.out.println("Arrival Time Route 2: " + aircraft.getArrivalTimeRoute2());
//        // System.out.println("\n");
//        System.out.println("Departure Time Route 2: " + aircraft.getDepartTime());
//        aircraft.setArrivalTime(aircraft.getDepartTime(), aircraft.getRoute2TravelTime());
//        System.out.println("Arrival Time Route 2: " + aircraft.getArrivalTime());
//        System.out.println("\n");
//    }
//}
//
//
//public static void main1(String[] args){
//    Aircraft ac = new Aircraft("AA101","08:00","EWR", "BOS", 90, 120, "BOS", "EWR", 90);
//    print1(ac);
//}
//public static void print1(Aircraft ac1) {
//	System.out.println("Aircraft ID: " + ac1.getAircraftId());
//    System.out.println("Route 1: " + ac1.getRoute1From() + " to " + ac1.getRoute1To());
//    System.out.println("Departure Time Route 1: " +ac1.getDepartTime());
//    ac1.setArrivalTime(ac1.getDepartTime(), ac1.getGapTimeAsInt());
//    System.out.println("Arrival Time Route 1: " + ac1.getArrivalTime());
//    System.out.println("Gap Time: " + ac1.getGapTime());
//    System.out.println("Route 2: " + ac1.getRoute2From() + " to " + ac1.getRoute2To());
//    ac1.setDepartTime(ac1.getArrivalTime(), ac1.getGapTimeAsInt());
//    System.out.println("Departure Time Route 2: " + ac1.getDepartTime());
//    ac1.setArrivalTime(ac1.getDepartTime(), ac1.getRoute2TravelTime());
//    System.out.println("Arrival Time Route 2: " + ac1.getArrivalTime());
//    System.out.println("\n");
//}
//
//public static void main(String [] args){
//    List<Connection> intermediateConnections = new ArrayList<>();
//    intermediateConnections.add(new Connection("EWR", "BOS", 45, 60));
//    Aircraft ac = new Aircraft("AA302", "09:30", "PHL", "EWR", 60, 30, intermediateConnections, "BOS");
//    print3(ac);
//}
//public static void print3(Aircraft ac){
//    System.out.println("Aircraft ID: " + ac.getAircraftId());
//    System.out.println("route: " + ac.getFrom() + " to " + ac.getTo());
//
//    System.out.println("Departure Time: " + ac.getDepartTime());
//    ac.setArrivalTime(ac.getDepartTime(),ac.getTravelTime());
//    System.out.println("Arrival Time: " + ac.getArrivalTime());
//    System.out.println("Gap Time: " + ac.getGapTime());
//    
//    List<Connection> intermediateConnections = ac.getIntermediateConnections();
//    String dep_TimeForConnection = LocalTime.parse(ac.getArrivalTime()).plusMinutes(ac.getGapTimeAsInt()).toString();
//    for (int i = 0; i < intermediateConnections.size(); i++) {
//        Connection connection = intermediateConnections.get(i);
//        connection.setDepartTime(dep_TimeForConnection);
//        connection.setArrivalTime(connection.getDepartTime());
//        System.out.println("Intermediate Connection " + (i + 1) + ": " + connection.getFromAirport() +
//                " to " + connection.getToAirport());
//        // System.out.println("Departure Time: " + connection.getDepartTime(dep_TimeForConnection));
//        // System.out.println("Arrival Time: " + connection.getArrivalTime(dep_TimeForConnection));
//        System.out.println("Departure Time: " + connection.getDepartTime());
//        System.out.println("Arrival Time: " + connection.getArrivalTime());
//        System.out.println("Gap Time: " + connection.getGapTime());
//        dep_TimeForConnection = LocalTime.parse(connection.getArrivalTime()).plusMinutes(connection.getGapTime()).toString();
//    }
//    System.out.println("Dest Airport: " + ac.getDestAirport());
//}


//public class Aircraft {
////    private String aircraftId;
////    private String departureTime;
////    private String route1From;
////    private String route1To;
////    private int route1TravelTime;
////    private int gapTime;
////    private String route2From;
////    private String route2To;
////    private int route2TravelTime;s
////    private boolean isRoute1;
////    private boolean isRoute2;
//    private String aircraftId;
//    private String departureTime;
//    private String route1From;
//    private String route1To;
//    private int route1TravelTime;
//    private int gapTime;
//    private String route2From;
//    private String route2To;
//    private int route2TravelTime;
//    private boolean isRoute1;
//    private boolean isRoute2;
//    
////    public String route2DepartTime;
////    public String route2ArrivalTime;
////	private Connection connection;
//
//    public Aircraft(String aircraftId, String departureTime, String route1From, String route1To, int route1TravelTime, int gapTime,
//                    String route2From, String route2To, int route2TravelTime) {
//        this.aircraftId = aircraftId;
//        this.departureTime = departureTime;
//        this.route1From = route1From;
//        this.route1To = route1To;
//        this.route1TravelTime = route1TravelTime;
//        this.gapTime = gapTime;
//        this.route2From = route2From;
//        this.route2To = route2To;
//        this.route2TravelTime = route2TravelTime;
//    }
//    
//    public Aircraft(String aircraftId, String departureTime, String route1From, String route1To, int route1TravelTime, 
//    		Connection connection, int gapTime, String route2From, String route2To, int route2TravelTime) {
//    	
//    }
//    //connection = new Connection(airport, travelTime, gapTime);
////    public Aircraft(String aircraftId, String departureTime, String route1From, String route1To, int route1TravelTime,
////            int gapTime, Connection connection,
////            String route2From, String route2To, int route2TravelTime) {
////		this.aircraftId = aircraftId;
////		this.departureTime = departureTime;
////		this.route1From = route1From;
////		this.route1To = route1To;
////		this.route1TravelTime = route1TravelTime;
////		this.gapTime = gapTime;
////		
////		this.connection = connection;
////		connection.setDepartTime(calculateArrivalTime(departureTime, route1TravelTime, gapTime));
////		connection.setArrivalTime(calculateArrivalTime(connection.getDepartTime(), connection.getTravelTime(), connection.getGapTime()));
////		
////		
////		this.route2From = connection.getIntermediateAirport();
////		this.route2To = route2To;
////		this.route2TravelTime = route2TravelTime;
////		this.route2DepartTime = calculateDepartureTime(connection.getArrivalTime(), connection.getGapTime());
////		this.route2ArrivalTime = calculateArrivalTime(this.route2DepartTime, this.route2TravelTime);
////		// Establish connection with an intermediate airport
//////		String intermediateDepartureTime = calculateArrivalTime(departureTime, route1TravelTime, gapTime);
//////		String intermediateArrivalTime = calculateArrivalTime(intermediateDepartureTime, intermediateTravelTime, intermediateGapTime);
//////		
//////		// Add the intermediate connection
//////		System.out.println("Intermediate Connection: " + route1To + " to " + intermediateAirport);
//////		System.out.println("Departure Time: " + intermediateDepartureTime);
//////		System.out.println("Arrival Time: " + intermediateArrivalTime);
//////		System.out.println("Gap Time: " + intermediateGapTime);
//////		
//////		// Adjust departure time for route2 based on intermediate gap time
//////		String route2DepartureTime = calculateDepartureTime(intermediateArrivalTime, intermediateGapTime);
//////		String route2ArrivalTime = calculateArrivalTime(route2DepartureTime, route2TravelTime);
//////		this.route2From = intermediateAirport;
//////		this.route2To = route2To;
//////		this.route2TravelTime = route2TravelTime;
//////		// Add route2 connection
//////		System.out.println("Route 2: " + route2From + " to " + route2To);
//////		System.out.println("Departure Time Route 2: " + route2DepartureTime);
//////		// System.out.println("Arrival Time Route 2: " + calculateArrivalTime(route2DepartureTime, route2TravelTime));
//////		System.out.println("Arrival Time Route 2: " + route2ArrivalTime);
////	}
//    /*public Aircraft(String aircraftId, String departureTime, String route1From, String route1To, int route1TravelTime,
//            int gapTime, String intermediateAirport, int intermediateTravelTime, int intermediateGapTime,
//            String route2From, String route2To, int route2TravelTime) {
//		this.aircraftId = aircraftId;
//		this.departureTime = departureTime;
//		this.route1From = route1From;
//		this.route1To = route1To;
//		this.route1TravelTime = route1TravelTime;
//		this.gapTime = gapTime;
//		
//		// Establish connection with an intermediate airport
//		String intermediateDepartureTime = calculateArrivalTime(departureTime, route1TravelTime, gapTime);
//		String intermediateArrivalTime = calculateArrivalTime(intermediateDepartureTime, intermediateTravelTime, intermediateGapTime);
//		
//		// Add the intermediate connection
//		System.out.println("Intermediate Connection: " + route1To + " to " + intermediateAirport);
//		System.out.println("Departure Time: " + intermediateDepartureTime);
//		System.out.println("Arrival Time: " + intermediateArrivalTime);
//		System.out.println("Gap Time: " + intermediateGapTime);
//		
//		// Adjust departure time for route2 based on intermediate gap time
//		String route2DepartureTime = calculateDepartureTime(intermediateArrivalTime, intermediateGapTime);
//		String route2ArrivalTime = calculateArrivalTime(route2DepartureTime, route2TravelTime);
//		this.route2From = intermediateAirport;
//		this.route2To = route2To;
//		this.route2TravelTime = route2TravelTime;
//		// Add route2 connection
//		System.out.println("Route 2: " + route2From + " to " + route2To);
//		System.out.println("Departure Time Route 2: " + route2DepartureTime);
//		// System.out.println("Arrival Time Route 2: " + calculateArrivalTime(route2DepartureTime, route2TravelTime));
//		System.out.println("Arrival Time Route 2: " + route2ArrivalTime);
//	}*/
//
//	public String getAircraftId() {
//        return aircraftId;
//    }
//    
//    public boolean isRoute1() {
//		return isRoute1;
//	}
//
//	public void setRoute1(boolean isRoute1) {
//		this.isRoute1 = isRoute1;
//	}
//
//	public boolean isRoute2() {
//		return isRoute2;
//	}
//
//	public void setRoute2(boolean isRoute2) {
//		this.isRoute2 = isRoute2;
//	}
//
//	public String getAirlineId() {
//    	return aircraftId.substring(0,2);
//    }
//    public String getRoute1From() {
//        return route1From;
//    }
//
//    public String getRoute1To() {
//        return route1To;
//    }
//
//    public int getRoute1TravelTime() {
//        return route1TravelTime;
//    }
//
//    public String getGapTime() {
//    	Duration duration = Duration.ofMinutes(gapTime);
//        long hours = duration.toHours();
//        long minutes = duration.toMinutesPart();
//
//        return String.format("%02d:%02d", hours, minutes);
//    }
//
//    public String getRoute2From() {
//        return route2From;
//    }
//
//    public String getRoute2To() {
//        return route2To;
//    }
//
//    public int getRoute2TravelTime() {
//        return route2TravelTime;
//    }
//
//    public String getDepartureTimeRoute1() {
//        return this.departureTime;
//    }
//
//    public String getArrivalTimeRoute1() {
//        return calculateArrivalTime(getDepartureTimeRoute1(), route1TravelTime);
//    }
//
//    public String getDepartureTimeRoute2() {
//        return calculateDepartureTime(getArrivalTimeRoute1(), gapTime);
//    }
//
//    public String getArrivalTimeRoute2() {
//        return calculateArrivalTime(getDepartureTimeRoute2(), route2TravelTime);
//    }
//
//    public String calculateArrivalTime(String departureTime, int travelTime) {
//        return LocalTime.parse(departureTime).plusMinutes(travelTime).toString();
//    }
//
//    public String calculateDepartureTime(String arrivalTime, int gapTime) {
//        return LocalTime.parse(arrivalTime).plusMinutes(gapTime).toString();
//    }
//    public String calculateArrivalTime(String departureTime, int travelTime, int gapTime) {
//        LocalTime calculatedTime = LocalTime.parse(departureTime).plusMinutes(travelTime + gapTime);
//        return calculatedTime.toString();
//    }
//    
////    public Connection getConnection() {
////    	return this.connection;
////    }
//    
////    public String getConnectionDepartureTime() {
////        return connection.computeDepartureTime(this);
////    }
//
//    public static void main(String[] args) {
////        Aircraft ac1 = new Aircraft("AA101","08:00","EWR", "BOS", 120, 140, "BOS", "EWR", 120);
////        Aircraft ac2 = new Aircraft("AA102", "09:00", "EWR", "PHL", 90, 160, "PHL", "EWR",90);
////        Aircraft ac3 = new Aircraft("AA103","10:00","EWR","LGA", 105, 120, "LGA", "EWR", 105);
////        Aircraft ac4 = new Aircraft("DA401","9:30","EWR", "JFK", 60, 150, "JFK", "EWR" , 60);
////        Aircraft ac5 = new Aircraft("DA402", "10:45", "PHL", "BOS", 150, 180, "BOS", "PHL", 150);
////        Aircraft ac6 = new Aircraft("DA403", "11:00", "PHL", "LGA", 100, 120, "LGA", "PHL", 100);
////        Aircraft ac7 = new Aircraft("UA501", "11:15", "PHL", "JFK", 90, 150, "JFK", "PHL", 90);
////        Aircraft ac8 = new Aircraft("UA502", "10:30", "BOS", "LGA", 110, 190, "LGA", "BOS",110);
////        Aircraft ac9 = new Aircraft("UA503", "12:30", "BOS", "JFK", 120, 140, "JFK", "BOS",120);
////        Aircraft ac10 = new Aircraft("SA431", "10:30", "LGA", "JFK", 60, 160, "JFK", "LGA", 60);
//        Aircraft [] acs = {
//        		new Aircraft("AA101","08:00","EWR", "BOS", 120, 140, "BOS", "EWR", 120),
//        		new Aircraft("AA102", "09:00", "EWR", "PHL", 90, 160, "PHL", "EWR",90),
//        		new Aircraft("AA103","10:00","EWR","LGA", 105, 120, "LGA", "EWR", 105),
//        		new Aircraft("DA401","09:30","EWR", "JFK", 60, 150, "JFK", "EWR" , 60),
//        		new Aircraft("DA402", "10:45", "PHL", "BOS", 150, 180, "BOS", "PHL", 150),
//        		new Aircraft("DA403", "11:00", "PHL", "LGA", 100, 120, "LGA", "PHL", 100),
//        		new Aircraft("UA501", "11:15", "PHL", "JFK", 90, 150, "JFK", "PHL", 90),
//        		new Aircraft("UA502", "10:30", "BOS", "LGA", 110, 190, "LGA", "BOS",110),
//        		new Aircraft("UA503", "12:30", "BOS", "JFK", 120, 140, "JFK", "BOS",120),
//        		new Aircraft("SA431", "10:30", "LGA", "JFK", 60, 160, "JFK", "LGA", 60)
//        };
//        
//        for(int i =0; i< acs.length; i++) {
//        	print(acs[i]);
//        }
//        String departAirport = "PHL";
//        String arrivalAirport = "BOS";
//        for(int i =0; i < acs.length; i++) {
//        	if(acs[i].route1From.equals(departAirport) && acs[i].route1To.equals(arrivalAirport)){
//        		print(acs[i]);
//        		break;
//        	}
//        }
//    }
//    public static void print(Aircraft ac1) {
//    	System.out.println("Aircraft ID: " + ac1.getAircraftId());
//        System.out.println("Route 1: " + ac1.getRoute1From() + " to " + ac1.getRoute1To());
//        System.out.println("Departure Time Route 1: " + ac1.getDepartureTimeRoute1());
//        System.out.println("Arrival Time Route 1: " + ac1.getArrivalTimeRoute1());
//        System.out.println("Gap Time: " + ac1.getGapTime());
//        System.out.println("Route 2: " + ac1.getRoute2From() + " to " + ac1.getRoute2To());
//        System.out.println("Departure Time Route 2: " + ac1.getDepartureTimeRoute2());
//        System.out.println("Arrival Time Route 2: " + ac1.getArrivalTimeRoute2());
//        System.out.println("\n");
//    }
//    public static void main1(String[] args) {
//    	//Connection intermediateConnection = new Connection("LGA", "PHL", "10:00", 45, 60);
//    	Connection intermediateConnection = new Connection("PHL", 45, 60);
//        Aircraft aircraft = new Aircraft(
//                "AA201", "08:30", "JFK", "LGA", 60, 30,
//                intermediateConnection, "PHL", "BOS", 90
//        );
//
//        // Print the details of the Aircraft
//        print1(aircraft);
//    }
//    public static void print1(Aircraft ac1) {
//    	System.out.println("Aircraft ID: " + ac1.getAircraftId());
//        System.out.println("Route 1: " + ac1.getRoute1From() + " to " + ac1.getRoute1To());
//        System.out.println("Departure Time Route 1: " + ac1.getDepartureTimeRoute1());
//        System.out.println("Arrival Time Route 1: " + ac1.getArrivalTimeRoute1());
//        System.out.println("Gap Time: " + ac1.getGapTime());
//        
//        System.out.println("Intermediate Connection: " + ac1.route1To + " to " + ac1.getConnection().getIntermediateAirport());
//		System.out.println("Departure Time: " + ac1.getConnection().getDepartTime());
//		System.out.println("Arrival Time: " + ac1.getConnection().getArrivalTime());
//		System.out.println("Gap Time: " + ac1.getConnection().getGapTime());
//		
//		System.out.println("Route 2: " + ac1.getRoute2From() + " to " + ac1.getRoute2To());
//        System.out.println("Departure Time Route 2: " + ac1.route2DepartTime);
//        System.out.println("Arrival Time Route 2: " + ac1.route2ArrivalTime);
//        System.out.println("\n");
//    }
//}
    
//    public static void main(String[] args) {
//        // Example usage
//        Connection connection = new Connection("JFK", "BOS", 45);
//
//        Aircraft aircraft = new Aircraft("AA101", "08:00", "EWR", "JFK", 60,
//                connection, 15, "JFK", "BOS", 90);
//
//        System.out.println(aircraft.getConnectionDepartureTime());
//    }
//}



/*
 * import java.time.LocalTime;
import java.util.List;

 class Connection {
    private String fromAirport;
    private String toAirport;
    private int travelTime;
    private int gapTime;

    public Connection(String fromAirport, String toAirport, int travelTime, int gapTime) {
        this.fromAirport = fromAirport;
        this.toAirport = toAirport;
        this.travelTime = travelTime;
        this.gapTime = gapTime;
    }

    public String getFromAirport() {
        return fromAirport;
    }

    public String getToAirport() {
        return toAirport;
    }

    public int getTravelTime() {
        return travelTime;
    }

    public int getGapTime() {
        return gapTime;
    }

    // Calculate arrival time based on departure time and travel time
    public String calculateArrivalTime(String departureTime) {
        return LocalTime.parse(departureTime).plusMinutes(travelTime).toString();
    }

    // Calculate departure time based on arrival time and gap time
    public String calculateDepartureTime(String arrivalTime) {
        return LocalTime.parse(arrivalTime).plusMinutes(gapTime).toString();
    }

    @Override
    public String toString() {
        return "Connection{" +
                "fromAirport='" + fromAirport + '\'' +
                ", toAirport='" + toAirport + '\'' +
                ", travelTime=" + travelTime +
                ", gapTime=" + gapTime +
                '}';
    }
}

public class Aircraft {
    private String departAirport;
    private String destinationAirport;
    private String aircraftId;
    private String departureTime;
    private List<Connection> connections;

    public Aircraft(String departAirport, String destinationAirport, String aircraftId, String departureTime, List<Connection> connections) {
        this.departAirport = departAirport;
        this.destinationAirport = destinationAirport;
        this.aircraftId = aircraftId;
        this.departureTime = departureTime;
        this.connections = connections;
    }

    public String getDepartAirport() {
        return departAirport;
    }

    public String getDestinationAirport() {
        return destinationAirport;
    }

    public String getAircraftId() {
        return aircraftId;
    }

    public String getDepartureTime() {
        return departureTime;
    }

    public List<Connection> getConnections() {
        return connections;
    }

    // Calculate arrival time based on departure time and travel time
    public String calculateArrivalTime(String departureTime, int travelTime) {
        return LocalTime.parse(departureTime).plusMinutes(travelTime).toString();
    }

    // Calculate arrival time at the final destination
    public String calculateFinalArrivalTime() {
        String arrivalTime = departureTime;
        for (int i = 0; i < connections.size(); i++) {
        arrivalTime = connections.get(i).calculateArrivalTime(arrivalTime);
        if (i < connections.size() - 1) {
            arrivalTime = connections.get(i).calculateDepartureTime(arrivalTime); // Account for the gap time
        }
        }
        return arrivalTime;
    }

    // Override toString() for better representation
    @Override
    public String toString() {
        return "Aircraft{" +
                "departAirport='" + departAirport + '\'' +
                ", destinationAirport='" + destinationAirport + '\'' +
                ", aircraftId='" + aircraftId + '\'' +
                ", departureTime='" + departureTime + '\'' +
                ", connections=" + connections +
                '}';
    }



    public static void main(String[] args) {
        // Create connections
        Connection connection1 = new Connection("EWR", "BOS", 60, 120);
        Connection connection2 = new Connection("BOS", "JFK", 30, 120);

        // Create aircraft with connections
        Aircraft aircraft = new Aircraft("EWR", "JFK", "AA101", "08:00", List.of(connection1, connection2));

        // Print aircraft details
        System.out.println(aircraft);
        System.out.println("Final Arrival Time: " + aircraft.calculateFinalArrivalTime());
    }
}

 * */
 