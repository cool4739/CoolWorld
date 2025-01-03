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
        $(document).ready(function() {
            var num = $("#num").val();
            $.ajax({
                type: "GET",
                url: "/user/info", <!--임시로 1로 설정 스프링에 쿠키 만들기 전까지-->
                success: function(data) {
                    $('input[name=nick]').attr('value',data.nick);
                    $('input[name=email]').attr('value',data.email);
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
		<div style="border-bottom: 2px solid black; height: 6vh; text-align: center;">
			<h2>나의 정보</h2>
		</div>
		<div class="container1" style="margin-top: 3%; width: 30.7vw;">
			<img src="https://user-images.githubusercontent.com/102495801/167056576-0a2c3920-d8f8-47b2-bdcb-dd4d2a9cd205.png" alt="■" style="float: left; width: 2vw;">
			<h5 style="margin-left: 1.5%; border-bottom: 1px solid black; display: inline-block;">내 정보</h5>
			<a href="사용자정보변경" class="btn btn-primary shadow-none" role="button" style="padding: 0.5%; float:right; border-color: #d29e79; color: #d29e79; width:6vw; height:2vw">정보변경</a>
		</div>
		<div class="container1" style="margin-top: 3%; width: 30.7vw;">
		    <h5 style="margin-left: 8%; display: inline-block;">닉네임 : </h5>
			<input style="display: inline-block; background-color:transparent; border:none; font-size:1.1rem;" name="nick" value="a" disabled/>
		</div>
		<div class="container1" style="margin-top: 3%; width: 30.7vw;">
			<h5 style="margin-left: 8%; display: inline-block;">이메일 : </h5>
			<input style="display: inline-block; background-color:transparent; border:none; font-size:1.1rem;" name="email" value="a" disabled/>
		</div>
		<div class="container1" style="margin-top: 3%; width: 30.7vw;">
			<h5 style="margin-left: 8%; display: inline-block;">나의 그룹 : </h5>
			<img src="https://user-images.githubusercontent.com/102495801/167052579-3c276158-43f3-464e-aada-491f15b94ccf.jpg" alt="●" style="display: inline-block; margin-left: 1.5%; width: 6%;">
		</div>
		<div class="container1" style="margin-top: 3%; width: 30.7vw; text-align: left; margin-left: 8%;">
			<a href="설문조사" style="font-size: 1.2rem; display: inline-block;">설문조사 다시하기</a>
		</div>
		<div class="container1" style="margin-top: 3%; width: 30.7vw;">
			<img src="https://user-images.githubusercontent.com/102495801/167052651-8c3ae662-4fbd-4286-9f6f-78df6207c350.png" alt="♥" style="display: inline-block; width: 6%">
			<h5 style="margin-left: 1.5%; border-bottom: 1px solid black; display: inline-block;">좋아하는 카페</h5>
		</div>
		<div class="container1" style="margin-top: 3%; width: 30.7vw;">
			<h5 style="margin-left: 8%; display: inline-block;">○○카페</h5>
		</div>
		<div class="container1" style="margin-top: 3%; width: 30.7vw;">
			<h5 style="margin-left: 8%; display: inline-block;">□□카페</h5>
		</div>
		<div class="container1" style="margin-top: 3%; width: 30.7vw;">
			<h5 style="margin-left: 8%; display: inline-block;">△△카페</h5>
		</div>
		<div class="container1" style="margin-top: 3%; width: 30.7vw; text-align: left;">
			<img src="https://user-images.githubusercontent.com/102495801/167052762-91763aff-63c7-4375-aee3-25561e1af81c.png" alt="★" style="display: inline-block; width: 6%;">
			<a href="나의작성글" style="font-size: 1.2rem; margin-left: 1.5%; display: inline-block;">나의 작성글</a>
		</div>
	</div>
</body>
</html>