<%@ page import="java.sql.*, jakarta.servlet.http.Cookie" %>

<%
    // Get user from cookie
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
<html>

<head>
    <meta charset="UTF-8">
    <title>Welcome <%= name %></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', sans-serif;
            height: 100vh;
            display: flex;
            background: linear-gradient(135deg, #ECFAE5, #FFECD9, #FFF9EC);
            background-size: 400% 400%;
            animation: gradientMove 20s ease infinite;
        }

        @keyframes gradientMove {
            0% {
                background-position: 0% 50%;
            }

            50% {
                background-position: 100% 50%;
            }

            100% {
                background-position: 0% 50%;
            }
        }

        .sidebar {
            width: 250px;
            background-color: rgba(255, 255, 255, 0.9);
            padding-top: 1.5rem;
            border-right: 1px solid #dee2e6;
            box-shadow: 2px 0 8px rgba(0, 0, 0, 0.05);
            display: flex;
            flex-direction: column;
        }

        .sidebar h5 {
            font-weight: 700;
            color: #D5451B;
        }

        .sidebar a,
        .sidebar button {
            display: flex;
            align-items: center;
            padding: 0.75rem 1.25rem;
            color: #000;
            text-decoration: none;
            font-weight: 500;
            border: none;
            background: transparent;
            width: 100%;
        }

        .sidebar a:hover,
        .sidebar a.active,
        .sidebar button:hover {
            background-color: #f5f5f5;
            border-radius: 10px;
            transition: all 0.3s ease;
        }

        .main-content {
            flex: 1;
            padding: 2rem;
            overflow: auto;
        }

        h2 {
            color: #521C0D;
            font-weight: 600;
        }

        iframe {
            width: 100%;
            height: 85vh;
            border: none;
            margin-top: 20px;
            border-radius: 12px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.05);
        }

        .items-1 {
            gap: 8px;
            font-size: 1rem;
        }

        .mt-auto {
            margin-top: auto;
        }

        button:focus {
            outline: none;
        }
    </style>
</head>

<body>

    <div class="sidebar">
        <h5 class="text-center mb-4">Lost & Found</h5>
        <a href="pages/dashboard.jsp" class="items-1" target="mainFrame"><i class="bi bi-house"></i> Dashboard</a>
        <a href="pages/mylisting.jsp" class="items-1" target="mainFrame"><i class="bi bi-list-ul"></i> My Listings</a>
        <a href="pages/report.jsp" class="items-1" target="mainFrame"><i class="bi bi-plus-square"></i> Add Listing</a>
        <a href="pages/allitems.jsp" class="items-1" target="mainFrame"><i class="bi bi-wallet-fill"></i> View All</a>

        <div class="mt-auto p-3">
            <button onclick="confirmLogout()" class="items-1"><i class="bi bi-box-arrow-left"></i> Logout</button>
            <a href="pages/settings.jsp" class="items-1" target="mainFrame"><i class="bi bi-gear"></i> Settings</a>
        </div>
    </div>

    <div class="main-content">
        <h2>Welcome, <%= name %>!</h2>
        <p>Your email: <%= email %></p>
        <iframe name="mainFrame" src="pages/dashboard.jsp"></iframe>
    </div>

    <script>
        function confirmLogout() {
            if (confirm("Are you sure you want to logout?")) {
                window.location.href = "pages/logout.jsp";
            }
        }
    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>

</html>
