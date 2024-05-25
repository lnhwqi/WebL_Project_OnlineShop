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
@WebServlet(name = "Signup", urlPatterns = {"/Signup"})
public class Signup extends HttpServlet {

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
        String username = request.getParameter("usernameSU");
        String password = request.getParameter("passwordSU");
        String phone = request.getParameter("phone");

        int newUser = addClient(username, password, phone);
        String message = "";

        try (PrintWriter out = response.getWriter()) {
            if (newUser > 0) {
                response.sendRedirect("index.jsp");
            } else {
                message = "Username used, Please, try to use another one!";
                request.setAttribute("message", message);
                RequestDispatcher dispatcher = request.getRequestDispatcher("Signup.jsp");
                dispatcher.forward(request, response);
            }
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

    private static int addClient(String username, String password, String phone) {
        int result = 0;
        String sql = "insert into client(username, password, phone) values('" + username + "','" + password + "','" + phone + "')";

        try (Connection conn = JDBCConnection.getJDBCConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            result = stmt.executeUpdate(sql);
        } catch (SQLException e) {
//            e.printStackTrace();
        }
        return result;
    }
}
