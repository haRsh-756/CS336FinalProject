<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.air.*" import="java.util.*" import="java.sql.*"%>
<%@ page session="true" %>
<!DOCTYPE html>

<html>
<head>
    <title>Ask Question</title>
</head>
<body>

<%@ page import ="java.sql.*" %>
    <form action="../custLogout.jsp" method="post">
        <input type="submit" value="Logout">
    </form>
    <form action="qnaSearch.jsp" method="post">
        <input type="submit" value="Back">
    </form>

<h2>Ask a Question</h2>

<form method="POST">
    <label for="question">Insert Question:</label><br/>
    <textarea name="question" rows="5" cols="50" placeholder="Type your question here"></textarea><br/>
    <input type="submit" value="Submit Question"/>
</form>

<%
    if("POST".equalsIgnoreCase(request.getMethod())) {
        String question = request.getParameter("question");
        String customer = (String) session.getAttribute("user");
        ApplicationDB db = new ApplicationDB();
        String message = "";

        if(question != null && question.length() > 3000) {
            message = "Question entry was too large.";
        } else {
            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = db.getConnection();
                PreparedStatement pst = con.prepareStatement("INSERT INTO qna (question, customer) VALUES (?, ?)", Statement.RETURN_GENERATED_KEYS);
                pst.setString(1, question);
                pst.setString(2, customer);

                int rowsAffected = pst.executeUpdate();
                if(rowsAffected > 0) {
                    message = "Question Successfully Submitted, You can now leave the page.";
                } else {
                    message = "Question Could Not Be Submitted.";
                }

                pst.close();
                con.close();
            } catch (Exception e) {
                message = "Question Could Not Be Submitted: " + e.getMessage();
            }
        }

        out.println("<p>" + message + "</p>");
    }
%>

</body>
</html>
