<%@ page import="java.sql.*"%>
<html>
  <head>
    <title>Sign Up</title>
    </head>
  <body>
    <h3>Sign Up Form</h3>  
    <br/>  
    <form action="SignUp.jsp" method="post"> 
    Username:<input type="text" name="username"/><br/><br/>   
    Email:<input type="text" name="email"/><br/><br/>  
    Password:<input type="password" name="password"/><br/><br/>  
    <input type="submit" value="Sign Up"/>
    </form> 
    <% 
        String db = "CS157A";
        String user; // assumes database name is the same as username
        user = "root";
        String password = "ultimate1";
        String form_username = request.getParameter("username");
        String form_user_email = request.getParameter("email");
        String form_password = request.getParameter("password");

        try {
            java.sql.Connection con; 
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Recipe_Book?autoReconnect=true&useSSL=false",user, password);
            
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM User WHERE username='" + form_username + "'");
            if(!rs.next()) {
                try {
                    Statement stmt2 = con.createStatement();
                    int i = stmt2.executeUpdate("INSERT INTO User(username, email, password)" +
                    "Values('" + form_username + "','" + form_user_email + "','" + form_password + "')");
                    out.print("User Added\n");
                    %>
                    <form action="LoginPage.jsp" method="post">
                        <input type="submit" value="Back to Login"/>
                    </form> 
                    <%
                } catch (Exception e) {
                    out.print("User was not added\n");
                    out.print("User alredy exists\n");
                }
            } else {
              out.print("User alredy exists");
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