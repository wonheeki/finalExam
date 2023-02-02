<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<meta name="viewport" content="width=device-width,initial-scale=1.0"/>
<link rel="stylesheet" href="../css/style.css"/>
<script src="../js/jquery-1.11.0.min.js"></script>
<script src="modify.js"></script>

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

<div id="status" class="status_align">
     <ul>
     	<li><br><br><h2>비밀번호 확인</h2><br/>
        <li>
            <input class="modify_input" id="userPw" name="userPw" type="password" 
              size="20" placeholder="비밀번호를 입력하세요(6~16자 숫자/문자)" maxlength="16"><br/>
        <li class="label2">
            <button class="status_btn" id="modify">회원수정</button>
        <li>
            <button class="status_btn" id="delete">회원탈퇴</button>
     </ul>
</div>
