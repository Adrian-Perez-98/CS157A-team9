<%@ page import="java.sql.*"%>
<html>
  <head>
    <title>Recipe Form</title>
    </head>
  <body>
    <h3>Recipe Form</h3>  
    <br/>  
    <form action="CreateRecipe.jsp" method="post">  
    Recipe Title:<input type="text" name="recipe_name"/><br/><br/>  
    Description:<input type="text" name="desc"/><br/><br/> 
    Peperation Time:<input type="text" name="prep_time"/><br/><br/> 
    Cook Time:<input type="text" name="cook_time"/><br/><br/>
    Image:<input type = "file" name = "file"/><br/><br/>
    <input type="submit" value="Add Recipe"/>
    </form> 
    <% 
        String db = "CS157A";
        String user; // assumes database name is the same as username
        user = "root";
        String password = "ultimate1";
        //String form_user_email = request.getParameter("email");
        //String form_password = request.getParameter("password");

        try {
            java.sql.Connection con; 
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Recipe_Book?autoReconnect=true&useSSL=false",user, password);
            
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM Users");
            


            rs.close();
            stmt.close();
            con.close();
        } catch(SQLException e) { 
            out.println("SQLException caught: " + e.getMessage()); 
        } 
    %>
  </body>
</html>