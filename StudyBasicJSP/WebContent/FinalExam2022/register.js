var status = true;

$(document).ready(function(){
	$("#checkId").click(function(){
	  if($("#userId").val()){
		var query = {userId:$("#userId").val()};
		
	    $.ajax({
	    	type:"post",//요청방식
	    	url:"confirmId.jsp",//요청페이지
	    	data:query,//파라미터
	    	success:function(data){//요청페이지 처리에 성공시
	    		if(data == 1){
	    			alert("사용할 수 없는 아이디");
	    	    	$("#userId").val("");
	    	     }else if(data == -1)
	    	  	    alert("사용할 수 있는 아이디");
	 	    }
	    });
	  }else{
		  alert("사용할 아이디를 입력");
		  $("#userId").focus();
	  }
	});
	
	$("#process").click(function(){
	   checkIt(); //입력폼에 입력한 상황 체크
	   
	   if(status){
		  var query = {userId:$("#userId").val(), 
				  userPw:$("#userPw").val(),
				  userName:$("#userName").val(),				  			     
			      userEmail:$("#userEmail").val(),
			      userTel:$("#userTel").val()};
		  
		  $.ajax({
		      type:"post",
		      url:"registerPro.jsp",
		      async:false,
		      data:query,
		      success:function(data){
		    	  alert("회원가입 성공!");	
		    	  window.location.assign("main.jsp");
		 	  }
		  });
	   }
	});
	
	$("#cancle").click(function(){
		window.location.assign("main.jsp");
	});

 });

function checkIt() {
	status = true;
	
    if(!$("#userId").val()) {//카드번호를 입력하지 않으면 수행
        alert("아이디를 입력하세요");
        $("#userId").focus();
        status = false;
        return false;//사용자가 서비스를 요청한 시점으로 돌아감
    }
    
    if(!$("#userPw").val()) {//비밀번호를 입력하지 않으면 수행
        alert("비밀번호를 입력하세요");
        $("#userPw").focus();
        status = false;
        return false;
    }
    //비밀번호와 재입력비밀번호가 같지않으면 수행
    if($("#userPw").val() != $("#repass").val()){
        alert("비밀번호를 동일하게 입력하세요");
        $("#repass").focus();
        status = false;
        return false;
    }
    
    if(!$("#userName").val()) {//사용자 이름을 입력하지 않으면 수행
        alert("사용자 이름을 입력하세요");
        $("#userName").focus();
        status = false;
        return false;
    }
    
    if(!$("#userEmail").val()) {
        alert("이메일을 입력하세요");
        $("#userEmail").focus();
        status = false;
        return false;
    }
    
    if(!$("#userTel").val()) {
        alert("전화번호를 입력하세요");
        $("#userTel").focus();
        status = false;
        return false;
    }  
}