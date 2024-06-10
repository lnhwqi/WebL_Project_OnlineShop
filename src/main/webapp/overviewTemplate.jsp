<%-- 
    Document   : overviewTemplate
    Created on : Jun 4, 2024, 1:16:41 AM
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
        <%
            String username = (String) session.getAttribute("username");
            String main = (String) request.getParameter("overview");
        %>
        <title><%= main %></title>
        <style>

        </style>
    </head>

    <body>
        <header class="header">
            <div class="container">
                <div class="header-left-block">
                    <img class="logo" src="https://images.unsplash.com/photo-1715698576283-d6ee92b7157a?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" alt="logo"/>
                    <i id="menu-btn" class="fa-solid fa-bars bars-btn sign"></i>

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
                    <i class="fa-solid fa-cart-shopping cart-btn sign" style="position: relative; ">
                        <div id="cart-list" style="background: #ccc; position: absolute; font-size: 12px;border: 1px solid #000; border-radius: 4px; padding: 6px 12px;">
                            <p style="">List of cart</p>
                            <ul id="list-of-cart">
                                <li>first</li>
                                <li>second</li>
                                <li>third</li>
                            </ul>
                        </div>
                        <div id="number-item-cart" style="position: absolute; top: -8px;left: -8px; font-size: 12px; padding: 4px; background-color:red; border-radius: 16px">0</div>
                    </i>
                    <div class="action">
                        <a id="clientbtn" class="client btn" href="#!" style="margin-right: 0; display: block"></a>
                    </div>
                </div>
            </div>
        </header>
        <div id="menu" style="display: none; position: fixed;  width: 100%; ">
            <table class="container" style="background: #000; color: #000; border-bottom-left-radius: 4px; border-bottom-right-radius: 4px">
                <tr>
                    <td style="width: 20%"><a href="#!" onclick="navigateToOverviewTemplate('shirt')">shirt</a></td>
                    <td style="width: 20%"><a href="#!" onclick="navigateToOverviewTemplate('t-shirt')">t-shirt</a></td>
                    <td style="width: 20%"><a href="#!" onclick="navigateToOverviewTemplate('polo')">polo</a></td>
                    <td style="width: 20%"><a href="#!" onclick="navigateToOverviewTemplate('toptank')">tank top</a></td>
                </tr>
                <tr>
                    <td style="width: 20%"><a href="#!" onclick="navigateToOverviewTemplate('pants')">pants</a></td>
                    <td style="width: 20%"><a href="#!" onclick="navigateToOverviewTemplate('shorts')">shorts</a></td>
                    <td style="width: 20%"><a href="#!" onclick="navigateToOverviewTemplate('jeans')">jeans</a></td>
                    <td style="width: 20%"><a></a></td>
                </tr>
                <tr>
                    <td style="width: 20%"><a href="#!" onclick="navigateToOverviewTemplate('hoodie')">hoodie</a></td>
                    <td style="width: 20%"><a href="#!" onclick="navigateToOverviewTemplate('jacket')">jacket</a></td>
                    <td style="width: 20%"><a></a></td>
                    <td style="width: 20%"><a></a></td>
                </tr>
            </table>
        </div>
        <main>
            <h1 style="font-size: 42px; text-transform: uppercase"><%= main %></h1>
            <div class="container">
                <div class="overview-list" ">
                    <%
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection conn = JDBCConnection.getJDBCConnection();
                        String query = "SELECT id, name, img FROM products WHERE typeproduct = '" + main + "'";
                        Statement stmt = conn.createStatement();
                        ResultSet rs = stmt.executeQuery(query);
                            
                        while(rs.next()){
                            int id = rs.getInt("id");
                            String name = rs.getString("name");
                            String img = rs.getString("img");
                    %>
                    <div class="overview-item" onclick="navigateToProductTemplate('<%= id %>')">
                        <img src="<%= img %>" alt="alt"/>
                        <a class="item-title"><%= name %></a>
                    </div>

                    <%
                        }
                        stmt.close();
                        rs.close();
                    %>
                </div>
            </div>

        </main>
        <script>
            let username = "<%= username %>";
            if (username !== null) {
                document.getElementById("clientbtn").innerHTML = "Welcome, " + username;
            }

            function navigateToProductTemplate(productid) {
                    window.location.href = "productTemplate.jsp?productid=" + productid;
            }


            function navigateToOverviewTemplate(value) {
                    window.location.href = "overviewTemplate.jsp?overview=" + value;
            }

            document.getElementById('menu-btn').addEventListener('click', function () {
                document.getElementById('menu').style.display =
                        document.getElementById('menu').style.display === 'none' ? 'block' : 'none';
            });
        </script>
    </body>
</html>
