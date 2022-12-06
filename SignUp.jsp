<%@ page import="java.sql.*"%>
<html>
<link rel="stylesheet" href="style.css"> 
  <body>
    <div class="login">
      <img src="RecipeBook.jpeg" alt="Recipe Book Logo" class="logo_login"> 
      <br style="clear:both" />
      <header class="title">Sign Up</header>
      <br/>  
    </div>
    <br/>  
    <div class="content">
      <form action="SignUp.jsp" method="post"> 
      Username:<input type="text" name="username"/><br/><br/>   
      Email:<input type="text" name="email"/><br/><br/>  
      Password:<input type="password" name="password"/><br/><br/>  
      <input type="submit" value="Sign Up" name="sign_up"/>
      </form> 
    <% 
        String db = "CS157A";
        String user; // assumes database name is the same as username
        user = "root";
        String password = "ultimate1";
        String form_username = request.getParameter("username");
        String form_user_email = request.getParameter("email");
        String form_password = request.getParameter("password");

        if(form_username != "" && form_user_email != "" && form_password != "" && request.getParameter("sign_up") != null) {
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
                            out.print("User already exists.\n");
                        }
                    } else {
                      out.print("User already exists.\n");
                    }
                
                    rs.close();
                    stmt.close();
                    con.close();
                } catch(SQLException e) { 
                    out.println("SQLException caught: " + e.getMessage()); 
                } 
        }
    %>
    </div>
  </body>
</html>