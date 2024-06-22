<%-- 
    Document   : admin
    Created on : Jun 22, 2024, 11:08:50 AM
    Author     : lengo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="JDBC.JDBCConnection" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>title</title>
        <style>
            table{
                width:100%;
            }
            table, th, td {
                border: 1px solid #000;
            }
        </style>
    </head>
    <body>
        <%
            String username = (String) session.getAttribute("username");
        %>
        <h1>Hello <%= username %>!</h1>
        <h2>Ordered List!</h2>
        <table>
            <tr>
                <th>ID</th>
                <th>TIME</th>
                <th>Username</th>
                <th>Product List</th>
                <th>Quantity</th>
                <th>Price</th>
                <th>Status</th>
            </tr>
            <%
                int revenue = 0;
                Class.forName("com.mysql.cj.jdbc.Driver"); // Updated to use the correct MySQL driver class
                Connection conn = JDBCConnection.getJDBCConnection();
                String query =  "SELECT o.orderid, o.orderstatus, o.username, o.timeordered, ol.quantity, ol.price, ol.itemName " +
                                "FROM `order` o " +
                                "JOIN orderlist ol ON o.orderid = ol.orderid ";
                PreparedStatement stmt = conn.prepareStatement(query);
                ResultSet rs = stmt.executeQuery();

                while(rs.next()){
                    int id = rs.getInt("orderid");
                    int price = rs.getInt("price");
                    String clientusername = rs.getString("username");
                    String status = rs.getString("orderstatus");
                    int quantity = rs.getInt("quantity");
                    String itemName = rs.getString("itemName");
                    String time = rs.getString("timeordered");
                    revenue += price;
            %>
            <tr>
                <td><%= id %></td>
                <td><%= time %></td>
                <td><%= clientusername %></td>
                <td><%= itemName %></td>
                <td><%= quantity %></td>
                <td><%= price %></td>
                <td><%= status %>

                    <% if ("packing goods".equals(status)) { %>
                    <form method="post" action="UpdateOrderStatusServlet">
                        <input type="hidden" name="orderId" value="<%= id %>">
                        <input type="hidden" name="newStatus" value="Delivering">
                        <button type="submit" style="width: 100%; margin: 12px 0; padding: 12px ">Done</button>
                    </form>
                    <% } %>
                </td>
            </tr>
            <%
                }
                rs.close();
                stmt.close();
                conn.close();
            %>
        </table>
        <h4>Total Revenue: $<%= revenue %></h4>
        <script>
            document.title = "<%= username %>";
        </script>
    </body>
</html>
