<%@ page import="java.sql.*, jakarta.servlet.http.Cookie" %>
<%
    // Get logged-in user's email from cookie
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
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Lost and Found Items</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
  <style>
    body {
      background-color: #f9fafb;
      font-family: 'Segoe UI', sans-serif;
    }
    .card {
      box-shadow: 0 2px 8px rgba(0,0,0,0.1);
      border-radius: 10px;
    }
    .card-title {
      font-weight: 600;
    }
    .card-text {
      color: #444;
    }
    .contact-btn {
      font-weight: 500;
    }
  </style>
</head>
<body>

  <div class="container my-5">
    <h2 class="fw-bold mb-4">Lost and Found Items</h2>
    <p class="text-muted mb-4">Browse through all reported lost and found items on campus.</p>

    <div class="row row-cols-1 row-cols-md-2 g-4">
    <%
      try {
          Class.forName("com.mysql.cj.jdbc.Driver");
          Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/lost_found", "root", "MO1325");

          String sql = "SELECT id, name, description, type, location, date, email FROM items";
          PreparedStatement stmt = conn.prepareStatement(sql);
          ResultSet rs = stmt.executeQuery();

          boolean hasData = false;
          while (rs.next()) {
              hasData = true;
    %>
        <div class="col">
          <div class="card h-100">
            <div class="card-body d-flex flex-column">
              <h5 class="card-title"><%= rs.getString("name") %></h5>
              <p class="card-text mb-1"><strong>Description:</strong> <%= rs.getString("description") %></p>
              <p class="card-text mb-1"><strong>Date:</strong> <%= rs.getDate("date") %></p>
              <p class="card-text mb-1"><strong>Location:</strong> <%= rs.getString("location") %></p>
              <p class="card-text mb-3"><strong>Status:</strong> <%= rs.getString("type") %></p>
              <a href="mailto:<%= rs.getString("email") %>" class="btn btn-primary mt-auto contact-btn">Contact Owner</a>
            </div>
          </div>
        </div>
    <%
          }
          if (!hasData) {
    %>
      <div class="col-12">
        <p class="text-center text-muted">No lost or found items reported yet.</p>
      </div>
    <%
          }

          rs.close();
          stmt.close();
          conn.close();
      } catch (Exception e) {
    %>
      <div class="col-12">
        <p class="text-danger">Error: <%= e.getMessage() %></p>
      </div>
    <%
      }
    %>
    </div>
  </div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
