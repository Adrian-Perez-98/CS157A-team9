<%@ page import="java.sql.*"%>
<html>
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.10.2/css/all.css" />
    </head>
    <link rel="stylesheet" href="style.css"> 
    <% 
        String db = "CS157A";
        String user; // assumes database name is the same as username
        user = "root";
        String password = "ultimate1";
        java.sql.Connection con; 
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Recipe_Book?autoReconnect=true&useSSL=false",user, password);

        String account_id = (String)session.getAttribute("account_id");
        String username = (String)session.getAttribute("username");
        String grocery_item = (String)session.getAttribute("grocery_item");
        String description = (String)session.getAttribute("description");
        String price = (String)session.getAttribute("price");

        if(account_id != null) { 
            %>
            <div class="header">
              <img src="RecipeBook.jpeg" alt="Recipe Book Logo" class="logo">
              <header class="title">My Grocery Items</header>
              <br/> 
              <form action="GroceryItem.jsp" method="post"> 
                <input type="submit" value="Home" name="home" class="home_button"/>   
                <input type="submit" value="My Recipes" name="my_recipes" class="home_button"/>
                <input type="submit" value="My Grocery Lists" name="my_grocery_lists" class="home_button"/>
                <input type="submit" value="Sign Out" name="sign_out" class="home_button"/>
            </form>
            </div>
            <br style="clear:both" />
          <%
            if(request.getParameter("home") != null) {
                response.sendRedirect("HomePage.jsp");
            }
            if(request.getParameter("my_recipes") != null) {
              response.sendRedirect("MyRecipes.jsp");
            }
            if(request.getParameter("my_grocery_lists") != null) {
                response.sendRedirect("GroceryList.jsp");
            }
            if(request.getParameter("sign_out") != null) {
                session.invalidate();
                out.print("Signed Out.\n");
                response.sendRedirect("LoginPage.jsp");
            }
        } else {
            out.println("You don't have access to this page.<br/>");
        }

        Statement stmt = con.createStatement();
        try {
        	String groceryListId = request.getParameter("grocery_list_id");
        	String query = "SELECT * FROM Grocery_Item gi inner join grocery_list gl on gi.description = gl.description WHERE gl.grocery_list_id = '" + groceryListId + "'";
            ResultSet rs = stmt.executeQuery(query);
            while(rs.next()) {
                    
                    String grocery_name = rs.getString(2);
                    String grocery_description = rs.getString(3);
                    String grocery_price = rs.getString(4);
                    %>
                        <div class="content">
                        <table style="width:30%">
                        	<tr>
                                <td><b>Name:</td>
                                <td></b> <%=grocery_name%><br></td>
                            </tr>
                            <tr>
                                <td><b>Description:</td>
                                <td></b> <%=grocery_description%><br></td>
                            </tr>
                            <tr>
                                <td><b>Price:</b></td>
                                <td><%=grocery_price%></td>
                            </tr>
                        </table>
                      </div>
         <%  
            }
        } catch(SQLException e) {
            out.println("Something went wrong.<br/>");
        } 
 %>
  </body>
</html>
