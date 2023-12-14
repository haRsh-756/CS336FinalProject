<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.air.*" import="java.util.*" import="java.sql.*"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Flight Search Page</title>
    <!-- jQuery UI CSS -->
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <style>
        /* Add your custom styles here */
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        label {
            display: block;
            margin-bottom: 8px;
        }
        input {
            padding: 8px;
            margin-bottom: 16px;
        }
        button {
            padding: 10px;
            background-color: #4CAF50;
            color: white;
            border: none;
            cursor: pointer;
        }
        .custom-button {
        	padding: 10px;
            background-color: #4CAF50;
            color: white;
            border: none;
            cursor: pointer;
        }
        #dateRangeContainer {
            display: flex;
            align-items: center;
        }
        #filter {
         	display: flex;
         	padding: 10px;
            /* width: 800px;
            margin: 10px auto; */
            align-items: center;
        }
        /* #flightFilterForm {
            display: flex;
            width: 800px;
            margin: 20px auto;
        } */
		
                 
        /* #flightFilterForm input[type="submit"] {
            background-color: #4CAF50;
            color: white;
            cursor: pointer;
            width: auto;
        } */
        
    </style>
</head>
<body>

	
	<%
	if ((session.getAttribute("user") == null)) {
	%>
	You are not logged in<br/>
	<a href="custLogin.jsp">Please Login</a>
	<%}
	else {%>
		Welcome <%= session.getAttribute("user")%>
		<a href='custLogout.jsp'><button>Logout</button></a>
		<a href='custSuccess.jsp'><button>Back</button></a>
	<%}%>
	
	<%@ page import="java.sql.*" %>
	<!-- <form action="displayFlights.jsp" method="POST"> -->
		<form action="displayFlights.jsp" method="POST">
		<label for="flightType">Flight Type:</label>
		<select id="flightType" name="flightType" onchange="toggleDateInput()">
	    	<option value="One Way">One Way</option>
		    <option value="Round Trip">Round Trip</option>
		    <option value="flexibleOneWay">One way Flexible +/- 3 days</option>
		    <option value="flexibleRound">Round trip Flexible +/- 3 days</option>
		</select><br><br>
	    
		<input type="hidden" id="selectedDepartAirport" name="selectedDepartAirport">
	 	<label for="depart">Departure Airport:</label>
	    <input type="text" id="depart" name="depart" placeholder="eg. EWR,PHL,LGA" required>
	    <!-- <button type="button" id="checkDepart">Check Depart Airport</button> -->
	    <!-- <div id="departResult"></div> -->
	
	    <br><br>
		<input type="hidden" id="selectedArrivalAirport" name="selectedArrivalAirport" value="">
	    <label for="arrive">Arrival Airport:</label>
	    <input type="text" id="arrive" name="arrive" placeholder="eg. BOS,JFK,EWR" required>
	    <!-- <button type="button" id="checkArrive">Check Arrive Airport</button>
	    <div id="arriveResult"></div> -->
	
		<br><br>
	    
		
		<label for="cabinClass">Cabin Class:</label>
	    <select id="cabinClass" name="cabinClass" required>
	    	<option value="" disabled selected>Select Cabin class</option>
	      <option value="Economy">Economy</option>
	      <option value="Business">Business</option>
	      <option value="FirstClass">First Class</option>
	    </select><br><br>
	    
		<div id="dateRangeContainer">
		    <div>
		        <label for="departDate">Departure Date:</label>
		        <input type="text" id="departDate" name="departDate" placeholder="MM-DD-YYYY" required>
		    </div><br>
		    <div>
		        <label for="returnDate">Return Date:</label>
		        <input type="text" id="returnDate" name="returnDate" placeholder="MM-DD-YYYY" disabled required>
			</div>
		</div><br>
		<!-- <button onclick="displayFlights.jsp">Search Flights</button> -->
		<input type="hidden" name="formType" value="Search Flights">
		<input type="submit" name="searchButton" value="Search Flights" class="custom-button"/>
	
		
		<br>
		<h3>Filter By</h3>
			<div id="filter"><!-- <form id="flightFilterForm" action="displayFlights.jsp" method="post" onsubmit="return validateForm()"> -->
		    <label for="maxPrice">Maximum Price:</label>
		    <input type="text" name="maxPrice" id="maxPrice">
			 <label for="maxStops">Maximum Stops:</label>
		    <input type="text" name="maxStops" id="maxStops">
			 <label for="airline">Airline:</label>
		    <input type="text" name="airline" id="airline" placeholder="AA, DA, UA">
		    <label for="takeOffTime">Take-off Time:</label>
		    <input type="text" name="takeOffTime" id="takeOffTime" placeholder= "00:00">
		    <label for="landingTime">Landing Time:</label>
		    <input type="text" name="landingTime" id="landingTime" placeholder ="00:00">
		    </div><br>
		    <input type="hidden" name="formType" value="Filter Flights">
		    <input type="submit" name="filterButton" value="Filter Flights" class="custom-button" onclick="return validateForm()"/>
		</form>
		<%
		    ApplicationDB db = new ApplicationDB();
		    java.sql.Connection con = db.getConnection();
		    List<String> airportNames = new ArrayList<>();
		
		    try {
		        Statement st = con.createStatement();
		        ResultSet rs = st.executeQuery("SELECT airport_id FROM airport");
		
		        while (rs.next()) {
		            airportNames.add(rs.getString("airport_id"));
		        }
		
		        rs.close();
		        st.close();
		    } catch (Exception e) {
		        e.printStackTrace();
		    } finally {
		        con.close();
		    }
		
		    // Convert the list to a JavaScript array
		    String airportNamesArray = "[\"" + String.join("\",\"", airportNames) + "\"]";
		    //System.out.println(airportNamesArray);
		%>
	<script>
		
		var availableAirports = <%=airportNamesArray %>;
		var arrivalAirports;
		//$("#arrive").prop("disabled", true);
		$("#depart").each(function(i, el) {
		    var that = $(el);
		   // var availableAirports =;
		    that.autocomplete({
		        source: availableAirports,
		        select: function( event , ui ) {
		        	var selectedDeparture = ui.item.value;
		        	$("#selectedDepartAirport").val(selectedDeparture);
		        	console.log(selectedDeparture);
		        	// Create Arrival Airport array (exclude selected departure)
	                arrivalAirports = availableAirports.filter(function (airport) {
	                    return airport !== selectedDeparture;
	                });
	                console.log(availableAirports);
	                console.log(arrivalAirports);
	                $("#arrive").autocomplete("option", "source", arrivalAirports);
		        }
	                // Initialize Autocomplete for Arrival Airport  
		    });
		});
		$("#arrive").each(function(i, el) {
		    var that = $(el);
		    that.autocomplete({
		        source: arrivalAirports,
			    select: function( event , ui ) {
			    	var selectedArrival = ui.item.value;
			    	console.log(selectedArrival);
		        	$("#selectedArrivalAirport").val(selectedArrival);
			    }
	    	});
		});
		
		
		$(document).ready(function () {
		    // Initialize datepickers
		    $("#departDate").datepicker({
		    	dateFormat: "yy-mm-dd"
		        /* dateFormat: "mm-dd-yy" */,
		        changeMonth: true,
		        changeYear: true,
		        showButtonPanel: true,
		        minDate: new Date(), // Set minimum date to today's date
		        onSelect: function (selectedDate) {
		            // Set the minimum date for the end datepicker to the selected start date
		            $("#returnDate").datepicker("option", "minDate", selectedDate);
		            // Disable or enable the end datepicker based on the flight type
		            toggleDateInput();
		        }
		    });
	
		    $("#returnDate").datepicker({
		        //dateFormat: "mm-dd-yy"
		        dateFormat: "yy-mm-dd",
		        changeMonth: true,
		        changeYear: true,
		        showButtonPanel: true,
		        minDate: new Date(), // Set minimum date to today's date
		    });
		});
		
		function toggleDateInput() {
	        var flightType = $("#flightType").val();
	        //var arrival = $("#arrive").val();
	        if (flightType === "One Way" || flightType === "flexibleOneWay") {
	            $("#returnDate").prop("disabled", true);
	            $("#returnDate").val(null);
	            //$("#arrive").val("").prop("disabled", true);
	            //$("#selectedArrivalAirport").val("");
	        } else{
	            $("#returnDate").prop("disabled", false);
	           // $("#arrive").prop("disabled", false);
	        }
	    }
		function validateForm() {
            var maxPrice = document.getElementById("maxPrice").value;
            var maxStops = document.getElementById("maxStops").value;
            var airline = document.getElementById("airline").value;
            var takeOffTime = document.getElementById("takeOffTime").value;
            var landingTime = document.getElementById("landingTime").value;

            // At least one field is required
            if (!maxPrice && !maxStops && !airline && !takeOffTime && !landingTime) {
                alert("Please fill in at least one field in Filter by before submitting.");
                return false;
            }

            return true;
        }
	</script>
	
</body>
</html>
