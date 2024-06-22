/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
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
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author lengo
 */
@WebServlet(name = "Resetpassword", urlPatterns = {"/Resetpassword"})
public class Resetpassword extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String errorMessage = (String) request.getAttribute("errorMessage");

        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Resetpassword</title>");
            out.println("<style>*{");
            out.println("    border: 0;");
            out.println("    padding: 0;");
            out.println("    box-sizing: border-box;");
            out.println("}");
            out.println("body{");
            out.println("    background: #d4af37;");
            out.println("    display: flex;");
            out.println("    flex-direction: column;");
            out.println("    justify-content: center;");
            out.println("    align-items: center;");
            out.println("}");
            out.println("table{");
            out.println("    padding: 12px 24px;");
            out.println("    border: 1px solid #000;");
            out.println("    box-shadow: 0 3px 9px #000;");
            out.println("    border-radius: 4px;");
            out.println("}");
            out.println("h2{");
            out.println("    font-size: 32px;");
            out.println("    font-weight: 700;");
            out.println("    line-height: 2.0;");
            out.println("    text-align: center;");
            out.println("    color: #18206f;");
            out.println("}");
            out.println("th{");
            out.println("    padding-right: 12px;");
            out.println("}");
            out.println("th, td{");
            out.println("    font-weight: 700;");
            out.println("    color: #18206f;");
            out.println("    text-align: left;");
            out.println("    font-size: 20px;");
            out.println("}");
            out.println("td{");
            out.println("    padding: 6px 0;");
            out.println("    width: 100%;");
            out.println("}");
            out.println("input{");
            out.println("    padding: 12px;");
            out.println("    font-weight: 700;");
            out.println("    color: #18206f;");
            out.println("    border: 1px solid #000;");
            out.println("    border-radius: 4px;");
            out.println("}");
            out.println("</style>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1 class=\"log-in-title\">Reset Password</h1>");
            if (errorMessage != null && !errorMessage.isEmpty()) {
                out.println("<p style=\"color: red;\">" + errorMessage + "</p>");
            }
            out.println("<form method=\"post\" action=\"Resetpassword\">");
            out.println("    <table style=\"width: 420px\">");
            out.println("        <tr>");
            out.println("            <th>Username: </th>");
            out.println("            <td><input type=\"text\" id=\"usernameLG\" name=\"usernameLG\" style=\"width: 100%\" required></td>");
            out.println("        </tr>");
            out.println("        <tr>");
            out.println("            <th>Phone: </th>");
            out.println("            <td><input type=\"text\" id=\"phone\" name=\"phone\" style=\"width: 100%\" required></td>");
            out.println("        </tr>");
            out.println("        <tr>");
            out.println("            <th>New Password: </th>");
            out.println("            <td><input type=\"password\" id=\"newPassword\" name=\"newPassword\" style=\"width: 100%\" required></td>");
            out.println("        </tr>");
            out.println("        <tr><td colspan=\"2\" style=\"text-align: center\">");
            out.println("            <br><a href=\"Signup.jsp\"  style=\"text-decoration: none; color: #DD3333; padding: 8px 12px\">Create new account</a>");
            out.println("        </td></tr>");
            out.println("        <tr>");
            out.println("            <td colspan=\"2\" ><input type=\"submit\" style=\"width: 100%\" value=\"Reset Password\" name=\"RESET\"></td>");
            out.println("        </tr>");
            out.println("    </table>");
            out.println("</form>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("usernameLG");
        String phone = request.getParameter("phone");
        String newPassword = request.getParameter("newPassword");

        // Remove the first character from the phone number if present
        if (phone != null && phone.length() > 0) {
            phone = phone.substring(1);
        }

        String selectQuery = "SELECT * FROM client WHERE username=? AND phone=?";
        String updateQuery = "UPDATE client SET password=? WHERE username=? AND phone=?";

        try (Connection conn = JDBCConnection.getJDBCConnection(); PreparedStatement selectStmt = conn.prepareStatement(selectQuery); PreparedStatement updateStmt = conn.prepareStatement(updateQuery)) {

            // Check if the user exists
            selectStmt.setString(1, username);
            selectStmt.setString(2, phone);

            try (ResultSet rs = selectStmt.executeQuery()) {
                if (rs.next()) {
                    // User exists, update the password
                    updateStmt.setString(1, newPassword);
                    updateStmt.setString(2, username);
                    updateStmt.setString(3, phone);
                    updateStmt.executeUpdate();

                    // Redirect to login page or another appropriate page
                    RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
                    dispatcher.forward(request, response);
                } else {
                    // User not found, show error message
                    request.setAttribute("errorMessage", "Check your information again.");
                    processRequest(request, response);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle SQLException appropriately
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
