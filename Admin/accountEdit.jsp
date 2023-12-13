<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.air.*" import="java.util.*" import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
    <title>Account Management</title>
</head>
<body>

<%@ page import ="java.sql.*" %>
    <form action="adminLogout.jsp" method="post">
        <input type="submit" value="Logout">
    </form>
    <form action="adminSuccess.jsp" method="post">
        <input type="submit" value="Back">
    </form>
    

    <h2>Add Account</h2>
    <form method="post">
        <label>Account Type:</label>
        <select name="accountType">
            <option value="admin">Admin</option>
            <option value="customer">Customer</option>
            <option value="custrep">Customer Representative</option>
        </select><br/>
        <label>Username:</label>
        <input type="text" name="username" required /><br/>
        <label>Password:</label>
        <input type="password" name="password" required /><br/>
        <input type="submit" name="action" value="Add Account" />
    </form>

    <h2>Delete Account</h2>
    <form method="post">
        <label>Account Type:</label>
        <select name="accountType">
            <option value="admin">Admin</option>
            <option value="customer">Customer</option>
            <option value="custrep">Customer Representative</option>
        </select><br/>
        <label>Username:</label>
        <input type="text" name="username" required /><br/>
        <input type="submit" name="action" value="Delete Account" />
    </form>
    <h2>Change Password</h2>
    <form method="post">
        <label>Account Type:</label>
        <select name="accountTypeChange">
            <option value="admin">Admin</option>
            <option value="customer">Customer</option>
            <option value="custrep">Customer Representative</option>
        </select><br/>
        <label>Username:</label>
        <input type="text" name="usernameChange" required /><br/>
        <label>New Password:</label>
        <input type="password" name="newPassword" required /><br/>
        <input type="submit" name="action" value="Change Password" />
    </form>
    
    

    <%
        String action = request.getParameter("action");
        if (action != null) {
            String accountType = request.getParameter("accountType");
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String accountTypeChange = request.getParameter("accountTypeChange");
            String usernameChange = request.getParameter("usernameChange");
            String newPassword = request.getParameter("newPassword");


            try {
            	ApplicationDB db = new ApplicationDB();	
                Connection conn = db.getConnection();
                PreparedStatement ps = null;
                if ("Add Account".equals(action)) {
                    String sql = "INSERT INTO " + accountType + " (username, password) VALUES (?, ?)";
                    ps = conn.prepareStatement(sql);
                    ps.setString(1, username);
                    ps.setString(2, password);
                    ps.executeUpdate();
                    out.println("<p>Account added successfully.</p>");
                } else if ("Delete Account".equals(action)) {
                    String sql = "DELETE FROM " + accountType + " WHERE username = ?";
                    ps = conn.prepareStatement(sql);
                    ps.setString(1, username);
                    ps.executeUpdate();
                    out.println("<p>Account deleted successfully.</p>");
                }else if ("Change Password".equals(action) && !"admin".equals(accountTypeChange)) {
                    String sql = "UPDATE " + accountTypeChange + " SET password = ? WHERE username = ?";
                    ps = conn.prepareStatement(sql);
                    ps.setString(1, newPassword);
                    ps.setString(2, usernameChange);
                    ps.executeUpdate();
                    out.println("<p>Password changed successfully.</p>");
                }
                ps.close();
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<p>Error occurred: " + e.getMessage() + "</p>");
            }
        }
    %>
</body>
</html>
