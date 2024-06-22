<%-- 
    Document   : products
    Created on : Jun 22, 2024, 3:38:57 PM
    Author     : lengo
--%>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="JDBC.JDBCConnection" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Add Product</title>
        <style>
            body{
                color: #000;
                background: #ccc;
            }
            input{
                padding: 4px;
                border-radius: 6px;
            }
            .back{
                color: #000;
                background: #ccc;
                margin: 12px;
                padding: 12px;
            }
        </style>

    </head>
    <body>
        <div style="margin: 24px; width: 240px">
            <a href="./admin.jsp" class="back" style="display:block ;color: #000; width: 100%; border: 1px solid #000; border-radius: 4px; text-align: center">Back</a>
        </div>
        <main style="display: flex">
            <div class="left-block" style="width: 30%; padding-left: 24px">
                <h2>ADD NEW PRODUCT</h2>
                <form action="products.jsp" method="post" enctype="multipart/form-data">
                    <label for="img">Image File:</label><br>
                    <input type="file" id="imgFile" name="imgFile" style='width:50%' accept="image/*" required><br><br>

                    <label for="name">Name:</label><br>
                    <input type="text" id="name" name="name" style='width:50%' required><br><br>

                    <label for="price">Price:</label><br>
                    <input type="number" id="price" name="price" style='width:50%' required><br><br>

                    <label for="remainingquantity">Remaining Quantity:</label><br>
                    <input type="number" id="remainingquantity" name="remainingquantity" style='width:50%' required><br><br>

                    <label for="typeproduct">Type of Product:</label><br>
                    <input type="text" id="typeproduct" name="typeproduct" style='width:50%' required><br><br>

                    <input type="submit" value="Add Product" style='width:50%'>
                </form>
            </div>
            <div class="right-block" style="width: 70%; border-left: 2px solid #000; padding-left: 24px">
                <h2>EDIT PRODUCT</h2>
                <table style='text-align: center'>
                    <tr>
                        <th style='width: 10%'>ID</th>
                        <th style='width: 20%'>Image</th>
                        <th style='width: 40%'>Name</th>
                        <th style='width: 10%'>Remaining Quantity</th>
                        <th style='width: 10%'>Price</th>
                        <th style='width: 10%'>Action</th>
                    </tr>

                    <%
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection conn = JDBCConnection.getJDBCConnection();
                        String query = "SELECT id, name, img, remainingquantity, price FROM products ORDER BY remainingquantity";
                        Statement stmt = conn.createStatement();
                        ResultSet rs = stmt.executeQuery(query);

                        while(rs.next()){
                            int id = rs.getInt("id");
                            String name = rs.getString("name");
                            String img = rs.getString("img");
                            int remainingquantity = rs.getInt("remainingquantity");
                            int price = rs.getInt("price");
                    %>
                    <tr style='line-height: 2.0'>
                        <td><%= id %></td>
                        <td><img src="<%= img %>" alt="alt" style='width: 40px;'/></td>
                        <td><input id='name1' type="text" name="name" value="<%= name %>"></td>
                        <td><input id='rq1' type="text" name="remainingquantity" value="<%= remainingquantity %>"></td>
                        <td><input id='price1' type="text" name="price" value="<%= price %>"></td>
                        <td>
                            <form action="products.jsp" method="post" style="display:block;">
                                <input id='name2' type="hidden" name="name1" >
                                <input id='price2' type="hidden" name="price1" >
                                <input id='rq2' type="hidden" name="remainingquantity1" value='53'>
                                <input type="hidden" name="id1" value="<%= id %>">
                                <input type="submit" value="update" name='update'>
                            </form>
                            <form action="products.jsp" method="post" style="display:block;">
                                <input type="hidden" name="id" value="<%= id %>">
                                <input type="submit" value="delete" name='delete'>
                            </form>
                        </td>
                    </tr>

                    <%
                        }
                        stmt.close();
                        rs.close();
                    %>

                </table>
            </div>
        </main>
        <script>
        </script>
        <%
            if(request.getParameter("delete") != null){
                int id = Integer.parseInt(request.getParameter("id"));

                try {
                    String sql = "DELETE FROM products WHERE id = ?";
                    PreparedStatement pstmt = conn.prepareStatement(sql);
                    pstmt.setInt(1, id);

                    pstmt.executeUpdate();

                    response.sendRedirect("products.jsp");
                } catch (Exception e) {
                    out.println("Error: " + e.getMessage());
                }
            }
            
            
           

                         
        %>

    </body>
</html>
