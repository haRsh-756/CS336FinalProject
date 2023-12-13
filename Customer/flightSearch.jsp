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
	    <input type="text" id="arrive" name="arrive" placeholder="eg. LGA,PHL,EWR" required>
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
		<input type="submit" value="Search Flights" class="custom-button"/>
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
	        } else {
	            $("#returnDate").prop("disabled", false);
	           // $("#arrive").prop("disabled", false);
	        }
	    }
	</script>
	
</body>
</html>
<!--/* $(document).ready(function () {
		    $("#checkDepart").click(function () {
		        validateAirport("depart");
		    });
		
		    $("#checkArrive").click(function () {
		        validateAirport("arrive");
		    });
		
		    function validateAirport(airportType) {
		        var airportCode = $("#" + airportType).val();
		
		        $.ajax({
		            type: "POST",
		            url: "checkAirport.jsp",
		            data: { airportCode: airportCode },
		            success: function (response) {
		                $("#" + airportType + "Result").html(response);
		            },
		            error: function () {
		                alert("Error during validation.");
		            }
		        });
		    }
		}); */
/*  $("#arrive").each(function(i, el) {
	    var that = $(el);
	    that.autocomplete({
        source: arrivalAirport
        select: function( event , ui ) {
        	var selectedDeparture = ui.item.value;
        	$("#selectedArrivalAirport").val(selectedDeparture);
        }
    }); */
		/*function updateArrivalOptions() {
		    var departureAirport = document.getElementById("depart").value;
		    var arrivalSelect = document.getElementById("arrive");
		
		    // Enable all options
		    for (var i = 0; i < arrivalSelect.options.length; i++) {
		        arrivalSelect.options[i].disabled = false;
		    }
		
		    // Disable the option with the same value as the selected departure airport
		    for (var i = 0; i < arrivalSelect.options.length; i++) {
		        if (arrivalSelect.options[i].value === departureAirport) {
		            arrivalSelect.options[i].disabled = true;
		            break;
		        }
		    }
		} */ -->
<%-- $(document).ready(function () {
	    var availableAirports = <%= airportNamesArray %>;
	    $("#depart").autocomplete({
	        source: availableAirports
	        select: function (event, ui) {
	            var selectedValue = ui.item.value;
	            console.log("Selected Value: " + selectedValue);
	        }
	    });
	 // Dynamically exclude selected depart airport for arrive autocomplete
	    var availableAirportsArrive = availableAirports.filter(function (airport) {
	        return airport !== "<%= departAirportCode %>";
	    });
	    var availableArrivalAirports = <%= arrivalList %>;
	    $("#arrive").autocomplete({
	        source: availableArrivalAirports
	    });
	}); --%>
<!-- <label for="depart">Departure Airport:</label>
    <select id="depart" name="depart" onchange="updateArrivalOptions()" required>
    	<option value="" disabled selected>Select Departure Airport</option>
        <option value="JFK">JFK</option>
    	<option value="EWR">EWR</option>
    	<option value="LGA">LGA</option>
    	<option value="PHL">PHL</option>
    	<option value="BOS">BOS</option>
    </select><br><br>

    <label for="arrive">Arrival Airport:</label>
    <select id="arrive" name="arrive" required>
     	<option value="" disabled selected>Select Arrival Airport</option>
        <option value="JFK">JFK</option>
    	<option value="EWR">EWR</option>
    	<option value="LGA">LGA</option>
    	<option value="PHL">PHL</option>
    	<option value="BOS">BOS</option>
    </select><br><br> -->
<!-- /* $(document).ready(function () {
	    // Initialize datepickers
	    $("#departDate").datepicker({
	        dateFormat: "mm-dd-yy",
	        changeMonth: true,
	        changeYear: true,
	        showButtonPanel: true,
	        onSelect: function (selectedDate) {
	            // Set the minimum date for the end datepicker to the selected start date
	            $("#returnDate").datepicker("option", "minDate", selectedDate);
	         	// Disable or enable the return datepicker based on the flight type
                toggleDateInput();
	        }
	    });
	
	    $("#returnDate").datepicker({
	        dateFormat: "mm-dd-yy",
	        changeMonth: true,
	        changeYear: true,
	        showButtonPanel: true,
	    });
	}); */ 
	/* function searchFlights() {
	    var departureAirport = document.getElementById("depart").value;
	    var arrivalAirport = document.getElementById("arrive").value;
	
	    // Check if both departure and arrival airports are selected
	    if (departureAirport === "" || arrivalAirport === "") {
	        alert("Please select both departure and arrival airports.");
	    } else {
	        // Perform flight search based on the selected airports
	        console.log("Searching flights from " + departureAirport + " to " + arrivalAirport);
	        // Implement your flight search logic here
	    }
	} */-->
<!-- /* function searchFlights() {
	    var startDate = $("#startDate").datepicker("getDate");
	    var endDate = $("#endDate").datepicker("getDate");
	
	    // Perform flight search based on the selected date range
	    console.log("Searching flights from " + startDate + " to " + endDate);
	    // Implement your flight search logic here
	} */ -->
<!-- <!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Date Picker Example</title>
    jQuery and jQuery UI CSS
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
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
        #dateRangeContainer {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
    </style>
</head>
<body>

<h2>Date Picker Example</h2>

<div id="dateRangeContainer">
    <div>
        <label for="startDate">Start Date:</label>
        <input type="text" id="startDate" name="startDate">
    </div>
    <div>
        <label for="endDate">End Date:</label>
        <input type="text" id="endDate" name="endDate">
    </div>
</div>

<button onclick="searchFlights()">Search Flights</button>

<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<script>
    $(document).ready(function () {
        // Initialize datepickers
        $("#startDate").datepicker({
            dateFormat: "yy-mm-dd",
            changeMonth: true,
            changeYear: true,
            showButtonPanel: true,
            onSelect: function (selectedDate) {
                // Set the minimum date for the end datepicker to the selected start date
                $("#endDate").datepicker("option", "minDate", selectedDate);
            }
        });

        $("#endDate").datepicker({
            dateFormat: "yy-mm-dd",
            changeMonth: true,
            changeYear: true,
            showButtonPanel: true,
        });
    });

    function searchFlights() {
        var startDate = $("#startDate").datepicker("getDate");
        var endDate = $("#endDate").datepicker("getDate");

        // Perform flight search based on the selected date range
        console.log("Searching flights from " + startDate + " to " + endDate);
        // Implement your flight search logic here
    }
</script>

</body>
</html> -->
    
    
    
    
    
    
    
    
    
    
 
