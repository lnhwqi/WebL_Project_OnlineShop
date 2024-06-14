/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package ajax;

import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.util.HashMap;
import java.util.Iterator;

/**
 *
 * @author lengo
 */
@WebServlet(name = "AutoCompleteServlet", urlPatterns = {"/AutoCompleteServlet"})
public class AutoCompleteServlet extends HttpServlet {

    private ServletContext context;
    private ProductData compData = new ProductData();
    private HashMap products = compData.getProducts();

    @Override
    public void init(ServletConfig config) throws ServletException {
        this.context = config.getServletContext();
    }

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {

        String action = request.getParameter("action");
        String targetId = request.getParameter("id");
        StringBuffer sb = new StringBuffer();

        if (targetId != null) {
            targetId = targetId.trim().toLowerCase();
        } else {
            context.getRequestDispatcher("/error.jsp").forward(request, response);
            return;
        }

        boolean namesAdded = false;
        if ("complete".equals(action)) {
            if (!targetId.isEmpty()) {
                Iterator it = products.keySet().iterator();
                while (it.hasNext()) {
                    String id = (String) it.next();
                    Product product = (Product) products.get(id);
                    if (product.getName().toLowerCase().startsWith(targetId)
                            || product.getName().toLowerCase().startsWith(targetId)
                            || product.getName().toLowerCase().concat(" ").concat(product.getName().toLowerCase()).startsWith(targetId)) {

                        
                        sb.append("<product>");
                        sb.append("<id>" + product.getId() + "</id>");
                        sb.append("<name>" + product.getName() + "</name>");
                        sb.append("</product>");
                        namesAdded = true;
                    }
                }
            }
            if (namesAdded) {
                response.setContentType("text/xml");
                response.setHeader("Cache-Control", "no-cache");
                response.getWriter().write("<products>" + sb.toString() + "</products>");
            } else {
                response.setStatus(HttpServletResponse.SC_NO_CONTENT);
            }
        }

        if ("lookup".equals(action)) {
            if ((targetId != null) && products.containsKey(targetId.trim())) {
                RequestDispatcher dispatcher = request.getRequestDispatcher("productTemplate.jsp?productid="+targetId);
                dispatcher.forward(request, response);
            }
        }
    }
}
