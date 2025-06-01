<%@ page import="jakarta.servlet.http.Cookie" %>
<%
    // Clear the "user" cookie
    Cookie c = new Cookie("user", "");
    c.setMaxAge(0);         // Invalidate the cookie immediately
    c.setPath("/");         // Make sure the path matches how it was set
    response.addCookie(c);

    // Optionally: invalidate session (if used)
    session.invalidate();

    // Redirect to homepage
    response.sendRedirect("../../index.html");
%>

