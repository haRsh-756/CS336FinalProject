<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.air.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form method="POST">
       Enter A Username: <input type="text" name="Username"/> <br/>
       Enter A Password: <input type="password" name="Password"/> <br/>
       <input type="submit" value="Submit"/>
	</form>
	<%@ page import ="java.sql.*" %>
	<%
		if("POST".equalsIgnoreCase(request.getMethod())){
			String username = request.getParameter("Username");
            String password = request.getParameter("Password");
            ApplicationDB db = new ApplicationDB();	
        	Connection con = db.getConnection();	
        	Statement stmt = con.createStatement();
            
            ResultSet rs;
            rs = stmt.executeQuery("select * from admin where username='" + username + "'");
            if (rs.next()) {
    %>
            	<p style="color: green;">Username exists!!.</p>
    <% 
            	out.println("Please login using this link <a href='adminLogin.jsp'>Login</a>");
            } else {
            	int x = stmt.executeUpdate("insert into admin (username, password) values('" + username + "', '" + password + "')");
            	con.close();
            	//if(x < 0){ //error in inserting 
            	//	out.println();
            	//}
            	session.setAttribute("user", username); // the username will be stored in the session
                response.sendRedirect("adminSuccess.jsp");
            }
		}
	%>
</body>
</html>