<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.air.*" import="java.util.*" import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
    <title>Unanswered Questions</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid black;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
<%@ page import ="java.sql.*" %>
    <form action="../custRepLogout.jsp" method="post">
        <input type="submit" value="Logout">
    </form>
    <form action="../custRepSuccess.jsp" method="post">
        <input type="submit" value="Back">
    </form>

<h2>Unanswered Questions</h2>
<table>
    <tr>
        <th>Question ID</th>
        <th>Customer</th>
        <th>Question</th>
        <th>Action</th>
    </tr>
<%
    

    try {
        Class.forName("com.mysql.jdbc.Driver");
        ApplicationDB db = new ApplicationDB();	
    	Connection con = db.getConnection();	
        Statement st = con.createStatement();
        String sql = "SELECT * FROM qna WHERE answer IS NULL";
        ResultSet rs = st.executeQuery(sql);

        while(rs.next()) {
            int qId = rs.getInt("q_id");
            String question = rs.getString("question");
            String customer = rs.getString("customer");
%>
    <tr>
        <td><%=qId%></td>
        <td><%=customer%></td>
        <td><%=question%></td>
        <td>
            <form action="answerQuestion.jsp" method="get">
                <input type="hidden" name="qId" value="<%=qId%>"/>
                <input type="submit" value="Answer this Question"/>
            </form>
        </td>
    </tr>
<%
        }
        rs.close();
        st.close();
        con.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
</table>
</body>
</html>
