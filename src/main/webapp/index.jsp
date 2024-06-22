<%-- 
    Document   : index
    Created on : May 24, 2024, 2:12:12 PM
    Author     : lengo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="JDBC.JDBCConnection" %>


<!DOCTYPE html>
<html>
    <head>
        <title>Shopping Page</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <link rel="stylesheet" href="./assets/css/reset.css"/>
        <link rel="stylesheet" href="./assets/css/styles.css"/>
        <script src="https://kit.fontawesome.com/298cd1d7bc.js" crossorigin="anonymous"></script>
    </head>
    <body onload="init()">
        <%
            String username="";
            if(session.getAttribute("username") != null){
                username = (String) session.getAttribute("username");
            }
            String clear ="";
            if(request.getAttribute("clear") != null){
                clear = (String) request.getAttribute("clear");
            }
        %>

        <div id="blur" style=""></div>

        <div class="contact" style=" z-index: 2; background-color: #f4f4f4; position: absolute; bottom: 16px; right: 8px;  position: fixed; display: flex; flex-direction: column-reverse; justify-content: center; align-items: center ;gap: 8px; border: 1px solid #006699; border-radius: 24px;">
            <i id="contact-btn" class=" fa-solid fa-comment" style="font-size: 32px; z-index: 10; color: #006699; padding: 12px;"></i>
            <ul id="contact-list" style="display:none; font-size: 24px">
                <li><a href="#!"><i class="fa-brands fa-facebook" style="color: #DD3333; padding: 8px; margin: 8px 0"></i></a></li>
                <li><a href="#!"><i class="fa-brands fa-github" style="color:  #DD3333; padding: 8px; margin: 8px 0"></i></a></li>
                <li><a href="#!"><i class="fa-solid fa-phone" style="color:  #DD3333; padding: 8px; margin: 8px 0"></i></a></li>
                <li><a href="#!"><i class="fa-solid fa-envelope" style="color:  #DD3333; padding: 8px; margin: 8px 0"></i></a></li>
            </ul>
        </div>



        <div id="log-in-modal">
            <h2 class="log-in-title">LOG IN</h2>
            <i class="x-btn fa-solid fa-x" style="position: absolute; top: 0; right: 0; padding: 16px; background-color: #18206f; color: #d4af37; font-size: 20px; border-top-right-radius: 18px; cursor: pointer"></i>
            <form action="Login" method="post">
                <table>
                    <tr> 
                        <th>Username: </th>
                        <td><input type="text" id="usernameLG" name="usernameLG" style="width: 160px" required></td>
                    </tr>
                    <tr> 
                        <th>Password: </th>
                        <td><input type="password" id="passwordLG" name="passwordLG" style="width: 160px" required></td>
                    </tr>
                    <tr>              
                        <td colspan="2" ><input type="submit" style="width: 100%" value="Log In"></td>
                    </tr>
                </table>
            </form>
        </div>


        <div id="sign-up-modal">
            <h2 class="sign-up-title">SIGN UP</h2>
            <i  class="x-btn fa-solid fa-x"></i>
            <form id="Signupform" action="Signup" method="post">
                <table>
                    <tr> 
                        <th>Username: </th>
                        <td><input type="text" id="usernameSU" name="usernameSU" style="width: 100%" required></td>
                    </tr>
                    <tr> 
                        <th>Password: </th>
                        <td><input type="password" id="passwordSU" name="passwordSU" style="width: 100%" required></td>
                    </tr>
                    <tr> 
                        <th>Password (*): </th>
                        <td><input type="password" id="passwordSU1" name="passwordSU1" style="width: 100%" required></td>
                    </tr>
                    <tr> 
                        <th id="message" colspan="2" style="text-align: center !important ; font-size: 12px"></th>
                    </tr>
                    <tr> 
                        <th>Phone: </th>
                        <td><input type="tel" id="phone" name="phone" style="width: 100%" pattern="[0-9]{10}" required></td>
                    </tr>
                    <tr>              
                        <td colspan="2" ><input class="sign-up-btn" type="submit" style="width: 100%" value="Submit"></td>
                    </tr>
                </table>
            </form>
        </div>


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
                        <a id="loginbtn" class="login btn" href="#!" >Log In</a>
                        <a id="signupbtn" class="signup btn" href="#!" style="margin-right: 0;">Sign Up</a>
                        <a id="clientbtn" class="client btn" href="#!" style="margin-right: 0; display: none"></a>
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


        <div class="slider">
            <div class="container">
                <img id="dynamicImage" src="https://media.licdn.com/dms/image/C511BAQGYZheLJS2Peg/company-background_10000/0/1584494266859/international_university_vnu_hcmc_cover?e=2147483647&v=beta&t=cYnj_nHuXPoY39j0CF0E4lIwpuXU784XC3bAAodBuZM" alt="IMAGE_PROMOTION" style="z-index: 0"/>
                <!--                <img style="display: none" src="https://images.unsplash.com/photo-1716277521822-3ffadf3f69a3?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyMHx8fGVufDB8fHx8fA%3D%3D" alt="alt"/>
                                <img style="display: none" src="https://images.unsplash.com/photo-1716277521231-c2fce136e880?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyOHx8fGVufDB8fHx8fA%3D%3D" alt="alt"/>-->
                <!--                <div class="navigate-img">
                                    <i class="fa-solid fa-circle nav-img-btn"></i>
                                    <i class="fa-solid fa-circle nav-img-btn"></i>
                                    <i class="fa-solid fa-circle nav-img-btn"></i>
                                </div>-->
            </div>
        </div>
        <!--        <div class="vouchers">
                    <div class="container">
                        <div class="title">Voucher</div>
                        <div class="voucher-list">
                            <div class="voucher-item">
                                <img src="https://images.unsplash.com/photo-1716277521543-7ff44dc651a6?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwzOXx8fGVufDB8fHx8fA%3D%3D" alt="alt"/>
                                <div class="info">
                                    <p class="voucher-title">Free Delivery</p>
                                    <a class="voucher-btn" href="#!">Get</a>
                                </div>      
                            </div>
                            <div class="voucher-item">
                                <img src="https://images.unsplash.com/photo-1716277521543-7ff44dc651a6?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwzOXx8fGVufDB8fHx8fA%3D%3D" alt="alt"/>
                                <div class="info">
                                    <p class="voucher-title">Sale up to 10% off</p>
                                    <a class="voucher-btn" href="#!">Get</a>
                                </div>      
                            </div>
                            <div class="voucher-item">
                                <img src="https://images.unsplash.com/photo-1716277521543-7ff44dc651a6?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwzOXx8fGVufDB8fHx8fA%3D%3D" alt="alt"/>
                                <div class="info">
                                    <p class="voucher-title">Sale up to 7% off</p>
                                    <a class="voucher-btn" href="#!">Get</a>
                                </div>      
                            </div>
                        </div>
                    </div>
                </div>-->
        <div class="products">
            <div class="container">
                <div class="most-sell-products">
                    <div class="most-sell-products-title">Most sell products</div>
                    <div class="most-sell-products-list">
                        <%
                            Class.forName("com.mysql.jdbc.Driver");
                            Connection conn = JDBCConnection.getJDBCConnection();
                            String query = "SELECT id, name, img FROM products ORDER BY soldquantity DESC LIMIT 10";
                            Statement stmt = conn.createStatement();
                            ResultSet rs = stmt.executeQuery(query);
                            
                            while(rs.next()){
                                int id = rs.getInt("id");
                                String name = rs.getString("name");
                                String img = rs.getString("img");
                        %>
                        <div class="most-sell-products-item product-item" onclick="navigateToProductTemplate('<%= id %>')">
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
                <div class="new-products">
                    <div class="new-products-title">New products</div>
                    <div class="new-products-list">
                        <%
   
                            String query2 = "SELECT id, name, img FROM products ORDER BY date DESC LIMIT 10";
                            Statement stmt2 = conn.createStatement();
                            ResultSet rs2 = stmt2.executeQuery(query2);
                            
                            while(rs2.next()){
                                int id2 = rs2.getInt("id");
                                String name2 = rs2.getString("name");
                                String img2 = rs2.getString("img");
                        %>
                        <div class="new-products-item product-item" onclick="navigateToProductTemplate('<%= id2 %>')">
                            <img src="<%= img2 %>" alt="alt"/>
                            <a class="item-title"><%= name2 %></a>
                        </div>

                        <%
                            }
                            stmt2.close();
                            rs2.close();
                        %>
                    </div>
                </div>
                <div class="pant-products ">
                    <div class="pant-products-title">Pants</div>
                    <div class="pant-products-list" style="position: relative">
                        <%
   
                            String query3 = "SELECT id, name, img FROM products  where typeproduct = 'pants' ORDER BY date DESC LIMIT 10";
                            Statement stmt3 = conn.createStatement();
                            ResultSet rs3 = stmt3.executeQuery(query3);
                            
                            while(rs3.next()){
                                int id3 = rs3.getInt("id");
                                String name3 = rs3.getString("name");
                                String img3 = rs3.getString("img");
                        %>
                        <div class="pant-products-item product-item" onclick="navigateToProductTemplate('<%= id3 %>')">
                            <img src="<%= img3 %>" alt="alt"/>
                            <a class="item-title"><%= name3 %></a>
                        </div>

                        <%
                            }
                            stmt3.close();
                            rs3.close();
                            conn.close();
                        %>
                        <a href="#!" onclick="navigateToOverviewTemplate('pants')" style="position: absolute; right: 0; bottom: -20px;color: #d4af37; font-size: 20px; font-weight: 700; text-decoration: underline ">More Items</a>

                    </div>

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
                                        <img src="https://cdn1.iconfinder.com/data/icons/user-pictures/100/male3-512.png" alt="alt"/>
                                    </a>
                                </li>
                                <li>
                                    <a href="#!">
                                        <img src="https://cdn0.iconfinder.com/data/icons/user-pictures/100/matureman1-512.png" alt="alt"/>
                                    </a>
                                </li>
                                <li>
                                    <a href="#!">
                                        <img src="https://cdn0.iconfinder.com/data/icons/user-pictures/100/matureman2-512.png" alt="alt"/>
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
            let clear = "<%= clear %>";
            if (clear !== "") {
                localStorage.clear();
            }
            console.log(clear);


            document.getElementById("loginbtn").addEventListener('click', () => {
                document.getElementById("log-in-modal").classList.add("visibility");
                document.getElementById("blur").classList.add("visibility");
            });
            document.getElementById("signupbtn").addEventListener('click', () => {
                document.getElementById("sign-up-modal").classList.add("visibility");
                document.getElementById("blur").classList.add("visibility");
            });
            document.getElementById("blur").addEventListener('click', () => {
                document.getElementById("log-in-modal").classList.remove("visibility");
                document.getElementById("blur").classList.remove("visibility");
                document.getElementById("sign-up-modal").classList.remove("visibility");
            });

            const xBtn = document.getElementsByClassName("x-btn");
            let myFunction = function () {
                document.getElementById("log-in-modal").classList.remove("visibility");
                document.getElementById("blur").classList.remove("visibility");
                document.getElementById("sign-up-modal").classList.remove("visibility");
            };

            for (let i = 0; i < xBtn.length; i++) {
                xBtn[i].addEventListener('click', myFunction, false);
            }
            document.getElementById('menu-btn').addEventListener('click', function () {
                document.getElementById('menu').style.display =
                        document.getElementById('menu').style.display === 'none' ? 'block' : 'none';
            });

            document.getElementById('Signupform').addEventListener('submit', function (event) {
                event.preventDefault();  // Prevent the form from submitting

                let message = document.getElementById('message');

                if (document.getElementById('passwordSU').value === document.getElementById('passwordSU1').value) {
                    event.target.submit();
                } else {
                    message.style.color = 'red';
                    message.textContent = 'Passwords do not match. Please try again.';
                }
            });

            let username = "<%= username %>";
            if (username !== "") {
                document.getElementById("loginbtn").style.display = "none";
                document.getElementById("signupbtn").style.display = "none";
                document.getElementById("clientbtn").style.display = "block";

                document.getElementById("clientbtn").innerHTML = "Welcome, " + username;
            }

            if (username === "") {
                localStorage.clear();
            }

            const contactBtn = document.getElementById('contact-btn');
            const contactList = document.getElementById('contact-list');

            contactBtn.addEventListener('click', function () {
                if (contactList.style.display === "none") {
                    contactList.style.display = "block";
                } else {
                    contactList.style.display = "none";
                }
            });


            const voucherBtns = document.querySelectorAll(".voucher-btn");

            voucherBtns.forEach((voucherBtn) => {
                voucherBtn.addEventListener('click', () => {
                    if (username !== "") {
                        voucherBtn.parentElement.parentElement.style.opacity = 0.5;
                        voucherBtn.parentElement.innerHTML = "Collected";
                        voucherBtn.classList.remove("voucher-btn");
                    } else {
                        document.getElementById("log-in-modal").classList.add("visibility");
                        document.getElementById("blur").classList.add("visibility");
                    }

                });
            });

            function navigateToProductTemplate(productid) {
                if (username !== "") {
                    window.location.href = "productTemplate.jsp?productid=" + productid;
                } else {
                    document.getElementById("log-in-modal").classList.add("visibility");
                    document.getElementById("blur").classList.add("visibility");
                }
            }


            function navigateToOverviewTemplate(value) {
                if (username !== "") {
                    window.location.href = "overviewTemplate.jsp?overview=" + value;
                } else {
                    document.getElementById("log-in-modal").classList.add("visibility");
                    document.getElementById("blur").classList.add("visibility");
                }
            }




            function fetchAndRotateImages() {
                fetch('data.json')
                        .then(response => response.json())
                        .then(data => {
                            rotateImages(data.image);
                        })
                        .catch(error => {
                            console.error('Error fetching JSON:', error);
                        });
            }
            function rotateImages(images) {
                const imgElement = document.getElementById('dynamicImage');
                let currentIndex = 0;

                setInterval(() => {
                    imgElement.src = images[currentIndex].url;
                    currentIndex = (currentIndex + 1) % images.length;
                }, 3000); // Rotate every 1000 milliseconds (1 second)
            }


            window.onload = fetchAndRotateImages;
            document.getElementById('clientbtn').addEventListener('click', () => {
                document.getElementById('client_nav').style.display =
                        document.getElementById('client_nav').style.display === 'none' ? 'flex' : 'none';
            });
        </script>
        <script src="./js/addToCart.js"></script>

        <script src="./js/main.js"></script>
    </body>
</html>
