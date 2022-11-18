<%@ page import="java.sql.*"%>
<html>
  <head>
    <title>Recipe Edit Form</title>
    </head>
  <body>
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
        String curr_recipe_id = (String)session.getAttribute("curr_recipe_id");
        String updated = (String)session.getAttribute("updated");

        
        if(account_id != null) {

            //out.println("Hello " + curr_recipe_id + " !");
            Statement stmt = con.createStatement();
            try {
                ResultSet rs = stmt.executeQuery("SELECT * FROM Recipe WHERE account_id='" + account_id + "' AND recipe_id='" + curr_recipe_id + "'");
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

                    %>
                    <h3>Recipe Edit Form</h3> 
                    <form action="EditRecipe.jsp" method="post">  
                        Recipe Title:<input type="text" value="<%=title%>" name="recipe_name"/><br/><br/>  
                        Short Description:<input type="text" value="<%=description%>" name="desc"/><br/><br/> 
                        Peperation Time:<input type="text" value="<%=prep_time%>" name="prep_time"/><br/><br/> 
                        Cook Time:<input type="text" value="<%=cook_time%>" name="cook_time"/><br/><br/> 
                        Image:<input type = "file" value="<%=image%>" name = "image"/><br/><br/>
                        Recipes How To:<br/><textarea name="how_to" rows="8" cols="50"><%=how_to%></textarea><br/><br/>
                        Should this recipe be private? (<%=recipe_private%>) <input type="checkbox" name="private"><br/><br/>
                        <input type="submit" value="Save Changes" name="save_changes"/>
                    </form> 
                    <%

                    String new_title = request.getParameter("recipe_name");
                    String new_description = request.getParameter("desc");
                    String new_prep_time = request.getParameter("prep_time");
                    String new_cook_time = request.getParameter("cook_time");
                    String new_image = request.getParameter("image");
                    String new_how_to = request.getParameter("how_to");
                    String private_val = request.getParameter("private");
                    //out.println(private_val + "<br>");

                    int private_int = 0;
                    if(private_val != null) {
                        private_int = 1;
                    }
                    //out.println(private_int + "<br>");

                    if(request.getParameter("save_changes") != null) {
                        try {
                            Statement stmt2 = con.createStatement();
                            int j = stmt.executeUpdate("UPDATE Recipe SET title='" + new_title + "', description='" + new_description +
                            "', prep_time='" + new_prep_time + "', cook_time='" + new_cook_time + "', image_url='" + new_image + "', how_to='" + new_how_to +
                            "', private='" + private_int + "' WHERE account_id='" + account_id + "' AND recipe_id='" + curr_recipe_id + "'");
                            response.sendRedirect("EditRecipe.jsp");
                        } catch(SQLException e){
                            out.println("Something went wrong. <br/>");
                        }
                    }
                    %>
                    <form action="LoginPage.jsp" method="post"> 
                        <input type="submit" value="Sign Out" name="sign_out"/>
                    </form>
                    <%

                }
                rs.close();
                stmt.close();
                con.close();
            } catch(SQLException e) {
                out.println("Something went wrong.<br/>");
            }
            out.println(username + " is signed in.<br/>"); 
        } else {
            out.println("You don't have access to this page.<br/>");
        }
    %>
  </body>
</html>