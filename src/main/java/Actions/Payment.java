package Actions;

import JDBC.JDBCConnection;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@WebServlet(name = "Payment", urlPatterns = {"/Payment"})
public class Payment extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            // Your existing code, if needed
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String action = request.getParameter("action");

        if ("checkout".equals(action)) {
            handleCheckout(request, response, session);
        } else {
            handleViewCart(request, response, session);
        }
    }

    private void handleViewCart(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws ServletException, IOException {
        String username = (String) session.getAttribute("username");

        String sqlQuery = "SELECT * FROM client WHERE username=?";
        try (Connection conn = JDBCConnection.getJDBCConnection(); PreparedStatement stmt = conn.prepareStatement(sqlQuery)) {
            stmt.setString(1, username);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    request.setAttribute("phone", rs.getString("phone"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher("payment.jsp");
        dispatcher.forward(request, response);
    }

    private void handleCheckout(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws ServletException, IOException {
        String username = (String) session.getAttribute("username");

        String insertOrderQuery = "INSERT INTO orders (product, username) VALUES (?, ?)";
//        try (Connection conn = JDBCConnection.getJDBCConnection(); PreparedStatement stmt = conn.prepareStatement(insertOrderQuery)) {
//            for (Object item : cart) {
//                // Assuming item is a map or object, adapt according to your actual cart structure
//                // String product = getProductDetails(item); // Extract product details from item
//                stmt.setString(1, item.toString()); // Adapt this line according to your cart item structure
//                stmt.setString(2, username);
//                stmt.addBatch();
//            }
//            stmt.executeBatch();
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }

        request.setAttribute("clear","clear");
        RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
