<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="finalPj.logon.LogonDataBean"%>
<%@ page import="finalPj.logon.LogonDBBean"%>

<meta name="viewport" content="width=device-width,initial-scale=1.0" />
<link rel="stylesheet" href="../css/style.css" />
<script src="../js/jquery-1.11.0.min.js"></script>
<script src="modify.js"></script>

<%
	request.setCharacterEncoding("utf-8");
%>

<%
	String userId = (String) session.getAttribute("userId");
	String userPw = request.getParameter("userPw");

	LogonDBBean manager = LogonDBBean.getInstance();
	LogonDataBean m = manager.getMember(userId, userPw);

	try {//얻어낸 사용자 정보를 화면에 표시
%>
<div id="header">
	<div id="logo">
		<a href="main.jsp"><img src="img/logo3.jpg"></a>
	</div>
	<!-- <div id="top_menu">HOME | NOTICE | LOGIN | JOIN</div> -->
	<ul id="main_menu">
		<li>COMPANY</li>
		<li>ENDANGERED LIST</li>
		<li>SERVICE</li>
		<li><a href="https://www.wwfkorea.or.kr/support_wwf.php">SUPPORT</a></li>
	</ul>
</div>
<div id="regForm" class="box">
	<div class="status_align">
	<ul>
		<li><br><br><p class="center"><h2>회원 정보 수정</h2><br>
		<li> <input class="modify_input" id="userId"
			name="userId" type="text" size="22" maxlength="50"
			value="<%=userId%>" readonly disabled>
		<li> <input class="modify_input" id="userPw"
			name="userPw" type="password" size="20" placeholder="비밀번호를 입력하세요.(6~16자 숫자/문자)"
			maxlength="16">
		<li> <input class="modify_input" id="userName"
			name="userName" type="text" size="20" maxlength="10"
			value="<%=m.getUserName()%>">
		<li> <input class="modify_input" id="userEmail"
			name="userEmail" type="text" size="20" maxlength="20"
			value="<%=m.getUserEmail()%>">
		<li> <input class="modify_input" id="userTel"
			name="userTel" type="text" size="30" maxlength="50"
			value="<%=m.getUserTel()%>">
		<li class="label2"><button class="status_btn" id="modifyProcess">수정하기</button>
		<li>
			<button class="status_btn" id="cancle">취소하기</button>
	</ul>
	</div>
</div>

<%
	} catch (Exception e) {}
%>
