<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.air.*" import="java.util.*" import="java.sql.*"%>
<%@ page session="true" %>
<!DOCTYPE html>

<html>
<head>
    <title>Your Questions</title>
    <style>
        .qa-block {
            border: 1px solid #ddd;
            padding: 10px;
            margin-top: 10px;
            background-color: #f9f9f9;
        }
        .question, .answer {
            margin-bottom: 5px;
        }
        .question-title {
            font-weight: bold;
        }
        .answer-title {
            font-weight: bold;
        }
    </style>
</head>
<body>
<%@ page import ="java.sql.*" %>
    <form action="../custLogout.jsp" method="post">
        <input type="submit" value="Logout">
    </form>
    <form action="qnaSearch.jsp" method="post">
        <input type="submit" value="Back">
    </form>

<h2>Your Questions</h2>

<%
    String customer = (String) session.getAttribute("user");
	ApplicationDB db = new ApplicationDB();

    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = db.getConnection();
        PreparedStatement pst = con.prepareStatement("SELECT question, answer FROM qna WHERE customer = ?");
        pst.setString(1, customer);
        ResultSet rs = pst.executeQuery();

        while(rs.next()) {
            String question = rs.getString("question");
            String answer = rs.getString("answer");
%>
    <div class="qa-block">
        <div class="question">
            <span class="question-title">Question:</span> <%=question%>
        </div>
        <div class="answer">
            <span class="answer-title">Answer:</span> <%=answer != null ? answer : "Pending"%>
        </div>
    </div>
<%
        }
        rs.close();
        pst.close();
        con.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

</body>
</html>
