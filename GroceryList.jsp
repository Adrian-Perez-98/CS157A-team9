<%@ page import="java.sql.*"%>
<html>
<link rel="stylesheet" href="style.css"> 
  <head>
    <title>My Grocery Lists</title>
    </head>
  <body>
      <% 
        String db = "recipe_book";
        String user; // assumes database name is the same as username
        user = "root";
        String password = "ultimate1";
        Object o1 = session.getAttribute("account_id");
        Object o2 = session.getAttribute("username");
        if(o1 != null) {
            String account_id = (String)o1;
            String username = (String)o2;
            %>
            <div class="header">
                <img src="RecipeBook.jpeg" alt="Recipe Book Logo" class="logo"> 
                <header class="title">My Grocery Lists</header>
                <br/> 
                <form action="GroceryList.jsp" method="post">    
                <input type="submit" value="Home" name="home" class="home_button"/>
                <input type="submit" value="Create Recipe" name="create_recipe" class="home_button"/>
                <input type="submit" value="My Grocery Lists" name="my_grocery_lists" class="home_button"/>
                <input type="submit" value="Sign Out" name="sign_out" class="home_button"/>
                </form>
            </div>
            <br style="clear:both" />
            <%
            try {
                java.sql.Connection con; 
                Class.forName("com.mysql.jdbc.Driver");
                
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Recipe_Book?autoReconnect=true&useSSL=false",user, password);
                Statement stmt = con.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT * FROM Grocery_List");
                while (rs.next()) { 
                    String grocery_list_id = rs.getString(1);
                    %><table><% 
                    out.println("GroceryList: " + rs.getString(3) + "<br>Description: " + rs.getString(4) + "<br>");
                    %>
                        <form action="GroceryItem.jsp" method="post">
                            <input type="hidden" value="<%=rs.getString(3)%>" name="grocery_list_title">
                            <input type="hidden" value=<%=grocery_list_id%> name="grocery_list_id"/>
                            <input type="submit" value="View Grocery List" name="view_grocery_list"/>
                        </form>
                    
                        <form action="GroceryList.jsp" method="post">
                            <input type="hidden" value="<%=rs.getString(3)%>" name="grocery_list_title">
                            <input type="hidden" value=<%=grocery_list_id%> name="grocery_list_id"/>
                            <input type="submit" value="Delete Grocery List" name="remove_grocery_list"/>
                        </form>
                    
                        </table></br>
                    <%
                }
                String grocery_list_id_from_form = request.getParameter("grocery_list_id");
                String grocery_title_from_form = request.getParameter("grocery_list_title");
                String remove_grocery_list = request.getParameter("remove_grocery_list");
                String edit_grocery_list = request.getParameter("edit_grocery_list");
                String view_grocery_list = request.getParameter("view_grocery_list");

                if(view_grocery_list != null) {
                    session.setAttribute("grocery_list_title", grocery_title_from_form);
                    session.setAttribute("view_grocery_list", grocery_list_id_from_form);
                    response.sendRedirect("GroceryItem.jsp");
                }
                if(remove_grocery_list != null) {
                    Statement stmt2 = con.createStatement();
                    try {
                        int i = stmt.executeUpdate("DELETE FROM Grocery_List WHERE grocery_list_id=" + "'" + grocery_list_id_from_form + "'");
                        response.sendRedirect("GroceryList.jsp");
                    } catch (SQLException e) {
                        out.println("Something went wrong.<br/>");
                    }
                } 
                if(edit_grocery_list != null) {
                    session.setAttribute("curr_grocery_list_id", grocery_list_id_from_form);
                    response.sendRedirect("GroceryList.jsp");
                }
                rs.close();
                stmt.close();
                con.close();
            } catch(SQLException e) { 
                out.println("Something went wrong.<br/>");
            }
            if(request.getParameter("home") != null) {
                response.sendRedirect("HomePage.jsp");
            }
            if(request.getParameter("create_recipe") != null) {
                response.sendRedirect("CreateRecipe.jsp");
            }
            if(request.getParameter("sign_out") != null) {
                session.invalidate();
                out.print("Signed Out.\n");
                response.sendRedirect("LoginPage.jsp");
            }
        } else {
            out.println("You don't have access to this page.<br/>");
        }
    %>
  </body>
</html>



