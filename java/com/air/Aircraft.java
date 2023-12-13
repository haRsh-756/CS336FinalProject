package com.air;

import java.time.Duration;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;


public class Aircraft{
	private String aircraft_id;
	private int num_seats;
	public Aircraft(String aircraft_id, int num_seats) {
		this.aircraft_id = aircraft_id;
		this.num_seats = num_seats;
	}
	public String getAircraft_id() {
		return aircraft_id;
	}
	public void setAircraft_id(String aircraft_id) {
		this.aircraft_id = aircraft_id;
	}
	public int getNum_seats() {
		return num_seats;
	}
	public void setNum_seats(int num_seats) {
		this.num_seats = num_seats;
	}
}
