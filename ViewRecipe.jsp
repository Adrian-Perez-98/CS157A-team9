<%@ page import="java.sql.*"%>
<html>
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
        String view_recipe_id = (String)session.getAttribute("view_recipe_id");
        //String title = "";

        Statement stmt = con.createStatement();
        try {
            ResultSet rs = stmt.executeQuery("SELECT * FROM Recipe WHERE recipe_id='" + view_recipe_id + "'");
            if(rs.next()) {
                    String title = rs.getString(3);
                    String description = rs.getString(4);
                    String prep_time = rs.getString(5);
                    String cook_time = rs.getString(6);
                    String image = rs.getString(7);
                    String how_to = rs.getString(8);
                    String recipe_private = rs.getString(9);
                    if(recipe_private == "1") {
                        recipe_private = "Private";
                    } else {
                        recipe_private = "Not Private";
                    }
            }
        } catch(SQLException e) {
            out.println("Something went wrong.<br/>");
        } 

        if(account_id != null) { 
            %>
            <div class="header">
              <img src="RecipeBook.jpeg" alt="Recipe Book Logo" class="logo"> 
              <header class="title">Viewing: title </header>
              <br/> 
              <form action="HomePage.jsp" method="post">    
                <input type="submit" value="My Recipes" name="my_recipes" class="home_button"/>
                <input type="submit" value="My Grocery Lists" name="my_grocery_lists" class="home_button"/>
                <input type="submit" value="Sign Out" name="sign_out" class="home_button"/>
            </form>
            </div>
            <br style="clear:both" />
          <%


        } else {
            out.println("You don't have access to this page.<br/>");
        }
    %>
  </body>
</html>