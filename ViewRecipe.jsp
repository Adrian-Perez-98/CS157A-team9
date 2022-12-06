<%@ page import="java.sql.*"%>
<html>
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.10.2/css/all.css" />
    </head>
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
        String recipe_title = (String)session.getAttribute("recipe_title");

        if(account_id != null) { 
            %>
            <div class="header">
              <img src="RecipeBook.jpeg" alt="Recipe Book Logo" class="logo">
              <header class="title">Viewing: ${recipe_title}</header>
              <br/> 
              <form action="HomePage.jsp" method="post"> 
                <input type="submit" value="Home" name="home" class="home_button"/>   
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

        Statement stmt = con.createStatement();
        try {
            ResultSet rs = stmt.executeQuery("SELECT * FROM Recipe WHERE recipe_id='" + view_recipe_id + "'");
            if(rs.next()) {
                    //String title = rs.getString(3);
                    String description = rs.getString(4);
                    String prep_time = rs.getString(5);
                    String cook_time = rs.getString(6);
                    if(rs.getString(6) == null) {
                        cook_time = "0 minutes";
                    }
                    String image = "images/" + rs.getString(7);
                    String how_to = rs.getString(8);
                    %>
                        <div class="content">
                            <header style="padding:10px;" ><b>${recipe_title}</b></header>
                            <img src=<%=image%> alt="Recipe Picture" style="width:150px;height:100px;"><br>
                            <br style="clear:both" />
                        <table style="width:100%">
                            <tr>
                                <td><b>Description:</td>
                                <td></b> <%=description%><br></td>
                            </tr>
                            <tr>
                                <td><b>Prep Time:</b></td>
                                <td><%=prep_time%></td>
                            </tr>
                            <tr>
                                <td><b>Cook Time:</b></td>
                                <td><%=cook_time%></td>
                            </tr>
                            <tr>
                                <td><b>How To Make:</b></td>
                                <td><pre style="font-family: Arial;"><%=how_to%></pre></td>
                            </tr>
                        </table>
                        <br><br>
                        <div class="content">
                        <header style="padding:10px;" ><b>Comments</b></header>
                    <%
            }
        } catch(SQLException e) {
            out.println("Something went wrong.<br/>");
        } 

        Statement stmt2 = con.createStatement();
        try {
            ResultSet rs = stmt.executeQuery("SELECT * FROM Comment NATURAL JOIN User WHERE recipe_id='" + view_recipe_id + "'");
            while(rs.next()) {
                 out.println("Comment: " + rs.getString(3) + "<br>User: " + rs.getString(5) + "<br><br>"); 
            }
             %>
                <br>
                <form action="ViewRecipe.jsp" method="post">
                    <input type="submit" value="Add Comment" name="comment_button">
                    <input type="text" name="comment"/>
                </form></br>
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
                <div class="star-rating">
                    <div class="thanks-msg">Thanks for your feedback !!!</div>
                        <div class="star-input">
                            <input type="radio" name="rating" value="5" id="rating-5">
                            <label for="rating-5" class="fas fa-star"></label>
                            <input type="radio" name="rating" value="4" id="rating-4">
                            <label for="rating-4" class="fas fa-star"></label>
                            <input type="radio" name="rating" value="3" id="rating-3">
                            <label for="rating-3" class="fas fa-star"></label>
                            <input type="radio" name="rating" value="2" id="rating-2">
                            <label for="rating-2" class="fas fa-star"></label>
                            <input type="radio" name="rating" value="1" id="rating-1">
                            <label for="rating-1" class="fas fa-star"></label>
            
                            <form action="ViewRecipe.jsp" method="post">
                                <span class="rating-reaction"></span>
                                <button type="submit" class="submit-rating">Submit</button>
                            </form>
                        </div>
                    </div>
                </div>
            <%

            if(request.getParameter("comment_button") != null && request.getParameter("comment") != "") {
                String comment = request.getParameter("comment");
                try {
                    Statement stmt3 = con.createStatement();
                    int j = stmt3.executeUpdate("INSERT INTO Comment(account_id, comment, recipe_id) VALUES('" + account_id + "', '" + comment + "', '" + view_recipe_id + "')");
                    response.sendRedirect("ViewRecipe.jsp");
                } catch(SQLException e) {
                    out.println(e + " Something went wrong.<br/>");
                } 
            }
            if(request.getParameter("review_button") != null) {
                int rating = 0;   
            }  
        } catch(SQLException e) {
            out.println("Something went wrong.<br/>");
        } 
    %>
  </body>
</html>