<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta http-equiv="X-UA-Compatible" content="ie=edge">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<link type="text/css" href="/resources/css/CoolWorld.css?2" rel="stylesheet"><!-- css적용안될때 .css뒤에 ?뒤에 문자열을 아무거나 집어넣자 -->
	<style>
	</style>
	<script>
        $.ajaxSetup({
            dataType : "json",
            contentType: 'application/json; charset=utf-8',
			success:function(result){
				if(result == 0) {
				    alert("이미 사용중인 아이디입니다.");
				} else if(result == 1) {
				    alert("이미 사용중인 이메일입니다.");
				} else if(result == 2) {
				    alert("회원가입이 완료되었습니다!");
				    location.href='/';
				} else {
				    alert("반환값오류");
				}
			},
			error: function (jqXHR) {
                //alert("jqXHR status code:"+jqXHR.status+" message:"+jqXHR.responseText);
            }
		});//ajaxSetup
	    function checkValue() {
	    const userInfo = document.getElementById('userInfo');
		    if(!userInfo.querySelector('#user_id').value) {
			    alert("아이디를 입력하세요.");
			    return false;
		    }
		    if(!userInfo.querySelector('#user_pw').value) {
			    alert("비밀번호를 입력하세요.");
			    return false;
		    }
		    if(!userInfo.querySelector('#user_name').value) {
			    alert("이름을 입력하세요.");
			    return false;
		    }
		    if(!userInfo.querySelector('#user_nick').value) {
			    alert("닉네임을 입력하세요.");
			    return false;
		    }
		    if(!userInfo.querySelector('#user_email').value) {
			    alert("이메일을 입력하세요.");
			    return false;
		    }
		    if(userInfo.querySelector('#user_pw').value != userInfo.querySelector('#user_pwcheck').value) {
			    alert("비밀번호를 동일하게 입력하세요.");
			    return false;
		    }
	    }
        $(document).ready(function(){
            $("#userInfo").submit(function(event) {
                if (checkValue() == false) {
                    return false;
                } else {
                    event.preventDefault();
                    const data = {
                        id: $('#user_id').val(),
                        pw: $('#user_pw').val(),
                        name: $('#user_name').val(),
                        nickname: $('#user_nick').val(),
                        email: $('#user_email').val(),
                     };
                     $.ajax({
                        type: "POST",
                        url: "/user/create",
                        data:JSON.stringify(data)
                     }).done(function(){ // done - success 와 동일
                        //alert('회원가입이 완료되었습니다!');
                     }).fail(function (error) {
                        alert(JSON.stringify(error));
                     });
                }
            });
        });
	</script>
</head>
<body>
	<h2 style="text-align: center; margin-top: 8%; font-family:BernhardFashion BT; font-weight: bold;;">CoolWorld</h2>
	<div class="container" id="login_container">
		<h3 style="margin-top: 2%;">회원가입</h3>
		<form name="userInfo" id="userInfo">
		    <div class="col-auto">
			    <label for="user_id" class="form-label"></label>
			    <input type="text" name="user_id" class="form-control" id="user_id" placeholder="아이디">
		    </div>
		    <div class="col-auto">
			    <label for="user_pw" class="form-label"></label>
			    <input type="password" name="user_pw" class="form-control" id="user_pw" placeholder="비밀번호">
		    </div>
		    <div class="col-auto">
			    <label for="user_pwcheck" class="form-label"></label>
			    <input type="password" name="user_pwcheck" class="form-control" id="user_pwcheck" placeholder="비밀번호 확인">
		    </div>
		    <div class="col-auto">
			    <label for="user_name" class="form-label"></label>
			    <input type="text" name="user_name" class="form-control" id="user_name" placeholder="이름">
		    </div>
		    <div class="col-auto">
			    <label for="user_nick" class="form-label"></label>
			    <input type="text" name="user_nick" class="form-control" id="user_nick" placeholder="닉네임">
		    </div>
		    <div class="col-auto">
			    <label for="user_email" class="form-label"></label>
			    <input type="email" name="user_email" class="form-control" id="user_email" placeholder="이메일">
		    </div>
		    <div class="col-auto" style="margin-top:4%;">
			    <button type="submit" class="btn btn-primary">완료</button>
		    </div>
		</form>
		<div class="s1">
			<a href="findId" style="margin: 2%;" id="line">아이디 찾기</a>
			<a href="findPw" style="margin: 2%;" id="line">비밀번호 찾기</a>
			<a href="/" style="margin: 2%;">로그인</a>
		</div>
	</div>
</body>
</html>