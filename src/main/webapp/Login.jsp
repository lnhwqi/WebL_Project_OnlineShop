<%-- 
    Document   : Login
    Created on : May 24, 2024, 1:01:54 AM
    Author     : lengo
--%>

<%@ page import = "java.sql.*, java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="JDBC.JDBCConnection" %>

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
            String message = (String) request.getAttribute("errorMessage");
            int state = (int) request.getAttribute("state");
            String username = (String) request.getAttribute("username");
        %>

        <h2 class="log-in-title">Checking your Username and Password, Again</h2>           
        <form method="post" action="Login">
            <table style="width: 420px">
                <tr> 
                    <th>Username: </th>
                    <td><input type="text" id="usernameLG" name="usernameLG" style="width: 100%" value="<%= username %>" required></td>
                </tr>
                <tr> 
                    <th>Password: </th>
                    <td><input type="text" id="passwordLG" name="passwordLG" style="width: 100%" required></td>
                </tr>
                <%
                    if (message != null && !message.isEmpty()) {
                    
                %>
                <tr><td colspan="2" style="text-align: center">
                        <p style="color: #18206f;"><%= message %>
                            <%
                                if(state == 0){
                            %>
                            <br><a href="Signup.jsp"  style="text-decoration: none; color: #DD3333; padding: 8px 12px">Create new account</a>
                            <%
                                }
                            %>

                        </p>
                    </td></tr>

                <%                    
                    }
                %>
                <tr>              
                    <td colspan="2" ><a href="#!"  onclick="resetPassword()">Forget Password</a></td>
                </tr>
                <tr>              
                    <td colspan="2" ><input type="submit" style="width: 100%" value="Log In" name="submit"></td>
                </tr>
            </table>
        </form>  
        <script>
            function resetPassword() {
                window.location.href = 'Resetpassword';
            }
        </script>
    </body>
</html>

