<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "finalPj.logon.LogonDBBean" %>

<% request.setCharacterEncoding("utf-8");%>

<%
  String userId = (String)session.getAttribute("userId");
  String userPw  = request.getParameter("userPw");
	
  LogonDBBean manager = LogonDBBean.getInstance();
  int check = manager.deleteMember(userId,userPw);
	
  if(check == 1)
	 session.invalidate();
  
  out.println(check);
%>