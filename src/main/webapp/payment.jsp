<%-- 
    Document   : payment
    Created on : Jun 15, 2024, 4:44:56 PM
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
        </style>
    </head>
    <body>
        <%
            String username = (String) session.getAttribute("username");
            String phone = (String) request.getAttribute("phone");
        %>
        <div style="margin: 24px">
            <a href="./index.jsp" class="back" style="color: #000">Back</a>
        </div>
        <h1 class="title">Payment</h1>
        <main>
            <form method="post" action="Payment">
                <input type="hidden" name="action" value="checkout">
                <table style="text-align: left; line-height: 2; font-size: 16px">
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
                    <input type="text" id="time" name="time">
                    <input type="text" id="orderlist" name="orderlist">
                    <input type="text" id="subtotal" name="subtotal">
                    <tr>
                        <td colspan="2"><input type="submit" value="Checkout"></td>
                    </tr>
                </table>
            </form>
        </main>
        <script src="./payment.js"></script>
        <script>
            const username = "<%= username %>";
            document.title = "Payment: " + "<%= username %>";

            function updateTime() {
                const date = new Date();
                const formattedTime = date.toISOString().slice(0, 19).replace('T', ' ');

                document.getElementById('time').value = formattedTime;
                console.log(formattedTime);
            }
            setInterval(updateTime, 1000);
        </script>
    </body>
</html>
