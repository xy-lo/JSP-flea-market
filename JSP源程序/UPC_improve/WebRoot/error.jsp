<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html>
    <title>登录失败</title>  
  <body>
  <center>
  <br>
    <%  String flag = (String)session.getAttribute("flag");
        if(flag!=null && flag=="fail") out.println("用户名或密码错误");
        else if(flag!=null && flag=="success") response.sendRedirect("main.jsp");
        else  out.println("请您先登录");
     %>
   <br>
   <br>
   <a href="login.jsp" target="_self">返回登录页面</a>
  </body>
</html>
