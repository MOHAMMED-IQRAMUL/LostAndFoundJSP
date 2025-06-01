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

    boolean isValidUser = false;
    String name = "";

    if (email != null) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/lost_found", "root", "MO1325");
            String sql = "SELECT name FROM users WHERE email = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                isValidUser = true;
                name = rs.getString("name");
            }
            rs.close();
            stmt.close();
            conn.close();
        } catch (Exception e) {
            out.println("Database error: " + e.getMessage());
        }
    }

    if (!isValidUser) {
%>
<script>
    alert("Please log in to access your account.");
    window.location.href = "../index.html";
</script>
<%
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Report Lost Item</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
  <style>
    body {
      font-family: 'Segoe UI', sans-serif;
      background: linear-gradient(to right, #f2f7ff, #fff3ec);
      min-height: 100vh;
    }

    .container {
      background-color: #ffffff;
      padding: 2rem;
      border-radius: 12px;
      margin-top: 4rem;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.05);
    }

    .form-control,
    .form-select {
      background-color: #f1f2f4;
      border: none;
      padding: 12px;
      border-radius: 10px;
    }

    textarea.form-control {
      height: 150px;
    }

    .form-label {
      font-weight: 600;
    }

    .submit-btn {
      background-color: #4882ff;
      color: white;
      font-weight: 500;
      padding: 10px 30px;
      border-radius: 30px;
      transition: background-color 0.3s ease;
    }

    .submit-btn:hover {
      background-color: #7faeff;
    }
  </style>
</head>
<body>

<div class="container" style="max-width: 700px;">
  <h3 class="fw-bold mb-4">Report Lost Item</h3>

  <form action="../../utils/itemInsert.jsp" method="post">
    <input type="hidden" name="email" value="<%=email %>" />

    <div class="mb-3">
      <label for="itemName" class="form-label">Item Name</label>
      <input type="text" name="name" class="form-control" id="itemName" placeholder="e.g., Backpack, Phone" required>
    </div>

    <div class="mb-3">
      <label for="itemDescription" class="form-label">Description</label>
      <textarea name="description" class="form-control" id="itemDescription" placeholder="Describe the item in detail" required></textarea>
    </div>

    <div class="mb-3">
      <label for="itemLocation" class="form-label">Location</label>
      <select name="location" class="form-select" id="itemLocation" required>
        <option selected disabled>Select Location</option>
        <option>Library</option>
        <option>Hostel</option>
        <option>Cafeteria</option>
        <option>Auditorium</option>
      </select>
    </div>

    <div class="mb-3">
      <label for="type" class="form-label">Lost/Found</label>
      <select name="type" class="form-select" id="type" required>
        <option selected disabled>Select Status</option>
        <option>Lost</option>
        <option>Found</option>
      </select>
    </div>

    <div class="mb-3">
      <label for="lostDate" class="form-label">Date</label>
      <input type="date" name="date" class="form-control" id="lostDate" required>
    </div>

    <button type="submit" class="btn submit-btn">Submit</button>
  </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
