<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "finalPj.logon.LogonDBBean" %>
<%@ page import = "java.sql.Timestamp" %>

<meta name="viewport" content="width=device-width,initial-scale=1.0"/>
<link rel="stylesheet" href="../css/style.css"/>
<script src="../js/jquery-1.11.0.min.js"></script>

<%
	request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="pj_member" class="finalPj.logon.LogonDataBean">
    <jsp:setProperty name="pj_member" property="*" />
</jsp:useBean>

<%  
  pj_member.setReg_date(new Timestamp(System.currentTimeMillis()));

  LogonDBBean manager = LogonDBBean.getInstance();
  manager.insertMember(pj_member);
%>