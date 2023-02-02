<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "finalPj.logon.LogonDBBean" %>

<% request.setCharacterEncoding("utf-8");%>

<%
  String userId = request.getParameter("userId");
  String userPw  = request.getParameter("userPw");

  LogonDBBean manager = LogonDBBean.getInstance();
  int check= manager.userCheck(userId,userPw);//사용자인증처리 메소드

  if(check==1)//사용자인증에 성공시 세션속성을 설정
	session.setAttribute("userId",userId);

  out.println(check);//처리결과를 반환
%>