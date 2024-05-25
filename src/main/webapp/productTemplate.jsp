<%-- 
    Document   : productTemplate
    Created on : May 25, 2024, 1:27:42 AM
    Author     : lengo
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*, java.util.*" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="JDBC.JDBCConnection" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="./assets/css/reset.css"/>
        <link rel="stylesheet" href="./assets/css/styles.css"/>

        <script src="https://kit.fontawesome.com/298cd1d7bc.js" crossorigin="anonymous"></script>
        <title>JSP Page</title>
    </head>
    <body>
        <%
            String username = (String) session.getAttribute("username");
            String productName = (String) request.getParameter("productName");
        %>
        <header class="header">
            <div class="container">
                <div class="header-left-block">
                    <img class="logo" src="https://images.unsplash.com/photo-1715698576283-d6ee92b7157a?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" alt="logo"/>
                    <i class="fa-solid fa-bars bars-btn sign"></i>

                    <div class="search" style="position: relative">
                        <input type="text" class="search-bar" name="search">
                        <i style="position: absolute; top:0; right:0; z-index: 2" class="fa-solid fa-magnifying-glass search-btn sign"></i>
                    </div>
                </div>
                <div class="header-center-block">
                    <a href="#!" class="about-us item">About Us</a>
                    <a href="#!" class="news item">News</a>
                    <a href="#!" class="news item">Promotion</a>
                </div>

                <div class="header-right-block">
                    <i class="fa-solid fa-cart-shopping cart-btn sign"></i>
                    <div class="action">
                        <a id="clientbtn" class="client btn" href="#!" style="margin-right: 0; display: block"></a>
                    </div>
                </div>
            </div>
        </header>
        <div class="productTemp">
            <div class="container">
                <div class="productTemp-main">
                    <%
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection conn = JDBCConnection.getJDBCConnection();
                        String query = "SELECT name, img, price, typeproduct,remainingquantity, soldquantity FROM products WHERE name = '" + productName + "'";
                        Statement stmt = conn.createStatement();
                        ResultSet rs = stmt.executeQuery(query);

                        while(rs.next()){
                           String name = rs.getString("name");
                           String img = rs.getString("img");
                           int price = rs.getInt("price");
                           int remainingQuantity = rs.getInt("remainingquantity");
                           int soldQuantity = rs.getInt("soldquantity");
                           String typeproduct = rs.getString("typeproduct");
                           int quantity = remainingQuantity - soldQuantity;
                    %>
                    <div class="img">
                        <img src="<%= img %>" alt="alt"/>
                    </div>
                    <div class="productTemp-right">
                        <div class="productTemp-info">
                            <a class="productTemp-type"><%= typeproduct %></a>
                            <h1 class="productTemp-title"><%= name %></h1>
                            <h2 class="productTemp-price">PRICE: <%= price %>$</h2>
                            <p class="productTemp-remainingQuantity">REMAINING QUANTITY: <%= remainingQuantity %> Items</p>
                            <p class="productTemp-soldQuantity">SOLD QUANTITY: <%= soldQuantity %> Items</p>
                            <p class="quantity">QUANTITY: <input type="number" id="quantity" name="quantity" value="1" min="1" max="<%= quantity %>" step="1"></p>
                        </div>
                        <div class="productTemp-actions">
                            <a class="productTemp-cart btn">Add to cart</a>
                            <a class="productTemp-buy btn">Buy</a>
                        </div>
                    </div>

                    <%
                        }
                        stmt.close();
                        rs.close();
                    %>
                </div>
                <div class="productTemp-desc">
                    <h2 class="productTemp-desc-title">Information:</h2>
                    <p>XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
                    XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
                    XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
                    XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
                    XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
                    </p>
                </div>
            </div>
        </div>
        <footer class="footer">
            <div class="container">
                <table>
                    <tr>
                        <th>Website Application Development Course</th>
                    </tr>
                    <tr>
                        <th>Topic: Shop Store</th>
                        <td rowspan="2">
                            <ul>
                                <li>
                                    <a href="#!">
                                        <img src="https://images.unsplash.com/photo-1704688618021-557e23d44850?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw2fHx8ZW58MHx8fHx8" alt="alt"/>
                                    </a>
                                </li>
                                <li>
                                    <a href="#!">
                                        <img src="https://images.unsplash.com/photo-1704688618021-557e23d44850?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw2fHx8ZW58MHx8fHx8" alt="alt"/>
                                    </a>
                                </li>
                                <li>
                                    <a href="#!">
                                        <img src="https://images.unsplash.com/photo-1704688618021-557e23d44850?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw2fHx8ZW58MHx8fHx8" alt="alt"/>
                                    </a>
                                </li>
                            </ul>
                        </td>
                    </tr>
                    <tr>
                        <td>Members: 3</td>
                        <td></td>
                    </tr>
                    <tr>
                        <th>International University</th>
                        <td></td>
                    </tr>
                </table>
            </div>
        </footer>
        <script>
            let username = "<%= username %>";
            if (username !== "") {
                document.getElementById("clientbtn").innerHTML = "Welcome, " + username;
            }
            
            
        </script>
    </body>
</html>
