<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "finalPj.logon.LogonDBBean" %>

<%
	request.setCharacterEncoding("utf-8");
%>
<%-- 7~9라인: 수정된 정보를 가지고 데이터저장빈객체를 생성--%>
<jsp:useBean id="pj_member" class="finalPj.logon.LogonDataBean">
    <jsp:setProperty name="pj_member" property="*" />
</jsp:useBean>

<%  
  LogonDBBean manager = LogonDBBean.getInstance();
  int check = manager.updateMember(pj_member);
    
  out.println(check);
 %>