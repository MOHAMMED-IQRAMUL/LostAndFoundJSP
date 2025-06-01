<%@ page import="java.sql.*, jakarta.servlet.http.Cookie" %>
<%
    String email = null;
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if ("user".equals(cookie.getName())) {
                email = cookie.getValue();
                break;
            }
        }
    }

    if (email == null) {
%>
    <script>
        alert("Please log in first.");
        window.location.href = "/index.html";
    </script>
<%
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>My Listings</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
  <style>
    body {
      margin: 0;
      font-family: 'Segoe UI', sans-serif;
      background: linear-gradient(to right, #E8F0FF, #FFF7E6);
      min-height: 100vh;
    }

    .container {
      background-color: white;
      padding: 2rem;
      margin-top: 3rem;
      border-radius: 12px;
      box-shadow: 0 0 15px rgba(0, 0, 0, 0.08);
    }

    h2 {
      font-weight: 700;
      color: #343a40;
    }

    .form-control {
      border-radius: 25px;
      padding-left: 20px;
    }

    .table {
      margin-top: 1rem;
      border-radius: 12px;
      overflow: hidden;
    }

    .table th {
      background-color: #f8f9fa;
      color: #495057;
    }

    .table td, .table th {
      vertical-align: middle;
      text-align: center;
    }

    .badge-status {
      background-color: #f3f4f6;
      color: #111827;
      padding: 6px 16px;
      border-radius: 9999px;
      font-weight: 500;
    }

    .btn-details {
      color: #3b82f6;
      text-decoration: none;
      font-weight: 500;
    }

    .sss {
      text-align: center;
      font-weight: 500;
      color: #6c757d;
    }
  </style>
</head>
<body>

  <div class="container">
    <h2>My Active Listings</h2>

    <div class="input-group mb-4 mt-3">
      <input type="text" class="form-control" placeholder="Search for items..." />
    </div>

    <table class="table table-hover border">
      <thead class="table-light">
        <tr>
          <th>ID</th>
          <th>Name</th>
          <th>Description</th>
          <th>Date</th>
          <th>Location</th>
          <th>Status</th>
          <th>Contact</th>
        </tr>
      </thead>
      <tbody>
<%
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/lost_found", "root", "MO1325");

        String sql = "SELECT id, name, description, type, location, date, email FROM items WHERE email = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, email);
        ResultSet rs = stmt.executeQuery();

        boolean hasData = false;
        while (rs.next()) {
            hasData = true;
%>
        <tr>
          <td><%= rs.getInt("id") %></td>
          <td><%= rs.getString("name") %></td>
          <td><%= rs.getString("description") %></td>
          <td><%= rs.getDate("date") %></td>
          <td><%= rs.getString("location") %></td>
          <td>
            <span class="badge-status"><%= rs.getString("type") %></span>
          </td>
          <td><a href="mailto:<%= rs.getString("email") %>" class="btn-details">Email</a></td>
        </tr>
<%
        }
        if (!hasData) {
%>
        <tr>
          <td colspan="7" class="sss">No data found.</td>
        </tr>
<%
        }

        rs.close();
        stmt.close();
        conn.close();
    } catch (Exception e) {
        out.println("<tr><td colspan='7'>Error: " + e.getMessage() + "</td></tr>");
    }
%>
      </tbody>
    </table>
  </div>

</body>
</html>
