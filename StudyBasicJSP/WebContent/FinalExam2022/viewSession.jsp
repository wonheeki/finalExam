<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.*" %> <!-- Enumeration 객체 사용 -->
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<%
   Enumeration  <String> attr = session.getAttributeNames();
   while(attr.hasMoreElements()) // hasMoreElements(): 다음 엘리먼트가 있으면 true
   {
	   String  attrName = attr.nextElement(); // 엘리먼트를 하나씩 추출 
	   String  attrValue = (String) session.getAttribute(attrName);
	   out.println("<hr>");
	   out.println("<h2>");
	   out.println("세션의 속성 명은 " + attrName + "이고" );
	   out.println("세션의 속성 값은 " + attrValue + "이다.<br>" );	
	   out.println("</h2>");
   }
%>