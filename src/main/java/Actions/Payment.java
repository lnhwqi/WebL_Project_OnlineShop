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
import java.sql.Timestamp;
import java.util.Arrays;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "Payment", urlPatterns = {"/Payment"})
public class Payment extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
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
            try {
                handleCheckout(request, response, session);
            } catch (SQLException ex) {
                Logger.getLogger(Payment.class.getName()).log(Level.SEVERE, null, ex);
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error");
            } catch (NumberFormatException ex) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid number format");
            }
        } else {
            handleViewCart(request, response, session);
        }
    }

    private void handleViewCart(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws ServletException, IOException {
        String username = (String) session.getAttribute("username");

        String sqlQuery = "SELECT * FROM client WHERE username=?";
        try (Connection conn = JDBCConnection.getJDBCConnection();
             PreparedStatement stmt = conn.prepareStatement(sqlQuery)) {
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
            throws ServletException, IOException, SQLException {
        String username = (String) session.getAttribute("username");
        String mail = request.getParameter("mail");
        String address = request.getParameter("address"); // Corrected parameter name
        String quantity = request.getParameter("quantity"); // Corrected spelling
        String time = request.getParameter("time");
        String subtotal = request.getParameter("subtotal");
        String orderList = request.getParameter("orderlist");
        String status = "packing goods";
        int orderid = 0;

        String sqlMaxOrderId = "SELECT MAX(orderid) AS max_id FROM `order`"; // Ensure correct table name

        try (Connection conn = JDBCConnection.getJDBCConnection();
             PreparedStatement stmt = conn.prepareStatement(sqlMaxOrderId);
             ResultSet rs = stmt.executeQuery()) {

            if (rs.next()) {
                orderid = rs.getInt("max_id") + 1;
            }

            String sqlOrder = "INSERT INTO `order`(orderid, username, timeordered, orderstatus) VALUES (?, ?, ?, ?)";
            try (PreparedStatement orderstmt = conn.prepareStatement(sqlOrder)) {
                orderstmt.setInt(1, orderid);
                orderstmt.setString(2, username);
                orderstmt.setString(3, time);
                orderstmt.setString(4,status);
                orderstmt.executeUpdate();
            }

            String sqlQuery = "INSERT INTO orderlist(orderid, itemName, address, mail, quantity, price) VALUES (?, ?, ?, ?, ?, ?)";
            try (PreparedStatement orderListstmt = conn.prepareStatement(sqlQuery)) {
                orderListstmt.setInt(1, orderid);
                orderListstmt.setString(2, orderList);
                orderListstmt.setString(3, address);
                orderListstmt.setString(4, mail);
                orderListstmt.setInt(5, Integer.parseInt(quantity));
                orderListstmt.setInt(6, Integer.parseInt(subtotal));
                orderListstmt.executeUpdate();
            }

            request.setAttribute("clear", "clear");
            RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
            dispatcher.forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
