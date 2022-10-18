<%@ page import="java.sql.*"%>
<html>
  <head>
    <title>Demo</title>
    </head>
  <body>
    <h1>RecipeBook</h1>
    
    <table border="1">
      <tr>
        <td>Ingredient ID</td>
        <td>Food Name</td>
        <td>Description</td>
   </tr>
    <% 
        String db = "CS157A";
        String user; // assumes database name is the same as username
        user = "root";
        String password = "ultimate1";
        try {
            
            java.sql.Connection con; 
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Recipe_Book?autoReconnect=true&useSSL=false",user, password);
            out.println(db + " database successfully opened.<br/><br/>");
            
            out.println("Initial entries in table \"Ingredient\": <br/>");
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM Ingredient");
            while (rs.next()) {
                out.println(rs.getInt(1) + " " + rs.getString(2) + ": " + rs.getString(3) + "<br/><br/>");
            }
            rs.close();
            stmt.close();
            con.close();
        } catch(SQLException e) { 
            out.println("SQLException caught: " + e.getMessage()); 
        }
    %>
  </body>
</html>
