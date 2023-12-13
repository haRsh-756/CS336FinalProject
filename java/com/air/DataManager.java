package com.air;

import java.util.ArrayList;
import java.util.List;

/**
 * singleton class that manages the data
 * data will be of menuItem and Order objects
 * @author harsh_patel, giancarlo_andretta
 */
public final class DataManager {
    /**
     * class instance
     */
    private static DataManager instance = null;
    
    private static int flightNum = 1010;
    private static int ticketNum = 111;
    private static int cusID = 10011;
    
    private List<Flight> flights = new ArrayList<>();

    /**
     * default constructor
     */
    private DataManager() {
        // private constructor to prevent instantiation from outside
    }

    /**
     * static class method to getInstance of final object
     * @return instance of DataManger
     */
    public static synchronized DataManager getInstance() {
        if (instance == null) {
            instance = new DataManager();
        }
        return instance;
    }

    /**
     * generates unique flight number
     * @return flight number
     */
    public int generateFlightNum(){
        return flightNum++;
    }
    
	public List<Flight> getFlights() {
		return flights;
	}

	public void setFlights(List<Flight> flights) {
		this.flights = flights;
	}

	public int getTicketNum() {
		return ticketNum++;
	}
	public int getCusID() {
		return cusID++;
	}

}