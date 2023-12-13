<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<% out.println("Welcome"); %>
	<form method ="POST">
	  <fieldset>
	    <legend>Please select your account type:</legend>
	    <div>
	      <input
	        type="radio"
	        id="accChoice1"
	        name="account"
	        value="customer"
	        checked />
	      <label for="accChoice1">Customer</label>
	
	      <input type="radio" id="accChoice2" name="account" value="custrep" />
	      <label for="accChoice2">Customer Representative</label>
	
	      <input type="radio" id="accChoice3" name="account" value="admin" />
	      <label for="accChoice3">Administrator</label>
	    </div>
	    <div>
	      <button type="submit">Submit</button>
	    </div>
	  </fieldset>
	</form>
	<%
	if("POST".equalsIgnoreCase(request.getMethod())){
		String selectedValue = request.getParameter("account");
		if (selectedValue != null) {
	        // Set the selected contact method in the session
	        session.setAttribute("selectedAccount", selectedValue);

	        // Redirect to the appropriate page based on the selected value
	        /* switch (selectedValue) {
	            case "custRep":
	                response.sendRedirect("CustRep/custRepLogin.jsp");
	                break;
	            case "admin":
	                response.sendRedirect("Admin/adminLogin.jsp");
	                break;
	            default:
	            	response.sendRedirect("Customer/custLogin.jsp");
	            	break;
	                // Handle default case or do nothing
	        } */
	        response.sendRedirect("login.jsp");
	    } else {
	        out.println("Something went wrong");
	        //response.sendRedirect("errorPage.jsp");
	    }
	}
	%>
</body>
</html>