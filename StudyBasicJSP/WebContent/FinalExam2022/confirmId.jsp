<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "finalPj.logon.LogonDBBean" %>

<% request.setCharacterEncoding("utf-8");%>

<% 
  String userId = request.getParameter("userId");
  
  LogonDBBean manager = LogonDBBean.getInstance();
  
  int check= manager.confirmId(userId);
  
  out.println(check);
 %>
