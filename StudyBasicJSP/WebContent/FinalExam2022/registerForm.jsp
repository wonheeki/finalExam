<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<meta name="viewport" content="width=device-width,initial-scale=1.0" />
<link rel="stylesheet" href="../css/style.css" />
<script src="../js/jquery-1.11.0.min.js"></script>
<script src="register.js"></script>


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
		<li><br><br><h2>회원가입</h2><br>
		<li><input id="userId" class="modify_input"
			name="userId" type="text" size="20" maxlength="50"
			placeholder="아이디를 입력하세요" autofocus><button id="checkId">아이디 중복확인</button>
		<li><input id="userPw" class="modify_input"
			name="userPw" type="password" size="20" placeholder="비밀번호를 입력하세요(6~16자 숫자/문자)"
			maxlength="16">
		<li><input id="repass" class="modify_input" name="repass" type="password" size="20" placeholder="비밀번호 재입력"
			maxlength="16">
		<li><input id="userName" class="modify_input"
			name="userName" type="text" size="20" placeholder="이름을 입력하세요"
			maxlength="10">
		<li><input id="userEmail" class="modify_input"
			name="userEmail" type="text" size="20" placeholder="이메일을 입력하세요"
			maxlength="50">
		<li><input id="userTel" class="modify_input"
			name="userTel" type="text" size="20" placeholder="전화번호를 입력하세요" maxlength="20">
		<li>
		<li><button class="status_btn" id="process">회원가입</button>
		<li><button class="status_btn" id="cancle">취소하기</button>
	</ul>
</div>

</div>