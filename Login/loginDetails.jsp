<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import = "com.air.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login Details Page</title>
</head>
<body>
	<%@ page import ="java.sql.*" %>
	<%
	String account = (String)session.getAttribute("selectedAccount");
	String userid = request.getParameter("username");
	String pwd = request.getParameter("password");
	//Class.forName("com.mysql.jdbc.Driver");
	//Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/TravelReservation","root","Techwork#490");
	//import the package first then access applicationdb class
	ApplicationDB db = new ApplicationDB();	
	java.sql.Connection con = db.getConnection();
	Statement st = con.createStatement();
	ResultSet rs;
	rs = st.executeQuery("select * from "+ account +" where binary username = '" + userid + "' and binary password = '" + pwd
	+ "'");
	if (rs.next()){
		if(account.equals("customer")) {
			session.setAttribute("user", userid); // the username will be stored in the session
			//out.println("welcome " + userid);
			//Close the connection. 
			con.close();
			//out.println("<a href='logout.jsp'>Log out</a>");
			response.sendRedirect("Customer/custSuccess.jsp");
		} 
		else if (account.equals("custrep")) {
			session.setAttribute("user", userid); // the username will be stored in the session
			//out.println("welcome " + userid);
			//Close the connection. 
			con.close();
			//out.println("<a href='logout.jsp'>Log out</a>");
			response.sendRedirect("CustRep/custRepSuccess.jsp");
		} 
		else if (account.equals("admin")) {
			session.setAttribute("user", userid); // the username will be stored in the session
			//out.println("welcome " + userid);
			//Close the connection. 
			con.close();
			//out.println("<a href='logout.jsp'>Log out</a>");
			response.sendRedirect("Admin/adminSuccess.jsp");
		}
	}
	else {
		//out.println("Invalid password <a href='login.jsp'>try again</a>");
		// Set an error message in the session
        session.setAttribute("errorMessage", "Invalid username or password. Please try again. Note that both fields maybe case-sensitive");
        // Redirect back to the login page
        response.sendRedirect("login.jsp");
	}
	%>
</body>
</html>