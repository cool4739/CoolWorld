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
	<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/@emailjs/browser@3/dist/email.min.js"></script>
    <script type="text/javascript">
        (function() {
            emailjs.init('uw3gM16Mu-RHxVo3B');
        })();
    </script>
    <script type="text/javascript">
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
    		if(!document.find.email.value) {
    			alert("이메일을 입력하세요.");
    			return false;
    		}
    	}
        $(document).ready(function(){
            $("#contact-form").submit(function(event) {
                if (checkValue() == false) {
                    return false;
                } else {
                    event.preventDefault(); //불필요한 페이지새로고침 방지
                    $.ajax({
                        type: "GET",
                        url: "/user/findIdPro/" + $('#email').val(),
                    }).done(function(result){ // done - success 와 동일
                        result = JSON.parse(result); //스프링에서 쏴주는 값을 json 형식으로 변경
                        document.getElementById("pw").value = result.pw;
                        emailjs.sendForm('service_cool4739', 'template_1kjr8ku', '#contact-form')
                            .then(function() {
                                console.log('SUCCESS!');
                                alert("이메일 발송!");
                            }, function(error) {
                                console.log('FAILED...', error);
                                alert("이메일 발송에 실패했습니다");
                            });
                    }).fail(function (error) {
                        //alert(JSON.stringify(error));
                        alert("등록되지 않은 이메일입니다.");
                    });
                }
            });
        });
    </script>
	<style>
	</style>
</head>
<body>
	<h2 style="text-align: center; margin-top: 8%; font-family:BernhardFashion BT; font-weight: bold;;">CoolWorld</h2>
	<div class="container" id="login_container">
		<h3 style="margin-top: 2%;">비밀번호 찾기</h3>
		<div style=" "><!--이메일전송-->
			<form id="contact-form" name="find">
			    <div class="col-auto">
    			    <label for="email" class="form-label"></label>
    			    <input type="email" name="email" class="form-control" id="email" placeholder="이메일">
    		    </div>
				<input type="hidden" name="pw" id="pw">
				<input class="generate" type="submit" value='이메일발송' style="margin-top: 5%;">
			</form>
		</div>
		<div class="s1">
			<a href="/" style="margin: 2%;" id="line">로그인</a>
			<a href="findId" style="margin: 2%;" id="line">아이디 찾기</a>
			<a href="register" style="margin: 2%;">회원가입</a>
		</div>
	</div>
</body>
</html>