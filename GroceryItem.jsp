<%@ page import="java.sql.*"%>
<html>
  <head>
    <title>Grocery Form</title>
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
            String grocery_item_id = (String)session.getAttribute("grocery_item_id");
            %>
                <h3>Recipe Form</h3>
                <form action="GroceryItem.jsp" method="post">  
                    Grocery Item Name:<input type="text" name="grocery_item_name"/><br/><br/>  
                    Short Description:<input type="text" name="desc"/><br/><br/> 
                    Price:<input type="text" name="price"/><br/><br/> 
                    <input type="submit" value="Add Grocery Item"/>
                </form> 
                <br/>
                <form action="LoginPage.jsp" method="post"> 
                    <input type="submit" value="Sign Out" name="sign_out"/>
                </form>
            <%
            out.println(username + " is signed in."); 
            try {
                String grocery_item_name = request.getParameter("grocery_item_name");
                String short_desc = request.getParameter("desc");
                String price = request.getParameter("price");
                if(grocery_item_name != "" && short_desc != "" && price != "") {
                    int private_int = 0;
                    if(private_val != null) {
                        private_int = 1;
                    }
                    java.sql.Connection con; 
                    Class.forName("com.mysql.jdbc.Driver");
                    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Recipe_Book?autoReconnect=true&useSSL=false",user, password);
                    
                    Statement stmt = con.createStatement();
                    int i = stmt.executeUpdate("INSERT INTO Grocery_Item(grocery_item_id, name, description, price) " + 
                    "VALUES('" + grocery_item_id + "', '" + grocery_item_name + "', '" + short_desc + "', '" + price +  "')");
                    out.println("Grocery Item has been added."); 
                    stmt.close();
                    con.close();
                } else {
                    out.println("Missing fields! make sure: Grocery Item, Description, and Price are added"); 
                }
            } catch(SQLException e) { 
                out.println("Something went wrong.<br/>");
            }
        } else {
            out.println("You don't have access to this page.");
        }
    %>
  </body>
</html>