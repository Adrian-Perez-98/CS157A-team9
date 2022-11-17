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
                <h3>My Recipes</h3>    
            <%
            try {
                java.sql.Connection con; 
                Class.forName("com.mysql.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Recipe_Book?autoReconnect=true&useSSL=false",user, password);
                Statement stmt = con.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT * FROM Recipe WHERE account_id=" + "'" + account_id + "'");
                while(rs.next()) {
                     out.println("Recipe: " + rs.getString(3) + "<br><br>"); 
                } 
                stmt.close();
                con.close();
            } catch(SQLException e) { 
                out.println("SQLException caught: " + e.getMessage()); 
            }
            %>
                <br/>
                <form action="LoginPage.jsp" method="post"> 
                    <input type="submit" value="Sign Out" name="sign_out"/>
                </form>
            <%
        } else {
            out.println("You don't have access to this page.");
        }
    %>
  </body>
</html>