
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Student Records</title>
</head>
<body>
    <h2>Student Records</h2>

    <table border="1" cellpadding="10">
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Marks</th>
        </tr>

        <%
            String url = "jdbc:mysql://localhost:3306/jspdb";
            String user = System.getenv("DB_USER");
            String password = System.getenv("DB_PASSWORD");

            if (user == null || password == null) {
                out.println("<tr><td colspan='3'>Configure database credentials in Tomcat.</td></tr>");
            } else {
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");

                    try (Connection con = DriverManager.getConnection(url, user, password);
                         Statement st = con.createStatement();
                         ResultSet rs = st.executeQuery("SELECT id, name, marks FROM students")) {

                        while (rs.next()) {
                            out.println("<tr>");
                            out.println("<td>" + rs.getInt("id") + "</td>");
                            out.println("<td>" + rs.getString("name") + "</td>");
                            out.println("<td>" + rs.getInt("marks") + "</td>");
                            out.println("</tr>");
                        }
                    }
                } catch (Exception e) {
                    application.log("Database retrieval failed", e);
                    out.println("<tr><td colspan='3'>Database error. Check the Tomcat log.</td></tr>");
                }
            }
        %>
    </table>

    <p><a href="index.jsp">Back to Home</a></p>
</body>
</html>