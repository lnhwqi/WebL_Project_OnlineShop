<%-- 
    Document   : payment
    Created on : Jun 15, 2024, 4:44:56 PM
    Author     : lengo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="./assets/css/reset.css"/>
        <title>Payment</title>
        <style>
            body{
                color: #18206f;
                background: #d4af37;
            }
            .back{
                color: #000;
                background: #ccc;
                margin: 12px;
                padding: 12px;
            }
            .title{
                font-size: 54px;
                line-height: 1.4;
                text-align: center;
            }
            main{
                width: 1400px;
                padding: 8px 24px;
                margin-left: 50%;
                transform: translateX(-50%);
                border: 1px solid #000;
                border-top: 0;
            }
            th{
                font-weight: 700;
                text-transform: uppercase;
            }
            input{
                padding: 8px 0;
                width: 100%;
                height: 20px;
                border: 1px solid #000;
                border-radius: 4px;
            }
        </style>
    </head>
    <body>
        <%
            String username = (String) session.getAttribute("username");
            String phone = (String) session.getAttribute("phone");
            String outStock = "";
            if(request.getAttribute("outStock") != null){
                outStock = (String) request.getAttribute("outStock");
            }
        %>
        <% if (outStock != "") { %>
        <h4 style="font-weight: 700; text-align: center">"Product <%= outStock %> is over our remaining product quantity! Sorry"</h4>

        <% } %>
        <div style="margin: 24px; width: 240px">
            <a href="./index.jsp" class="back" style="display:block ;color: #000; width: 100%; border: 1px solid #000; border-radius: 4px; text-align: center">Back</a>
        </div>
        <h1 class="title">Payment</h1>
        <main style="display: flex; justify-content: center">
            <form method="post" action="Payment">
                <input type="hidden" name="action" value="checkout">
                <table style="text-align: left; line-height: 2.4; font-size: 16px">
                    <tr>
                        <th>Username: </th>
                        <td><%= username %></td>
                    </tr>
                    <tr>
                        <th>Full name:</th>
                        <td><input type="text" id="fullname" name="fullname" required></td>
                    </tr>
                    <tr>
                        <th>Phone:</th>
                        <td>0<%= phone %><input type="hidden" id="phone" name="phone"></td>
                    </tr>
                    <tr>
                        <th>Mail:</th>
                        <td><input type="text" id="mail" name="mail" required></td>
                    </tr>
                    <tr>
                        <th>Address:</th>
                        <td><input type="text" id="address" name="address" required></td>
                    </tr>
                    <tr>
                        <th>Quantity:</th>
                        <td>
                            <div id="number-item-cart" style="font-size: 12px; padding: 4px; border-radius: 16px"></div>
                            <input type="hidden" id="quantity" name="quantity">
                        </td>
                    </tr>
                    <tr>
                        <th>List Of Cart:</th>
                        <td>
                            <div id="cart-list" style=" font-size: 16px;width: 320px">
                                <ul id="list-of-cart" >
                                </ul>
                            </div>

                        </td>
                    </tr>
                    <tr>
                        <th>Subtotal: </th>
                        <td>
                            <p id="numberItemCart"></p>
                            <p id="totalPrice"></p>
                            <p>Shipping: Free</p>
                        </td>
                    </tr>
                    <input type="hidden" id="time" name="time">
                    <input type="hidden" id="orderlist" name="orderlist">
                    <input type="hidden" id="subtotal" name="subtotal">
                    <tr>
                        <td colspan="2"><input type="submit" value="Checkout" style="color: #d4af37; background: #18206f; height:32px; width: 100%;"></td>
                    </tr>
                </table>
            </form>
        </main>
        <script src="./js/payment.js"></script>
        <script>
            const username = "<%= username %>";
            const outStock = "<%= outStock %>";

            document.title = "Payment: " + "<%= username %>";

            function updateTime() {
                const date = new Date();
                const formattedTime = date.toISOString().slice(0, 19).replace('T', ' ');

                document.getElementById('time').value = formattedTime;
                console.log(formattedTime);
            }
            setInterval(updateTime, 1000);
            console.log(outStock);
//            
            console.log(outStock === "");

            if (outStock !== "") {
                const cart = JSON.parse(localStorage.getItem('cart')) || [];
                const updatedCart = cart.filter(item => item.name !== "<%= outStock %>");
                localStorage.setItem('cart', JSON.stringify(updatedCart));

                setTimeout(function () {
                    window.location.href = 'index.jsp';
                }, 3000);
            };

        </script>
    </body>
</html>
