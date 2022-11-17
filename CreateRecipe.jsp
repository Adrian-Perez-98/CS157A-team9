<%@ page import="java.sql.*"%>
<html>
  <head>
    <title>Recipe Form</title>
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
            out.println("Hello " + username + "!"); 
            %>
                <h3>Recipe Form</h3> <br/>  
                <form action="CreateRecipe.jsp" method="post">  
                    Recipe Title:<input type="text" name="recipe_name"/><br/><br/>  
                    Short Description:<input type="text" name="desc"/><br/><br/> 
                    Peperation Time:<input type="text" name="prep_time"/><br/><br/> 
                    Cook Time:<input type="text" name="cook_time"/><br/><br/>
                    Image:<input type = "file" name = "image"/><br/><br/>
                    Recipe's How To:<br/><textarea name="how_to" rows="8" cols="50">Please describe how to prepare this recipe.</textarea><br/><br/>
                    Should this recipe be private? <input type="checkbox" name="private"><br/><br/>
                    <input type="submit" value="Add Recipe"/>
                </form> 
                <br/>
                <form action="CreateRecipe.jsp" method="post"> 
                    <input type="submit" value="Sign Out" name="sign_out"/>
                </form>
            <%
            try {
                String recipe_name = request.getParameter("recipe_name");
                String short_desc = request.getParameter("desc");
                String prep_time = request.getParameter("prep_time");
                String cook_time = request.getParameter("cook_time");
                String private_val = request.getParameter("private");
                String image = request.getParameter("image");
                String how_to = request.getParameter("how_to");
                if(recipe_name != "" && short_desc != "" && prep_time != "" && cook_time != "") {
                    int private_int = 0;
                    if(private_val != null) {
                        private_int = 1;
                    }
                    java.sql.Connection con; 
                    Class.forName("com.mysql.jdbc.Driver");
                    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Recipe_Book?autoReconnect=true&useSSL=false",user, password);
                    
                    Statement stmt = con.createStatement();
                    //ResultSet rs = stmt.executeQuery("SELECT * FROM User");
                    int i = stmt.executeUpdate("INSERT INTO Recipe(account_id, title, description, prep_time, cook_time, image_url, how_to, private) " + 
                    "VALUES('" + account_id + "', '" + recipe_name + "', '" + short_desc + "', '" + prep_time + "', '" + cook_time + "', '" + image + "', '" + how_to + "', '" + private_int +  "')");
                    out.println("Recipe has been added."); 

                    stmt.close();
                    con.close();
                } else {
                    out.println("Missing fields! make sure: Recipe Title, Short Description, Peperation Time, and Cook Time are filled out."); 
                }
            } catch(SQLException e) { 
                out.println("SQLException caught: " + e.getMessage()); 
            }

            if(request.getParameter("sign_out") != null) {
                session.invalidate();
                response.sendRedirect("LoginPage.jsp");
            }
        } else {
            out.println("You don't have access to this page."); 
        }
    %>
  </body>
</html>