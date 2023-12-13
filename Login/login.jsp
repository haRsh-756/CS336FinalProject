<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
</head>
<body>
	<% 
        // Check if an error message is present in the session
        String errorMessage = (String)session.getAttribute("errorMessage");
        if (errorMessage != null) {
    %>
            <p style="color: red;"><%= errorMessage %></p>
    <%
            // Clear the error message from the session
            session.removeAttribute("errorMessage");
        }
    %>
    <%String account = (String) session.getAttribute("selectedAccount"); %>
    <p> You have selected: <%=account%> account</p>
	<form action="loginDetails.jsp" method="POST">
		Username: <input type="text" name="username"/> <br/>
		Password:<input type="password" name="password"/> <br/>
	<input type="submit" value="Submit"/>
	</form>
	<% if ("customer".equals(account)) { %>
	    <p><a href ="newAccount.jsp">Create Account</a></p>
	<% } %>
	<p><a href = "landing.jsp">Home</a></p>
</body>
</html>
