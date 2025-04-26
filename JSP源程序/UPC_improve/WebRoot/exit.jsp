<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<title>Insert title here</title>
<body>
      <%
        session.invalidate();
        response.sendRedirect("login.jsp");
        %>
</body>
</html>
