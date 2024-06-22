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
import jakarta.servlet.http.HttpSession;
import java.sql.Connection;

import java.sql.PreparedStatement;
import java.sql.SQLException;

import java.sql.*;

/**
 *
 * @author lengo
 */
@WebServlet(name = "Login", urlPatterns = {"/Login"})
public class Login extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
//            /* TODO output your page here. You may use following sample code. */
//            out.println("<!DOCTYPE html>");
//            out.println("<html>");
//            out.println("<head>");
//            out.println("<title>Servlet SignUp</title>");  
//            out.println("</head>");
//            out.println("<body>");
//            out.println("<h1>Servlet SignUp at " + request.getContextPath () + "</h1>");
//            out.println("</body>");
//            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
//        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("usernameLG");
        String password = request.getParameter("passwordLG");

        int state = isAdmin(username, password);
        if (state != 3) {
            state = isClient(username, password);

        }

        String message = " ";
        if (state == 3) {
            HttpSession session = request.getSession();
            session.setAttribute("username", username);
            response.sendRedirect("admin.jsp?username=" + username);
        } else if (state == 2) {
            HttpSession session = request.getSession();
            session.setAttribute("username", username);
            response.sendRedirect("index.jsp?username=" + username);
//           out.println("Username set in session: " + username);
        } else if (state == 1) {
            message = "Check your password again!";
            request.setAttribute("errorMessage", message);
            request.setAttribute("username", username);
            request.setAttribute("state", state);

            RequestDispatcher dispatcher = request.getRequestDispatcher("Login.jsp");
            dispatcher.forward(request, response);
        } else {
            message = "Your account is not in database";
            request.setAttribute("errorMessage", message);
            request.setAttribute("username", username);
            request.setAttribute("state", state);
            RequestDispatcher dispatcher = request.getRequestDispatcher("Login.jsp");
            dispatcher.forward(request, response);
        }

    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    private static int isClient(String username, String password) {

        int state = 0;

        String sqlQuery = "SELECT * FROM client WHERE username=? AND password=?";

        try (Connection conn = JDBCConnection.getJDBCConnection(); PreparedStatement stmt = conn.prepareStatement(sqlQuery)) {

            stmt.setString(1, username);
            stmt.setString(2, password);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    state = 2;
                } else {
                    String sqlUserCheck = "SELECT * FROM client WHERE username=?";

                    try (PreparedStatement userCheckStmt = conn.prepareStatement(sqlUserCheck)) {
                        userCheckStmt.setString(1, username);

                        try (ResultSet userCheckRs = userCheckStmt.executeQuery()) {
                            if (userCheckRs.next()) {
                                state = 1;
                                userCheckRs.close();
                                userCheckStmt.close();
                                rs.close();
                                stmt.close();
                            }
                        }
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle SQLException appropriately
        }

        return state;
    }

    private static int isAdmin(String username, String password) {

        int state = 0;

        String sqlQuery = "SELECT * FROM admin WHERE username=? AND password=?";

        try (Connection conn = JDBCConnection.getJDBCConnection(); PreparedStatement stmt = conn.prepareStatement(sqlQuery)) {

            stmt.setString(1, username);
            stmt.setString(2, password);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    state = 3;
                    rs.close();
                    stmt.close();
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle SQLException appropriately
        }

        return state;
    }
}
