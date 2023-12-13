package com.air;

import java.sql.Time;
import java.util.Date;

public class Ticket {
	//private String username;
    //private String fromAirport;
    //private String toAirport;
    //private Date fromDate;
    //private Time fromTime;
    //private String airlineId;
    //private String aircraftId;
    //private int flightNum;
    private int seatNum;
    private Flight flight;
    private String ticketClass;
    //private String firstName;
    //private String lastName;
    //private int idNum;
    private Customer customer;
    private float totalFare;
    private String purchaseDate;
    private String purchaseTime;
    private int ticketNum;
    //private int numStops;
    
    
    public Ticket(int seatNum, Flight flight, String ticketClass, Customer customer, float totalFare,
			String purchaseDate, String purchaseTime) {
		super();
		this.seatNum = seatNum;
		this.flight = flight;
		this.ticketClass = ticketClass;
		this.customer = customer;
		this.totalFare = totalFare;
		this.purchaseDate = purchaseDate;
		this.purchaseTime = purchaseTime;
	}
	public int getSeatNum() {
		return seatNum;
	}
	
	public int getTicketNum() {
		return ticketNum;
	}
	public void setTicketNum(int ticketNum) {
		this.ticketNum = ticketNum;
	}
	public void setSeatNum(int seatNum) {
		this.seatNum = seatNum;
	}
	public Flight getFlight() {
		return flight;
	}
	public void setFlight(Flight flight) {
		this.flight = flight;
	}
	public String getTicketClass() {
		return ticketClass;
	}
	public void setTicketClass(String ticketClass) {
		this.ticketClass = ticketClass;
	}
	public Customer getCustomer() {
		return customer;
	}
	public void setCustomer(Customer customer) {
		this.customer = customer;
	}
	public float getTotalFare() {
		return totalFare;
	}
	public void setTotalFare(float totalFare) {
		this.totalFare = totalFare;
	}
	public String getPurchaseDate() {
		return purchaseDate;
	}
	public void setPurchaseDate(String purchaseDate) {
		this.purchaseDate = purchaseDate;
	}
	public String getPurchaseTime() {
		return purchaseTime;
	}
	public void setPurchaseTime(String purchaseTime) {
		this.purchaseTime = purchaseTime;
	}
	
}
