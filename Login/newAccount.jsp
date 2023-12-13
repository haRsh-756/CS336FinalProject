<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import = "com.air.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>New Account Page</title>
</head>
<body>
	<form method="POST">
       Enter A Username: <input type="text" name="Username"/> <br/>
       Enter A Password: <input type="password" name="Password"/> <br/>
       <input type="submit" value="Submit"/>
	</form>
	<%@ page import ="java.sql.*" %>
	<%
		String account = (String)session.getAttribute("selectedAccount");
		if("POST".equalsIgnoreCase(request.getMethod()) && account != null){
			String username = request.getParameter("Username");
            String password = request.getParameter("Password");
            //String account = (String)session.getAttribute("selectedAccount");
            ApplicationDB db = new ApplicationDB();	
        	java.sql.Connection con = db.getConnection();	
        	Statement stmt = con.createStatement();
            
            ResultSet rs;
            rs = stmt.executeQuery("select * from "+ account +" where binary username='" + username + "'");
            if (rs.next()) {
    %>
            	<p style="color: green;">Username exists!!.</p>
    <% 
            	out.println("Please login using this link <a href='login.jsp'>Login</a>");
            } else {
            	int x = stmt.executeUpdate("insert into " + account + " (username, password) values('" + username + "', '" + password + "')");
            	con.close();
            	//if(x < 0){ //error in inserting 
            	//	out.println();
            	//}
            	session.setAttribute("user", username); // the username will be stored in the session
                response.sendRedirect("Customer/custSuccess.jsp");
            }
		}
	%>
</body>
</html>