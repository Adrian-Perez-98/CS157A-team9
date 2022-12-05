<%@ page import="java.sql.*"%>
<html>
<link rel="stylesheet" href="style.css">  
  <body>
    <div class="login">
      <img src="RecipeBook.jpeg" alt="Recipe Book Logo" class="logo_login"> 
      <br style="clear:both" />
      <header class="title">Login</header>
      <br/>  
    </div>

    <div class="content">
      <form class="login_signup_form" action="LoginPage.jsp" method="post">  
      Email:<input type="text" name="email"/><br/><br/>  
      Password:<input type="password" name="password"/><br/><br/>  
      <input type="submit" value="login" name="login"/>
      <input type="submit" name="signup" value="Sign Up"/>
      </form> 
    </div>
    <% 
        if(request.getParameter("signup") != null) {
            response.sendRedirect("SignUp.jsp");
        }

        String db = "CS157A";
        String user; // assumes database name is the same as username
        user = "root";
        String password = "ultimate1";
        String form_user_email = request.getParameter("email");
        String form_password = request.getParameter("password");
        String logged_in = request.getParameter("login");

        if(logged_in != null && logged_in.equals("login")) {
            try {
              java.sql.Connection con; 
              Class.forName("com.mysql.jdbc.Driver");
              con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Recipe_Book?autoReconnect=true&useSSL=false",user, password);
              
              Statement stmt = con.createStatement();
              ResultSet rs = stmt.executeQuery("SELECT * FROM User WHERE username='" + form_user_email + "' AND password='" + form_password + "'");
              
              if(rs.next()) {
                out.print("Hello " + rs.getString(2) + "!"); 
                session.setAttribute("account_id",rs.getString(1));
                session.setAttribute("username",rs.getString(2));
                response.sendRedirect("HomePage.jsp");
                //response.sendRedirect("CreateRecipe.jsp");
              } else {
                out.print("User and password does not exists");
              }

              rs.close();
              stmt.close();
              con.close();
          } catch(SQLException e) { 
              out.println("SQLException caught: " + e.getMessage()); 
          } 
        }
        if(request.getParameter("sign_out") != null) {
            session.invalidate();
            out.print("Signed Out.\n");
            //response.sendRedirect("LoginPage.jsp");
        }
    %>
  </body>
</html>