package com.air;

import java.time.Duration;
import java.time.LocalTime;

public class Connection{
	private String fromAirport;
    private String toAirport;
    private int travelTime;
    private int gapTime;
    private String departTime;
    private String arrivalTime;

    public Connection(String fromAirport, String toAirport, int travelTime, int gapTime) {
        this.fromAirport = fromAirport;
        this.toAirport = toAirport;
        this.travelTime = travelTime;
        this.gapTime = gapTime;
    }
    public String getFromAirport() {
        return fromAirport;
    }
    public void setFromAirport(String fromAirport){
        this.fromAirport = fromAirport;
    }
    public void setToAirport(String toAirport){
        this.toAirport = toAirport;
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
    public String GapTime() {
        Duration duration = Duration.ofMinutes(gapTime);
        long hours = duration.toHours();
        long minutes = duration.toMinutesPart();

        return String.format("%02d:%02d", hours, minutes);
    }
    public void setDepartTime(String previousArrivalTime){
        this.departTime = LocalTime.parse(previousArrivalTime).toString();
    }
    public void setArrivalTime(String departTime){
        this.arrivalTime = LocalTime.parse(departTime).plusMinutes(travelTime).toString();
    }
    public String getDepartTime(){
        return this.departTime;
    }
    public String getArrivalTime(){
        return this.arrivalTime;
    }
}
//	private String fromAirport;
//    private String toAirport;
//    private int travelTime;
//    private int gapTime;
//    private String departTime;
//    private String arrivalTime;
//
//    public Connection(String fromAirport, String toAirport, int travelTime, int gapTime) {
//        this.fromAirport = fromAirport;
//        this.toAirport = toAirport;
//        this.travelTime = travelTime;
//        this.gapTime = gapTime;
//    }
//
//    public String getFromAirport() {
//        return fromAirport;
//    }
//
//    public String getToAirport() {
//        return toAirport;
//    }
//
//    public int getTravelTime() {
//        return travelTime;
//    }
//
//    public int getGapTime() {
//        return gapTime;
//    }
//    public void setDepartTime(String previousArrivalTime){
//        this.departTime = LocalTime.parse(previousArrivalTime).toString();
//    }
//    public void setArrivalTime(String departTime){
//        this.arrivalTime = LocalTime.parse(departTime).plusMinutes(travelTime).toString();
//    }
//    public String getDepartTime(){
//        return this.departTime;
//    }
//    public String getArrivalTime(){
//        return this.arrivalTime;
//    }
