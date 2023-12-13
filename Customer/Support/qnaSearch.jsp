<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.air.*" import="java.util.*" import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
    <title>Support</title>
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
    <form action="../custSuccess.jsp" method="post">
        <input type="submit" value="Back">
    </form>

<h2>Customer Support</h2>

<a href="yourQuestions.jsp" style="margin-bottom: 20px; display: inline-block;">Your Questions</a>

<form method="GET">
    <label for="keyword">Keyword Search:</label><br/>
    <input type="text" name="keyword" placeholder="Enter keyword"/>
    <input type="submit" value="Search"/>
</form>

<%
    String keyword = request.getParameter("keyword");
    if(keyword != null && !keyword.trim().isEmpty()) {
    	ApplicationDB db = new ApplicationDB();

        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = db.getConnection();	
            PreparedStatement pst = con.prepareStatement("SELECT question, answer FROM qna WHERE question LIKE ?");
            pst.setString(1, "%" + keyword + "%");
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
            <span class="answer-title">Answer:</span> <%=answer == null ? "Pending" : answer%>
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
    }
%>

<a href="askQuestion.jsp">Ask a New Question</a>

</body>
</html>
