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
            body{
                color: #18206f;
                background: #d4af37;
            }
            table{
                width:100%;
            }
            table, th, td {
                border: 1px solid #000;
                border-collapse: collapse;
            }
            .product-btn{
                color: #000;
                background: #ccc;
                margin: 12px;
                padding: 12px;
            }
        </style>
    </head>
    <body>
        <%
            String username = (String) session.getAttribute("username");
        %>

        <h1>Hello <%= username %>!</h1>
        <div style="margin: 24px; width: 240px">
            <a href="./products.jsp" class="product-btn" style="display:block ;color: #000; width: 100%; border: 1px solid #000; border-radius: 4px; text-align: center; text-decoration: none">Edit Our Products</a>
            <a href="#!" onclick="logOut()" class="product-btn" style="display:block;background: #990033 ;color: #fff; width: 100%; border: 1px solid #000; border-radius: 4px; text-align: center; text-decoration: none">Logout</a>
        </div>
        <h2>Client Ordered List!</h2>
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
                <td style="padding-left: 12px"><%= id %></td>
                <td style="padding-left: 12px"><%= time %></td>
                <td style="padding-left: 12px"><%= clientusername %></td>
                <td style="padding-left: 12px"><%= itemName %></td>
                <td style="padding-left: 12px"><%= quantity %></td>
                <td style="padding-left: 12px"><%= price %></td>
                <td style="text-align: center"><%= status %>

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
            function logOut() {
                window.location.href = 'Logout';
            }
        </script>
    </body>
</html>
