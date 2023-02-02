var status = true;

$(document).ready(function(){
	
	
	$("#register").click(function(){//[회원가입]버튼 클릭
		location.href="registerForm.jsp"
	});
	
	$("#login").click(function(){
		checkIt();//입력폼에 입력한 상황 체크
		if(status){
		  var query = {userId : $("#userId").val(), 
				       userPw:$("#userPw").val()};
		  
		  $.ajax({
		     type: "POST",
		     url: "loginPro.jsp",
		     data: query,
		     success: function(data){
		    	 if(data == 1)//로그인 성공
		    		 $("#main_auth").load("loginForm.jsp");	
		    	 else if(data == 0){//비밀번호 틀림
		    	  	 alert("비밀번호가 맞지 않습니다.");
		    	  	 $("#userPw").val("");
		    	  	 $("#userPw").focus();
		    	 }else if(data == -1){//아이디 틀림
		    		 alert("아이디가 맞지 않습니다.");
		    		 $("#userId").val("");
		    		 $("#userPw").val("");
		    	  	 $("#userId").focus();
		    	 }
		     }
		  });
		}
	});
	
	$("#update").click(function(){//[회원정보수정]버튼 클릭
		location.href="modify.jsp"
	});
	
	$("#logout").click(function(){//[회원정보수정]버튼 클릭
		alert("로그아웃 성공!");		  
		$.ajax({
		   type: "POST",
		   url: "logout.jsp",
		   success: function(data){			   
			   window.location.replace("main.jsp");
		   }	   	  
		});
	});

 });

function checkIt(){
	status = true;
	if(!$.trim($("#userId").val())){
		alert("아이디를 입력하세요.");
		$("#userId").focus();
		status = false;
		return false;
	}
	
	if(!$.trim($("#userPw").val())){
		alert("비밀번호를 입력하세요.");
		$("#userPw").focus();
		status = false;
		return false;
	}
}