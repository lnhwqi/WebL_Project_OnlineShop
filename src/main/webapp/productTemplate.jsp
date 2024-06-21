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
        <script src="./main.js"></script>
        <script src="./test.js"></script>
        <script src="https://kit.fontawesome.com/298cd1d7bc.js" crossorigin="anonymous"></script>
        <title></title>
    </head>
    <body>
        <%
            String username = (String) session.getAttribute("username");
            String name ="";
            String productid ="";
            String img = "";
            if(request.getParameter("productid") != null){
                productid = (String) request.getParameter("productid");
            }
            else{
                productid = (String) request.getAttribute("productid");
            }
        %>
        <header class="header">
            <div class="container">
                <div class="header-left-block">
                    <a href="index.jsp"><img class="logo" src="https://images.unsplash.com/photo-1715698576283-d6ee92b7157a?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" alt="logo"/></a>

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
                    <i id="cart-btn" class="fa-solid fa-cart-shopping cart-btn sign" style="position: relative; ">
                        <div id="cart-list" style="background: #ccc; position: absolute; font-size: 12px;border: 1px solid #000; border-radius: 4px; padding: 6px 12px; overflow-y: scroll; width: 320px; max-height: 420px; z-index: 7">
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
        <div id="menu" style="display: none; position: fixed;  width: 100%; ">
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
        <div class="productTemp">
            <div class="container">
                <div class="productTemp-main">
                    <%
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection conn = JDBCConnection.getJDBCConnection();
                        String query = "SELECT name, img, price, typeproduct,remainingquantity, soldquantity FROM products WHERE id = '" + productid + "'";
                        Statement stmt = conn.createStatement();
                        ResultSet rs = stmt.executeQuery(query);

                        while(rs.next()){
                           name = rs.getString("name");
                           img = rs.getString("img");
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
                            <a class="productTemp-type" href="./overviewTemplate.jsp?overview=<%= typeproduct%>"><%= typeproduct %></a>
                            <h1 class="productTemp-title"><%= name %></h1>
                            <h2 class="productTemp-price">PRICE: <%= price %>$</h2>
                            <p class="productTemp-remainingQuantity">REMAINING QUANTITY: <%= remainingQuantity %> Items</p>
                            <p class="productTemp-soldQuantity">SOLD QUANTITY: <%= soldQuantity %> Items</p>
                            <p class="quantity">QUANTITY: <input type="number" id="quantity" name="quantity" value="1" min="1" max="<%= quantity %>" step="1"></p>
                        </div>
                        <div class="productTemp-actions">
                            <a class="productTemp-cart btn" onclick="addItemToCart('<%= name %>', '<%= img %>', <%= price %>, document.getElementById('quantity').value)">Add to cart</a>
                            <a class="productTemp-buy btn" onclick="directpayment()">Buy</a>
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
            const name = "<%= name %>";
            const img = "<%= img%>";

            let username = "<%= username %>";
            document.title = "<%= name %>";
            if (username !== null) {
                document.getElementById("clientbtn").innerHTML = "Welcome, " + username;
            }

            document.getElementById('menu-btn').addEventListener('click', function () {
                document.getElementById('menu').style.display =
                        document.getElementById('menu').style.display === 'none' ? 'block' : 'none';
            });

            function navigateToOverviewTemplate(value) {
                window.location.href = "overviewTemplate.jsp?overview=" + value;
            }
            function directpayment(){
                window.location.href = "Payment";
            }
            document.getElementById('clientbtn').addEventListener('click', () => {
                document.getElementById('client_nav').style.display =
                        document.getElementById('client_nav').style.display === 'none' ? 'flex' : 'none';
            });
        </script>
    </body>
</html>
