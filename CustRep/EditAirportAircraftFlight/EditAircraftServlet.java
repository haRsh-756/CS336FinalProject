@WebServlet("/AircraftServlet")
public class AircraftServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        try {
            switch (action) {
                case "add":
                    addAircraft(request);
                    break;
                case "edit":
                    editAircraft(request);
                    break;
                case "delete":
                    deleteAircraft(request);
                    break;
                // other cases
            }
        } catch (Exception e) {
            e.printStackTrace(); // Log the exception for debugging
            // Handle error gracefully and provide feedback to user
        }

        // Redirecting to a page (e.g., list of aircrafts) after the action is complete
        response.sendRedirect("aircraftList.jsp");
    }

    private void addAircraft(HttpServletRequest request) throws SQLException {
        String aircraftId = request.getParameter("aircraft_id");
        int numSeats = Integer.parseInt(request.getParameter("num_seats"));

        try (Connection con = Database.getConnection();
             PreparedStatement ps = con.prepareStatement("INSERT INTO aircraft (aircraft_id, num_seats) VALUES (?, ?)")) {
            ps.setString(1, aircraftId);
            ps.setInt(2, numSeats);

            ps.executeUpdate();
        }
    }

    private void editAircraft(HttpServletRequest request) throws SQLException {
        String aircraftId = request.getParameter("aircraft_id");
        int numSeats = Integer.parseInt(request.getParameter("num_seats"));

        try (Connection con = Database.getConnection();
             PreparedStatement ps = con.prepareStatement("UPDATE aircraft SET num_seats = ? WHERE aircraft_id = ?")) {
            ps.setInt(1, numSeats);
            ps.setString(2, aircraftId);

            ps.executeUpdate();
        }
    }

    private void deleteAircraft(HttpServletRequest request) throws SQLException {
        String aircraftId = request.getParameter("aircraft_id");

        try (Connection con = Database.getConnection();
             PreparedStatement ps = con.prepareStatement("DELETE FROM aircraft WHERE aircraft_id = ?")) {
            ps.setString(1, aircraftId);

            ps.executeUpdate();
        }
    }

    // Other methods...
}
