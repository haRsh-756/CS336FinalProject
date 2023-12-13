import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/EditAirportServlet")
public class EditAirportServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        try {
            switch (action) {
                case "add":
                    addAirport(request);
                    break;
                case "delete":
                    deleteAirport(request);
                    break;
                case "edit":
                    editAirport(request);
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace(); // Log the exception for debugging
            // Handle error gracefully and provide feedback to user
        }

        // Redirecting to a page (e.g., list of airports) after the action is complete
        response.sendRedirect("airportList.jsp");
    }

    private void addAirport(HttpServletRequest request) throws SQLException {
        String airportId = request.getParameter("airport_id");

        try (Connection con = Database.getConnection();
             PreparedStatement ps = con.prepareStatement("INSERT INTO airport (airport_id) VALUES (?)")) {
            ps.setString(1, airportId);

            ps.executeUpdate();
        }
    }

    private void editAirport(HttpServletRequest request) throws SQLException {
        String currentAirportId = request.getParameter("current_airport_id");
        String newAirportId = request.getParameter("new_airport_id");

        // SQL query to update the airport_id
        try (Connection con = Database.getConnection();
             PreparedStatement ps = con.prepareStatement("UPDATE airport SET airport_id = ? WHERE airport_id = ?")) {
            ps.setString(1, newAirportId);
            ps.setString(2, currentAirportId);

            ps.executeUpdate();
        }
    }


    private void deleteAirport(HttpServletRequest request) throws SQLException {
        String airportId = request.getParameter("airport_id");

        try (Connection con = Database.getConnection();
             PreparedStatement ps = con.prepareStatement("DELETE FROM airport WHERE airport_id = ?")) {
            ps.setString(1, airportId);

            ps.executeUpdate();
        }
    }

}
