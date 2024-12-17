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
        window.onload = function() {
            document.getElementById('contact-form').addEventListener('submit', function(event) {
                event.preventDefault();
                this.contact_number.value = Math.random() * 100000 | 0;
                emailjs.sendForm('service_cool4739', 'template_vmztnqn', this)
                    .then(function() {
                        console.log('SUCCESS!');
                        alert("이메일 발송!");
                    }, function(error) {
                        console.log('FAILED...', error);
                    });
            });
        }
        function checkValue() {
    		if(!document.find.user_email.value) {
    			alert("이메일을 입력하세요.");
    			return false;
    		}
    	}

    </script>
	<style>
	</style>
</head>
<body>
	<h2 style="text-align: center; margin-top: 8%; font-family:BernhardFashion BT; font-weight: bold;;">CoolWorld</h2>
	<div class="container" id="login_container">
		<h3 style="margin-top: 2%;">아이디 찾기</h3>
		<div style=" "><!--이메일전송-->
			<form method="post" id="contact-form" name="find" onsubmit="return checkValue();">
				<input type="hidden" name="contact_number"><!--이메일전송에 반드시 필요함-->
			    <div class="col-auto">
    			    <label for="user_email" class="form-label"></label>
    			    <input type="email" name="email" class="form-control" id="user_email" placeholder="이메일">
    		    </div>
				<input class="eNum" type="hidden" name="email_num" id="1" value="">
				<input class="generate" type="submit" value='인증번호발송' style="margin-top: 5%;">
			</form>
		</div>
		<div style=""><!--인증번호입력-->
			<form id="confirm">
			    <div class="col-auto">
    			    <label for="user_id" class="form-label"></label>
    			    <input type="text" name="form_user" class="form-control" id="2" placeholder="인증번호">
    		    </div>
				<input type="button" value='인증번호확인' style="margin: 5%;" onclick="checkNum()">
			</form>
		</div>
		<div class="s1">
			<a href="/" style="margin: 2%;" id="line">로그인</a>
			<a href="findPw" style="margin: 2%;" id="line">비밀번호 찾기</a>
			<a href="register" style="margin: 2%;">회원가입</a>
		</div>
		<script>
			const form1 = document.querySelector('form[id="contact-form"]');
			const email = form1.querySelector('input[class="eNum"]');
            const button1 = form1.querySelector('.generate');

            function generator(){
				let str = ''
				for (let i = 0; i < 6; i++) {
					str += Math.floor(Math.random() * 10);
				}
                //Math.random 0~1 사이의 난수 생성
                //Math.floor 소수점을 내림시켜 정수로 만듦
                email.value = str;
                //if (document.getElementById("1").value 값이 db에 있다면) {		db연동되어있을시에 시도해보기
				//	email.value = str;
				//} else {
				//	없는 아이디입니다.
				//}
            }

            button1.addEventListener("click", generator);

			function checkNum(){
				if(document.getElementById("1").value == '') {
					alert('인증번호를 먼저 받으세요.');
				} else if (document.getElementById("1").value == document.getElementById("2").value) {
					const user_email = form1.querySelector('input[type="email"]').value;

					var form = document.createElement('form'); // 폼객체 생성
					var objs;
					objs = document.createElement('input'); // 값이 들어있는 녀석의 형식
					objs.setAttribute('type', 'email'); // 값이 들어있는 녀석의 type
					objs.setAttribute('name', 'email'); // 객체이름
					objs.setAttribute('value', user_email); //객체값
					form.appendChild(objs);
					form.setAttribute('method', 'post'); //get,post 가능
					form.setAttribute('action', "/findid"); //보내는 url
					document.body.appendChild(form);
					form.submit();
				} else {
					alert('인증번호가 틀립니다.');
				}
			}

        </script>
	</div>
</body>
</html>