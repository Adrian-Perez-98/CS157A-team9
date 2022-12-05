<%@ page import="java.sql.*"%>
<html>
<link rel="stylesheet" href="style.css"> 
  <head>
    <title>My Recipes</title>
    </head>
  <body>
      <% 
        String db = "CS157A";
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
                <header class="title">My Recipes</header>
                <br/> 
                <form action="HomePage.jsp" method="post">    
                <input type="submit" value="Home" name="home" class="home_button"/>
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
                ResultSet rs = stmt.executeQuery("SELECT * FROM Recipe WHERE account_id=" + "'" + account_id + "'");
                while(rs.next()) {
                    String recipe_id = rs.getString(1);
                    %><table><% 
                     out.println("Recipe: " + rs.getString(3) + "<br>Description: " + rs.getString(4) + "<br>"); 
                    %>
                        <form action="MyRecipes.jsp" method="post">
                            <input type="hidden" value=<%=recipe_id%> name="recipe_id"/>
                            <input type="submit" value="Delete Recipe" name="remove_recipe"/>
                            <input type="submit" value="Edit Recipe" name="edit_recipe"/>
                        </form>
                        </table></br>
                    <%
                }
                String remove_recipe = request.getParameter("remove_recipe");
                String edit_recipe = request.getParameter("edit_recipe");
                String recipe_id_from_form = request.getParameter("recipe_id");
                if(remove_recipe != null) {
                    Statement stmt2 = con.createStatement();
                    try {
                        int i = stmt.executeUpdate("DELETE FROM Recipe WHERE recipe_id=" + "'" + recipe_id_from_form + "'");
                        response.sendRedirect("MyRecipes.jsp");
                    } catch (SQLException e) {
                        out.println("Something went wrong.<br/>");
                    }
                } 
                if(edit_recipe != null) {
                    session.setAttribute("curr_recipe_id", recipe_id_from_form);
                    response.sendRedirect("EditRecipe.jsp");
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
    %>
  </body>
</html>