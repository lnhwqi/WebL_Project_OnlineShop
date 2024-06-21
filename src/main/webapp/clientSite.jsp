<%-- 
    Document   : clientInformation
    Created on : Jun 4, 2024, 3:01:48 AM
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
        <div style="margin: 24px">
            <a href="./index.jsp" class="back" style="color: #000">Back</a>
        </div>
        <h1>Hello <%= username %>!</h1>
        <h2>Your ordered list!</h2>
        <table>
            <tr>
                <th>ID</th>
                <th>TIME</th>
                <th>Product List</th>
                <th>Quantity</th>
                <th>Price</th>
                <th>Status</th>
            </tr>
            <%
                Class.forName("com.mysql.cj.jdbc.Driver"); // Updated to use the correct MySQL driver class
                Connection conn = JDBCConnection.getJDBCConnection();
                String query =  "SELECT o.orderid, o.orderstatus, o.timeordered, ol.quantity, ol.price, ol.itemName " +
                                "FROM `order` o " +
                                "JOIN orderlist ol ON o.orderid = ol.orderid " +
                                "WHERE o.username = ?";
                PreparedStatement stmt = conn.prepareStatement(query);
                stmt.setString(1, username);
                ResultSet rs = stmt.executeQuery();

                while(rs.next()){
                    int id = rs.getInt("orderid");
                    int price = rs.getInt("price");
                    String status = rs.getString("orderstatus");
                    int quantity = rs.getInt("quantity");
                    String itemName = rs.getString("itemName");
                    String time = rs.getString("timeordered");
            %>
            <tr>
                <td><%= id %></td>
                <td><%= time %></td>
                <td><%= itemName %></td>
                <td><%= quantity %></td>
                <td><%= price %></td>
                <td><%= status %></td>
            </tr>
            <%
                }
                rs.close();
                stmt.close();
                conn.close();
            %>
        </table>
        <script>
            document.title = "<%= username %>";
            
        </script>
    </body>
</html>
