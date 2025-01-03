<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	
	<meta name="viewport" conent="width=device-width, initial-scale=1.0">
	<meta http-equiv="X-UA-Compatible" content="ie=edge">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<style>
		.container1 {
			display: inline-block;
			text-align: left;
		}
		.bar {
			background-color: #D9D9D9;
			position: fixed;
			top: 0px;
			bottom: 0px;
			right: 0px;
		}
		<!--가로 스크롤 바
		.wrap-vertical{
			width: 275px;
			padding: 20px;
			overflow: scroll;
			color: #112031;
			background: #F0D9FF;
			border: 1px solid #000;
			overflow: auto;
			white-space: nowrap;
		}
		.wrap-vertical::-webkit-scrollbar{
			display: none;
		}
		-->
		.btn-primary{background-color: #f9e2d1;}
        .btn-primary:hover {
		    background-color: #f9e2d1;
		}
        .btn-primary:focus {
		    background-color: white;
		}
	</style>
	<script>
        $.ajaxSetup({
            dataType : "json",
            contentType: 'application/json; charset=utf-8',
			success:function(result){
				alert(result);
			},
			error: function (jqXHR) {
                alert("jqXHR status code:"+jqXHR.status+" message:"+jqXHR.responseText);
            }
		});//ajaxSetup
        function doOpenCheck(chk){
		    var obj = document.getElementsByName("sex");
		    for(var i=0; i<obj.length; i++){
			    if(obj[i] != chk){
				    obj[i].checked = false;
			    }
		    }
	    }
	    function checkValue() {
	        alert('빈칸 검사 시작');
		    if(!document.userInfo.pw.value) {
			    alert("비밀번호를 입력하세요.");
			    return false;
		    }
		    if(!document.userInfo.nick.value) {
			    alert("닉네임을 입력하세요.");
			    return false;
		    }
		    if(!document.userInfo.email.value) {
			    alert("이메일을 입력하세요.");
			    return false;
		    }
		    if(document.userInfo.pw.value != document.userInfo.pwcheck.value) {
			    alert("비밀번호를 동일하게 입력하세요.");
			    return false;
		    }
		    var check2 = document.querySelectorAll('input[name="sex"]:checked').length;
		    if (check2 == 0) {
			    alert("성별을 입력하세요.");
			    return false;
		    }
	    }
        $(document).ready(function(){
            $("#userInfo").submit(function(event) {
                alert('시작');
                if(checkValue() == false) {
                    alert('빈칸 발견');
                    return false;
                } else {
                    alert('데이터 입력중');
                    var age = $('#age').val();
                    age = parseInt(age);
                    const data = {
                        pw : $('#pw').val(),
                        nick : $('#nick').val(),
                        email : $('#email').val(),
                        age : age,
                        sex : $('#sex').val(),
                        proImg : $('#proImg').val(),
                    };
                    $.ajax({
                        type: "PUT",
                        url: "/user/update",
                        data:JSON.stringify(data)
                    }).done(function(){ // done - success 와 동일
                        alert('성공');
                    }).fail(function (error) {
                        alert(JSON.stringify(error));
                    });
                }
            });
        });
	</script>
</head>
<body>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<h1 style="text-align: center; margin-top: 1%; font-family:BernhardFashion BT; font-weight: bold; font-size: 2.4rem;">Cafe_in</h1>
	<div class="container1" style="position: absolute; border-bottom: 1px solid black; left: 25%; top: 10%; background-color: #EAEAEA; border: 3px solid #A0A0A0; border-radius: 20px;">
		<img src="resources/img/coffee.png" style="float: left; margin: 5%; width: 90%;" alt="이미지">
	</div>
	<div class="bar" style="width: 5vw;">
		<a href="메인화면">
			<img src="https://user-images.githubusercontent.com/102495801/167056604-ed2c2e9c-426d-455b-84f9-54bb4f82a0c2.png" alt="main_img" style="margin-top: 30%; width: 2vw; margin-left: 30%;">
		</a>
		<a href="카페글쓰기">
			<img src="https://user-images.githubusercontent.com/102495801/167056127-afdaad04-d13b-4a33-a4c0-9c2d8904ead8.png" alt="write_img" style="margin-top: 30%; width: 2vw; margin-left: 30%;">
		</a>
		<a href="사용자마이페이지">
			<img src="https://user-images.githubusercontent.com/102495801/167056576-0a2c3920-d8f8-47b2-bdcb-dd4d2a9cd205.png" alt="mypage_img" style="margin-top: 30%; width: 2vw; margin-left: 30%;">
		</a>
	</div>
	<div class="container1" style="position: absolute; left: 35%; top: 10%; padding: 1%; width: 33vw; height: ; border: 3px solid #A0A0A0; border-radius: 20px; background-color: #FDF2E9;">
		<form id="userInfo" name="userInfo">

		<div style="border-bottom: 2px solid black; height: 6vh; text-align: center;">
			<h2>나의 정보변경</h2>
		</div>
		<div class="container1" style="margin-top: 3%; width: 30.7vw;">
			<img src="https://user-images.githubusercontent.com/102495801/167056576-0a2c3920-d8f8-47b2-bdcb-dd4d2a9cd205.png" alt="■" style="float: left; width: 2vw;">
			<h5 style="margin-left: 1.5%; border-bottom: 1px solid black; float: left;">내 정보</h5>
		</div>
		<div class="container1" style="margin-top: 3%; width: 30.7vw;">
		    <h5 style="display: inline-block; width:12vw;">변경할 비밀번호</h5>
			<input type="password" class="form-control" id="pw" name="pw" style="width: 15vw; display: inline-block;">
		</div>
		<div class="container1" style="margin-top: 3%; width: 30.7vw;">
		    <h5 style="display: inline-block; width:12vw;">비밀번호 확인</h5>
			<input type="password" class="form-control" id="" name="pwcheck" style="width: 15vw; display: inline-block;">
		</div>
        <div class="container1" style="margin-top: 3%; width: 30.7vw;">
		    <h5 style="display: inline-block; width:12vw;">닉네임 변경</h5>
			<input type="text" class="form-control" id="nick" name="nick" style="width: 15vw; display: inline-block;">
		</div>
        <div class="container1" style="margin-top: 3%; width: 30.7vw;">
		    <h5 style="display: inline-block; width:12vw;">이메일 변경</h5>
			<input type="email" class="form-control" id="email" name="email" style="width: 15vw; display: inline-block;">
		</div>
        <div class="container1" style="margin-top: 3%; width: 30.7vw;">
		    <h5 style="display: inline-block; width:12vw;">나이 설정</h5>
			<input type="number" class="form-control" id="age" name="age" style="width: 15vw; display: inline-block;">
		</div>
        <div class="container1" style="margin-top: 3%; width: 30.7vw;">
		    <h5 style="display: inline-block; width:12vw;">성별 변경</h5>

            <input class="form-check-input" type="checkbox" value="MALE" id="sex" name="sex" onclick="doOpenCheck(this);">
			<label class="form-check-label" for="sex">
		        남자
			</label>
            <input class="form-check-input" type="checkbox" value="FEMALE" id="sex" name="sex" onclick="doOpenCheck(this);">
			<label class="form-check-label" for="sex">
				여자
			</label>
		</div>
        <!--<div class="container1" style="margin-top: 3%; width: 30.7vw;">
		    <h5 style="display: inline-block;">프로필사진 변경</h5>
			<input type="file" accept="image/*," required style="display: inline-block;" id="proImg" name="proImg"/>
		</div>-->
        <div class="container1" style="margin-top: 3%; width: 30.7vw;">
		    <button type="submit" class="btn btn-primary shadow-none" style="padding: 0.5%; float:right; border-color: #d29e79; color: #d29e79; width:6vw; height:2vw">
        	    변경 완료
            </button>
		</div>

		</form>
	</div>
</body>
</html>