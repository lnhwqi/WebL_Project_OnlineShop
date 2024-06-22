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
        <script src="./js/addToCart.js"></script>
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
                    <a href="index.jsp"><img class="logo" src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTG9KX3fSb_J5ao_jR_q13xoQgeRiQXymUoDQ&s" alt="logo"/></a>


                    <i id="menu-btn" class="fa-solid fa-bars bars-btn sign"></i>

                    <form name="autofillform" action="AutoCompleteServlet" class="form search" style="position: relative">
                        <input type="text" class="search-bar" name="search" id="complete-field" onkeyup="doCompletion()">

                        <table border="0" cellpadding="5" class="main-table" style="position: absolute; width: 100%">   
                            <tr>
                                <td id="auto-row" colspan="2">
                                    <table id="complete-table" class="popupBox" style="position: absolute ;width: 100%"></table>
                                </td>
                            </tr>
                        </table>
                    </form>
                </div>
                <div class="header-center-block">
                    <a href="#!" class="about-us item">About Us</a>
                    <a href="#!" class="news item">News</a>
                    <a href="#!" class="news item">Promotion</a>
                </div>

                <div class="header-right-block">
                    <i id="cart-btn" class="fa-solid fa-cart-shopping cart-btn sign" style="position: relative; ">
                        <div id="cart-list" style="background: #ccc; position: absolute; font-size: 12px;border: 1px solid #000; border-radius: 4px; padding: 6px 12px; overflow-y: scroll; width: 320px; max-height: 420px;  z-index: 7">
                            <p style="">List of cart</p>
                            <ul id="list-of-cart" >
                            </ul>
                            <p id="totalPrice" style="padding: 12px 0"></p>
                            <div style="width: 100%; display: flex; justify-content: center;"><a href="#!" style="font-weight: 700; background: #ffdddd; padding: 8px 24px" onclick="payment()" id="navpayment">Payment</a></div>
                        </div>
                        <div id="number-item-cart" style="position: absolute; top: -8px;left: -8px; font-size: 12px; padding: 4px; background-color:red; border-radius: 16px">0</div>
                    </i>
                    <div class="action" style="position: relative">
                        <a id="clientbtn" class="client btn" href="#!" style="margin-right: 0; display: block"></a>
                        <div id="client_nav" style="display: none; position: absolute; top: 33.6px; right: 0; background: #d4af37; flex-direction: column; padding: 8px 12px; line-height: 1.8">
                            <a onclick="logOut()">Logout</a>
                            <a onclick="clientSite()">Client Site</a>
                        </div>
                    </div>
                </div>
            </div>
        </header>
        <div id="menu" style="display: none; position: fixed;  width: 100%; z-index: 2">
            <table class="container" style="background: #d4af37; line-height: 1.8; color: #000; border-bottom-left-radius: 4px; border-bottom-right-radius: 4px">
                <tr>
                    <td style="width: 20%"><a href="#!" onclick="navigateToOverviewTemplate('shirt')" style="color: #006699; margin-left: 24px">shirt</a></td>
                    <td style="width: 20%"><a href="#!" onclick="navigateToOverviewTemplate('t-shirt')" style="color: #006699; margin-left: 24px">t-shirt</a></td>
                    <td style="width: 20%"><a href="#!" onclick="navigateToOverviewTemplate('polo')" style="color: #006699; margin-left: 24px">polo</a></td>
                    <td style="width: 20%"><a href="#!" onclick="navigateToOverviewTemplate('toptank')" style="color: #006699; margin-left: 24px">tank top</a></td>
                </tr>
                <tr>
                    <td style="width: 20%"><a href="#!" onclick="navigateToOverviewTemplate('pants')" style="color: #006699; margin-left: 24px">pants</a></td>
                    <td style="width: 20%"><a href="#!" onclick="navigateToOverviewTemplate('shorts')" style="color: #006699; margin-left: 24px">shorts</a></td>
                    <td style="width: 20%"><a href="#!" onclick="navigateToOverviewTemplate('jeans')" style="color: #006699; margin-left: 24px">jeans</a></td>
                    <td style="width: 20%"><a></a></td>
                </tr>
                <tr>
                    <td style="width: 20%"><a href="#!" onclick="navigateToOverviewTemplate('hoodie')" style="color: #006699; margin-left: 24px">hoodie</a></td>
                    <td style="width: 20%"><a href="#!" onclick="navigateToOverviewTemplate('jacket')" style="color: #006699; margin-left: 24px">jacket</a></td>
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
            document.getElementById('clientbtn').addEventListener('click', () => {
                document.getElementById('client_nav').style.display =
                        document.getElementById('client_nav').style.display === 'none' ? 'flex' : 'none';
            });
        </script>
        <script src="./js/main.js"></script>

    </body>
</html>
