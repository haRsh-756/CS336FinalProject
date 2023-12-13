<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	if ((session.getAttribute("user") == null)) {
	%>
	You are not logged in<br/>
	<a href="adminLogin.jsp">Please Login</a>
	<%} 
	else {
	%>
		Welcome <%=session.getAttribute("user")%> <% //this will display the username that is stored in the session.%>
		<!-- <a href='logout.jsp' class="button">Log out</a> -->
		<a href='adminLogout.jsp'><button>Logout</button></a>
		<a href='accountEdit.jsp'><button>Account Edit</button></a>
		<a href='flightFinanceSearch.jsp'><button>Flight Information & Finance Search</button></a>
	<%
	}
	%>
</body>
</html>