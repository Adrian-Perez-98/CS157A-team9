<%@ page import="java.sql.*"%>
<html>
  <link rel="stylesheet" href="style.css">  
  <body>
    <% 
        String db = "CS157A";
        String user; // assumes database name is the same as username
        user = "root";
        String password = "ultimate1";

        String account_id = (String)session.getAttribute("account_id");
        String username = (String)session.getAttribute("username");

        if(account_id != null) { 
          %>
            <div class="header">
              <img src="RecipeBook.jpeg" alt="Recipe Book Logo" class="logo"> 
              <header class="title">Home</header>
              <br/> 
              <form action="HomePage.jsp" method="post">    
                <input type="submit" value="My Recipes" name="my_recipes" class="home_button"/>
                <input type="submit" value="My Grocery Lists" name="my_grocery_lists" class="home_button"/>
                <input type="submit" value="Sign Out" name="sign_out" class="home_button"/>
            </form>
            </div>
            <br style="clear:both" />

            <div class="container">
            <form class="form-inline" method="post" action="HomePage.jsp">
              <input type="text" name="title" class="form-control" placeholder="Search title..">
              <button type="submit" name="save" class="btn btn-primary">Search</button>
            </form>
            </div>
          <%
          String search_title = request.getParameter("title");
          if(search_title != null) {

            try {
              java.sql.Connection con; 
              Class.forName("com.mysql.jdbc.Driver");
              con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Recipe_Book?autoReconnect=true&useSSL=false",user, password);
              Statement stmt = con.createStatement();
              ResultSet rs = stmt.executeQuery("SELECT * FROM Recipe WHERE private=0 AND NOT account_id=" + "'" + account_id + "' AND title LIKE '%" + search_title + "%'");
              while(rs.next()) {
                String recipe_id = rs.getString(1);
                out.println("Recipe: " + rs.getString(3) + "<br>Description: " + rs.getString(4) + "<br>"); 
                %>
                    <form action="HomePage.jsp" method="post">
                        <input type="hidden" value="<%=rs.getString(3)%>" name="recipe_title">
                        <input type="hidden" value=<%=recipe_id%> name="recipe_id"/>
                        <input type="submit" value="View Recipe" name="view_recipe"/>
                    </form>
                    </table>
                <%
              }
            } catch(SQLException e) { 
                  out.println("Something went wrong.<br/>");
            }
          }

          if(account_id != null) {
            System.out.print("we good.");
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
          try {
            %>
            <br><header><b>Recomended Recipes</b></header><br>
            <%
            java.sql.Connection con; 
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Recipe_Book?autoReconnect=true&useSSL=false",user, password);
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM Recipe WHERE private=0 AND NOT account_id=" + "'" + account_id + "'");
            while(rs.next()) {
                String recipe_id = rs.getString(1);
                %><table><% 
                  out.println("Recipe: " + rs.getString(3) + "<br>Description: " + rs.getString(4) + "<br>"); 
                %>
                    <form action="HomePage.jsp" method="post">
                        <input type="hidden" value="<%=rs.getString(3)%>" name="recipe_title">
                        <input type="hidden" value=<%=recipe_id%> name="recipe_id"/>
                        <input type="submit" value="View Recipe" name="view_recipe"/>
                    </form>
                    </table></br>
                <%
            }
            String view_recipe = request.getParameter("view_recipe");
            String recipe_id_from_form = request.getParameter("recipe_id");
            String recipe_title_from_form = request.getParameter("recipe_title");

            if(view_recipe != null) {
                session.setAttribute("recipe_title", recipe_title_from_form);
                session.setAttribute("view_recipe_id", recipe_id_from_form);
                response.sendRedirect("ViewRecipe.jsp");
            }
            rs.close();
            stmt.close();
            con.close();
          } catch(SQLException e) { 
                  out.println("Something went wrong.<br/>");
          }
        } else {
            out.println("You don't have access to this page.<br/>");
        }
    %>
    </body>
</html>