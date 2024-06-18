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
        <title>JSP Page</title>
        <script src="./test.js"></script>
    </head>
    <body>
        <%
            String username = (String) session.getAttribute("username");
            String phone = (String)  request.getAttribute("phone");
           
        %>
        <a href="./index.jsp">Back</a>
        <h1>Payment</h1>
        <span id="navpayment" style="display: none"></span>
        <main>
            <form method="post" action="Payment">
                <input type="hidden" name="action" value="checkout">
                <table style="text-align: left; line-height: 1.4; font-size: 16px">
                    <tr>
                        <th>Username: </th>
                        <td><%= username %></td>
                    </tr>
                    <tr>
                        <th>Full name:</th>
                        <td><input type="text" name="fullname"></td>
                    </tr>
                    <tr>
                        <th>Phone:</th>
                        <td>0<%= phone %></td>
                    </tr>
                    <tr>
                        <th>Mail:</th>
                        <td><input type="text" name="email"></td>
                    </tr>
                    <tr>
                        <th>Address:</th>
                        <td><input type="text" name="address"></td>
                    </tr>
                    <tr>
                        <th>Quantity:</th>
                        <td><div id="number-item-cart" style="font-size: 12px; padding: 4px; border-radius: 16px"></div></td>
                    </tr>
                    <tr>
                        <th>List Of Cart:</th>
                        <td>
                            <div id="cart-list" style="max-height: 100%; min-height: 100%; font-size: 12px; border-radius: 4px; padding: 6px 12px;">
                                <ul id="list-of-cart" style="overflow-y: hidden !important; max-height: 100% !important">
                                    <!-- Cart items will be dynamically inserted here -->
                                </ul>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th>Subtotal: </th>
                        <td>
                            <p id="totalPrice"></p>
                            <p>Shipping: Free</p>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2"><input type="submit" value="Checkout"></td>
                    </tr>
                </table>
            </form>
        </main>
        <script>
            const username = "<%= username %>";
            document.title = "Payment: " + "<%= username %>";


        </script>
    </body>
</html>
