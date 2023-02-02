var status = true;

$(document).ready(function(){
	$("#modify").click(function(){//[회원정보수정]버튼 클릭
		var query = {userPw:$("#userPw").val()};
		
		$.ajax({
			type: "post",
			url: "memberCheck.jsp",
			data: query,
			success: function(data){
				if(data == 1)//비밀번호가 맞음
					location.href="modifyForm.jsp?userPw="+$("#userPw").val()
		    	 else {//비밀번호 틀림
		    	  	 alert("비밀번호가 맞지 않습니다.");
		    	  	 $("#userPw").val("");
		    	  	 $("#userPw").focus();
		    	 }   
		   }
		});
	});
	
	$("#modifyProcess").click(function(){
		var query = {userId:$("#userId").val(), 
				  userPw:$("#userPw").val(),
			      userName:$("#userName").val(),
			      userEmail:$("#userEmail").val(),
			      userTel:$("#userTel").val()};
		
		$.ajax({
			type: "post",
			url: "modifyPro.jsp",
			data: query,
			success: function(data){
				if(data == 1) {//정보수정 성공
				  alert("회원정보가 수정되었습니다.");
				  window.location.replace("main.jsp");
				}
		   }
		});
	});
	
	$("#cancle").click(function(){
		window.location.replace("main.jsp");
	});
	
	$("#delete").click(function(){//[회원정보수정]버튼 클릭
		var query = {userPw:$("#userPw").val()};
		
		$.ajax({
			type: "post",
			url: "memberCheck.jsp",
			data: query,
			success: function(data){
				if(data == 1){//비밀번호 맞음
					//회원탈퇴 페이지 deletePro.jsp 실행
					$.ajax({
						   type: "POST",
						   url: "deletePro.jsp",
						   data: query,
						   success: function(data){
							   if(data == 1){//탈퇴 성공
								  alert("회원 탈퇴가 되었습니다.");
								  $("#main_auth").load("loginForm.jsp");
						       }   
						   }
						});
				}else {//비밀번호 틀림
		    	  	 alert("비밀번호가 맞지 않습니다.");
		    	  	 $("#userPw").val("");
		    	  	 $("#userPw").focus();
		    	 }   
		   }
		});
	});	
	
 });