<%@ page import="java.sql.*"%>
<html>
<link rel="stylesheet" href="style.css"> 
  <head>
    <title>GroceryList</title>
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
                <form action="GroceryList.jsp" method="post">  
                    Grocery List Title:<input type="text" name="grocery_list_title"/><br/><br/>  
                    Short Description:<input type="text" name="desc"/><br/><br/> 
                    <input type="submit" value="Add Grocery List"/>
                </form> 
                <br/>
                <form action="LoginPage.jsp" method="post"> 
                    <input type="submit" value="Sign Out" name="sign_out"/>
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
                            <input type="hidden" value="<%=rs.getString(3)%>" name="recipe_title">
                            <input type="hidden" value=<%=recipe_id%> name="recipe_id"/>
                            <input type="submit" value="View Recipe" name="view_recipe"/>
                            <input type="submit" value="Edit Recipe" name="edit_recipe"/>
                            <input type="submit" value="Delete Recipe" name="remove_recipe"/>
                        </form>
                        </table></br>
                    <%
                }
                String remove_recipe = request.getParameter("remove_recipe");
                String edit_recipe = request.getParameter("edit_recipe");
                String recipe_id_from_form = request.getParameter("recipe_id");
                String view_recipe = request.getParameter("view_recipe");
                String recipe_title_from_form = request.getParameter("recipe_title");
                if(view_recipe != null) {
                    session.setAttribute("recipe_title", recipe_title_from_form);
                    session.setAttribute("view_recipe_id", recipe_id_from_form);
                    response.sendRedirect("ViewRecipe.jsp");
                }
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



