<%-- 
    Document   : Signup
    Created on : May 24, 2024, 1:22:32 AM
    Author     : lengo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="shortcut icon" href="./assets/images/logo.jpg">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
        <style>
            *{
                border: 0;
                padding: 0;
                box-sizing: border-box;
            }
            body{
                background: #d4af37;
                display: flex;
                flex-direction: column;
                justify-content: center;
                align-items: center;
            }
            table{
                padding: 12px 24px;
                border: 1px solid #000;
                box-shadow: 0 3px 9px #000;
                border-radius: 4px;
            }
            h2{
                font-size: 32px;
                font-weight: 700;
                line-height: 2.0;
                text-align: center;
                color: #18206f;
            }
            th{
                padding-right: 12px;
            }
            th, td{
                font-weight: 700;
                color: #18206f;
                text-align: left;
                font-size: 20px;
            }
            td{
                padding: 6px 0;
                /*overflow: hidden;*/
                width: 100%;
            }
            input{
                padding: 12px;
                font-weight: 700;
                color: #18206f;
                border: 1px solid #000;
                border-radius: 4px;
            }
        </style>
    </head>
    <body>
        <%  
            String message = "";
            if(((String) request.getAttribute("message")) != null){
                message = (String) request.getAttribute("message");
            }
        %>

        <h2 class="log-in-title">Sign Up</h2>           
        <form id="Signupform" action="Signup" method="post">
            <table style="width: 420px">
                <%
                    if(message != null)
                    {    
                %>
                <tr><th colspan="2" style="text-align:center; color: #DD3333;font-size: 14px"><%= message %></th></tr>
                        <%
                            }
                        %>
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
        <script>
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
        </script>
    </body>
</html>

