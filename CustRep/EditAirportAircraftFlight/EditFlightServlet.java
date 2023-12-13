@WebServlet("/EditFlightServlet")
public class EditFlightServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        try {
            switch (action) {
                case "add":
                    addFlight(request);
                    break;
                case "edit":
                    editFlight(request);
                    break;
                case "delete":
                    deleteFlight(request);
                    break;
                // other cases if needed
            }
        } catch (Exception e) {
            e.printStackTrace(); // Log the exception for debugging
            // Handle error gracefully and provide feedback to user
        }

        // Redirecting to a page (e.g., list of flights) after the action is complete
        response.sendRedirect("flightList.jsp");
    }

    private void addFlight(HttpServletRequest request) throws SQLException {
        // Retrieve all fields from the form
        String airlineId = request.getParameter("airline_id");
        String aircraftId = request.getParameter("aircraft_id");
        String fromAirport = request.getParameter("from_airport");
        String fromDate = request.getParameter("from_date");
        String fromTime = request.getParameter("from_time");
        String toAirport = request.getParameter("to_airport");
        String toDate = request.getParameter("to_date");
        String toTime = request.getParameter("to_time");
        int numSeats = Integer.parseInt(request.getParameter("num_seats"));
        boolean isDomestic = request.getParameter("is_domestic").equals("1");
        int flightNum = Integer.parseInt(request.getParameter("flight_num"));
        String flightType = request.getParameter("flight_type");
        int numStops = Integer.parseInt(request.getParameter("num_stops"));
        float ecoPrice = Float.parseFloat(request.getParameter("eco_price"));
        float busPrice = Float.parseFloat(request.getParameter("bus_price"));
        float firPrice = Float.parseFloat(request.getParameter("fir_price"));

        // SQL query to insert a new flight record
        try (Connection con = Database.getConnection();
             PreparedStatement ps = con.prepareStatement("INSERT INTO flights (airline_id, aircraft_id, from_airport, from_date, from_time, to_airport, to_date, to_time, num_seats, is_domestic, flight_num, flight_type, num_stops, eco_price, bus_price, fir_price) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)")) {
            ps.setString(1, airlineId);
            ps.setString(2, aircraftId);
            ps.setString(3, fromAirport);
            ps.setString(4, fromDate);
            ps.setString(5, fromTime);
            ps.setString(6, toAirport);
            ps.setString(7, toDate);
            ps.setString(8, toTime);
            ps.setInt(9, numSeats);
            ps.setBoolean(10, isDomestic);
            ps.setInt(11, flightNum);
            ps.setString(12, flightType);
            ps.setInt(13, numStops);
            ps.setFloat(14, ecoPrice);
            ps.setFloat(15, busPrice);
            ps.setFloat(16, firPrice);

            ps.executeUpdate();
        }
    }

    private void editFlight(HttpServletRequest request) throws SQLException {
        // Retrieve all fields from the form
        String airlineId = request.getParameter("airline_id");
        String aircraftId = request.getParameter("aircraft_id");
        String fromAirport = request.getParameter("from_airport");
        String fromDate = request.getParameter("from_date");
        String fromTime = request.getParameter("from_time");
        String toAirport = request.getParameter("to_airport");
        String toDate = request.getParameter("to_date");
        String toTime = request.getParameter("to_time");
        int numSeats = Integer.parseInt(request.getParameter("num_seats"));
        boolean isDomestic = request.getParameter("is_domestic").equals("1");
        int flightNum = Integer.parseInt(request.getParameter("flight_num"));
        String flightType = request.getParameter("flight_type");
        int numStops = Integer.parseInt(request.getParameter("num_stops"));
        float ecoPrice = Float.parseFloat(request.getParameter("eco_price"));
        float busPrice = Float.parseFloat(request.getParameter("bus_price"));
        float firPrice = Float.parseFloat(request.getParameter("fir_price"));

        // SQL query to update an existing flight record
        try (Connection con = Database.getConnection();
             PreparedStatement ps = con.prepareStatement("UPDATE flights SET airline_id = ?, aircraft_id = ?, from_airport = ?, from_date = ?, from_time = ?, to_airport = ?, to_date = ?, to_time = ?, num_seats = ?, is_domestic = ?, flight_type = ?, num_stops = ?, eco_price = ?, bus_price = ?, fir_price = ? WHERE flight_num = ?")) {
            ps.setString(1, airlineId);
            ps.setString(2, aircraftId);
            ps.setString(3, fromAirport);
            ps.setString(4, fromDate);
            ps.setString(5, fromTime);
            ps.setString(6, toAirport);
            ps.setString(7, toDate);
            ps.setString(8, toTime);
            ps.setInt(9, numSeats);
            ps.setBoolean(10, isDomestic);
            ps.setString(11, flightType);
            ps.setInt(12, numStops);
            ps.setFloat(13, ecoPrice);
            ps.setFloat(14, busPrice);
            ps.setFloat(15, firPrice);
            ps.setInt(16, flightNum);

            ps.executeUpdate();
        }
    }


    private void deleteFlight(HttpServletRequest request) throws SQLException {
        int flightNum = Integer.parseInt(request.getParameter("flight_num"));

        // SQL query to delete a flight record
        try (Connection con = Database.getConnection();
             PreparedStatement ps = con.prepareStatement("DELETE FROM flights WHERE flight_num = ?")) {
            ps.setInt(1, flightNum);

            ps.executeUpdate();
        }
    }

    // Other methods...
}
