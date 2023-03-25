<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.UUID"%>
<%

String loginId = UUID.randomUUID().toString();
String loginNm = "guest";


session.setAttribute("loginId", loginId);
session.setAttribute("loginNm", loginNm);

response.sendRedirect("main.jsp");

%>
</body>
</html>