<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.air.*" import="java.util.*" import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
    <title>Answer Question</title>
</head>
<body>

<%@ page import ="java.sql.*" %>
    <form action="../custRepLogout.jsp" method="post">
        <input type="submit" value="Logout">
    </form>
    <form action="questionList.jsp" method="post">
        <input type="submit" value="Back">
    </form>

<h2>Answer Question</h2>
<%
    String qId = request.getParameter("qId");
	ApplicationDB db = new ApplicationDB();
    String question = "";
    String customer = "";

    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = db.getConnection();	
        Statement st = con.createStatement();
        ResultSet rs = st.executeQuery("SELECT * FROM qna WHERE q_id = " + qId);

        if(rs.next()) {
            question = rs.getString("question");
            customer = rs.getString("customer");
        }
%>
<p><strong>Customer:</strong> <%=customer%></p>
<p><strong>Question:</strong> <%=question%></p>

<%
        String message = "";
        if("POST".equalsIgnoreCase(request.getMethod())) {
            String answer = request.getParameter("answer");
            String answeredBy = request.getParameter("answeredBy");

            try {
                PreparedStatement pst = con.prepareStatement("UPDATE qna SET answer = ?, answered_by = ? WHERE q_id = ?");
                pst.setString(1, answer);
                pst.setString(2, answeredBy);
                pst.setInt(3, Integer.parseInt(qId));

                int rowsUpdated = pst.executeUpdate();
                if(rowsUpdated > 0) {
                    message = "Successfully answered, you can now leave the page.";
                } else {
                    message = "Answer submission failed.";
                }
            } catch (SQLException e) {
                message = "Answer submission failed: " + e.getMessage();
            }
        }
%>
<form method="POST">
    <label for="answer">Answer:</label><br/>
    <textarea name="answer" rows="5" cols="50"></textarea><br/>
    <label for="answeredBy">Answered By:</label><br/>
    <input type="text" name="answeredBy" /><br/>
    <input type="submit" value="Submit Answer"/>
</form>

<p><%=message%></p>
<%
        rs.close();
        st.close();
        con.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
</body>
</html>
