<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<meta name="viewport" content="width=device-width,initial-scale=1.0" />
<link rel="stylesheet" href="../css/style.css" />
<script src="../js/jquery-1.11.0.min.js"></script>

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
<div id="content">
	<div class="polarbear">
		<img src="img/polarbear1.jpg" class="polarbear_img">
	</div>
</div>
<div id="main_auth" class="box"><jsp:include page="loginForm.jsp" /></div>
<div id="footer">
	<br><br>
	<img id="footer_logo" src="img/logo.jpg"><br>
	<br>Copyright 2019. WONHEE KI. All rights reserved.<br><br><br>
</div>

