<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<meta name="viewport" content="width=device-width,initial-scale=1.0" />
<link rel="stylesheet" href="../css/style.css" />
<script src="../js/jquery-1.11.0.min.js"></script>
<script src="login.js"></script>
<script type="text/javascript" src="../js/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="../js/snowfall.jquery.js"></script>
<script type='text/javascript'>     
    $(document).ready(function(){
        $(document).snowfall({
            minSize: 5,
            maxSize:10,
            round : true
         })
    });
 </script>
<%
	String userId = "";
	try {
		userId = (String) session.getAttribute("userId");
%>

<%
	if (userId == null || userId.equals("")) { //인증되지 않은 사용자 영역
%>
<div id="status">

	<table id="status_tbl">
		<tr>
			<td><input class="login_input" id="userId" name="userId" type="text" size="22"
				maxlength="50" placeholder="아이디를 입력하세요."></td>
		</tr>
		<tr>
			<td><input class="login_input" id="userPw" name="userPw" type="password" size="22"
				placeholder="비밀번호를 입력하세요.(6~16자 숫자/문자)" maxlength="50"></td>
		</tr>
		<tr>
			<td align="center"><button id="login" class="status_btn">로그인</button></td>

		</tr>
		<tr>
			<td align="center"><button id="register" class="status_btn">회원가입</button></td>
		</tr>
	</table>
</div>
<%
	} else {//인증된 사용자 영역
%>

<div id="top_menu" align="right">
	&nbsp;<b><%=userId%></b>님 환영합니다 <button id="logout" class="menu_btn">LOGOUT</button><button id="update" class="menu_btn">EDIT PROFILE</button>
</div>
<%-- 	<ul>
		<li class="login_li">&nbsp;<b><%=userId%></b>님 환영합니다.
		<li class="login_li"><button id="logout" class="menu_btn">로그아웃</button>
		<li class="login_li">|
		<li class="login_li"><button id="update" class="menu_btn">회원 정보 수정</button>
	</ul> --%>
<%--  	<table style="table-layout:fixed">
		<tr>
			<td>&nbsp;<b><%=userId%></b>님 환영합니다.</td>
			<td><button id="logout" class="menu_btn">로그아웃</button></td>
			<td><button id="update" class="menu_btn">회원 정보 수정</button></td>
		</tr>
	</table> --%>
	<%-- <div id="login_user">&nbsp;<b><%=userId%></b>님 환영합니다.</div>
	<div id="login_btn"><button id="logout" class="menu_btn">로그아웃</button>
	&nbsp;&nbsp;|&nbsp;&nbsp;
	<button id="update" class="menu_btn">회원 정보 수정</button></div> --%>
<%
	}
	} catch (Exception e) {
		e.printStackTrace();
	}
%>
