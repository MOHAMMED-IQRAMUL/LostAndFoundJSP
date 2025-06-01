<%@ page import="java.sql.*, jakarta.servlet.http.Cookie" %>
<%
    // 1. Get form data from request
    String name = request.getParameter("name");
    String description = request.getParameter("description");
    String location = request.getParameter("location");
    String date = request.getParameter("date");
    String type = request.getParameter("type");
    String email = request.getParameter("email");

    if (email == null || email.trim().isEmpty()) {
%>
    <script>
        alert("Session expired. Please log in again.");
        window.location.href = "/index.html";
    </script>
<%
        return;
    }

    // Insert data into the database
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/lost_found", "root", "MO1325");

        String sql = "INSERT INTO items (email, name, description, type, location, date) VALUES (?, ?, ?, ?, ?, ?)";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, email);
        stmt.setString(2, name);
        stmt.setString(3, description);
        stmt.setString(4, type);  // default type
        stmt.setString(5, location);
        stmt.setString(6, date);    // must be in 'yyyy-mm-dd' format

        int result = stmt.executeUpdate();

        stmt.close();
        conn.close();

        if (result > 0) {
%>
    <script>
        alert("Item reported successfully!");
        window.location.href = "../pages/pages/dashboard.jsp";
    </script>
<%
        } else {
%>
    <script>
        alert("Failed to submit the report. Please try again.");
        window.history.back();
    </script>
<%
        }

    } catch (Exception e) {
        out.println("<p>Error: " + e.getMessage() + "</p>");
    }
%>
