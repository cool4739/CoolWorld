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
	<link type="text/css" href="/resources/css/CoolWorld.css?1" rel="stylesheet"><!-- css적용안될때 .css뒤에 ?뒤에 문자열을 아무거나 집어넣자 -->
	<style>
        #login_container {
        }
        #line::after {
        content: '';
        position: absolute;
        margin-left: 0.6%;
        margin-top: 0.1%;
        width: 1px;
        height: 20px;
        background-color: gray;
        }
	</style>
	<script>
        $.ajaxSetup({
            dataType : "text",
            contentType: 'application/json; charset=utf-8',
			success:function(result){
				//alert(result);
			},
			error: function (jqXHR) {
                //alert("jqXHR status code:"+jqXHR.status+" message:"+jqXHR.responseText);
            }
		});//ajaxSetup
		function checkValue() {
			if(!document.userInfo.user_id.value) {
				alert("아이디를 입력하세요.");
				return false;
			}
			if(!document.userInfo.user_pw.value) {
				alert("비밀번호를 입력하세요.");
				return false;
			}
		}
        $(document).ready(function(){
            $("#userInfo").submit(function(event) {
                if (checkValue() == false) {
                    return false;
                } else {
                    event.preventDefault(); //불필요한 페이지새로고침 방지
                    const data = {
                        id: $('#user_id').val(),
                        pw: $('#user_pw').val(),
                    };
                    $.ajax({
                        type: "POST",
                        url: "/user/login",
                        data:JSON.stringify(data)
                    }).done(function(){ // done - success 와 동일
                        location.href='메인화면';
                    }).fail(function (error) {
                        //alert(JSON.stringify(error));
                        alert('아이디 비밀번호 불일치');
                    });
                }
            });
        });
	</script>
</head>
<body>
	<h2 style="text-align: center; margin-top: 8%; font-family:BernhardFashion BT; font-weight: bold;;">CoolWorld</h2>

	<form name="userInfo" id="userInfo">

	<div class="container" id="login_container">
		<div class="col-auto">
			<label for="user_id" class="form-label"></label>
			<input type="text" class="form-control" id="user_id" name="user_id" placeholder="아이디">
		</div>
		<div class="col-auto">
			<label for="user_pw" class="form-label"></label>
			<input type="password" class="form-control" id="user_pw" name="user_pw" placeholder="비밀번호">
		</div>
		<div class="col-auto" style="margin-top:4%;">
			<button type="submit" class="btn btn-primary">
			로그인
			</button>
		</div>
		<div class="s1">
			<a href="아이디찾기" style="margin: 2%;" id="line">아이디 찾기</a>
			<a href="비밀번호찾기" style="margin: 2%;" id="line">비밀번호 찾기</a>
			<a href="register" style="margin: 2%;">회원가입</a>
		</div>
	</div>

	</form>

</body>
</html>