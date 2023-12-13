package com.air;

import java.util.*;

public class Customer {
    private int customerID;
    private String firstName;
    private String lastName;
    private String username;
    //private Portfolio portfolio;
    private List<Ticket> flightTickets;

    public Customer(int cusID, String username, String firstName, String lastName) {
    	this.customerID = cusID;
    	this.firstName = firstName;
    	this.lastName = lastName;
    	this.username = username;
    	this.flightTickets = new ArrayList<>();
    }

	public int getCustomerID() {
		return customerID;
	}

	public void setCustomerID(int customerID) {
		this.customerID = customerID;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public List<Ticket> getFlightTickets() {
		return flightTickets;
	}

	public void setFlightTickets(List<Ticket> flightTickets) {
		this.flightTickets = flightTickets;
	}
    
}   
    // Getters
//    public int getCustomerID() {
//        return customerID;
//    }
//
//    public String getFirstName() {
//        return firstName;
//    }
//
//    public String getLastName() {
//        return lastName;
//    }
//
//    public String getName() {
//        return name;
//    }
//
//    /*public Portfolio getPortfolio() {
//        return portfolio;
//    }*/
//
//    // Setters
//    public void setCustomerID(int customerID) {
//        this.customerID = customerID;
//    }
//
//    public void setFirstName(String firstName) {
//        this.firstName = firstName;
//        this.name = firstName + " " + this.lastName; // Update 'name' accordingly
//    }
//
//    public void setLastName(String lastName) {
//        this.lastName = lastName;
//        this.name = this.firstName + " " + lastName; // Update 'name' accordingly
//    }

 // Constructor with Portfolio
    /*public Customer(int customerID, String firstName, String lastName, Portfolio portfolio) {
        this.customerID = customerID;
        this.firstName = firstName;
        this.lastName = lastName;
        this.name = firstName + " " + lastName;
        this.portfolio = portfolio;
        flightTickets = new ArrayList<>();
    }*/
    
    // Constructor without Portfolio
//    public Customer(int customerID, String firstName, String lastName) {
//        this.customerID = customerID;
//        this.firstName = firstName;
//        this.lastName = lastName;
//        this.name = firstName + " " + lastName;
//        //this.portfolio = new Portfolio(); // Assuming default constructor for Portfolio
//    }
    /*public void setPortfolio(Portfolio portfolio) {
        this.portfolio = portfolio;
    }*/

    /*public boolean addFlight(int number, boolean isDomestic, Airport departure, Airport destination, LocalDateTime arrivalTime, LocalDateTime departureTime){
        //
    }*/

    // Additional methods can be added as needed