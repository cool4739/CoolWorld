<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta http-equiv="X-UA-Compatible" content="ie=edge">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<link type="text/css" href="/resources/css/CoolWorld.css?" rel="stylesheet"><!-- css적용안될때 .css뒤에 ?뒤에 문자열을 아무거나 집어넣자 -->
	<link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Merienda:wght@300..900&display=swap" rel="stylesheet"> <!--위3줄폰트-->
	<style>
	    #line2::after {
            content: '';
            position: absolute;
            margin-left: 0.6%;
            margin-top: 0.1%;
            width: 1px;
            height: 25px;
            background-color: gray;
        }
	</style>
    <script>
        $.ajaxSetup({
            dataType : "json",
            contentType: 'application/json; charset=utf-8',
			success:function(result){
			},
			error: function (jqXHR) {
                //alert("jqXHR status code:"+jqXHR.status+" message:"+jqXHR.responseText);
            }
		});//ajaxSetup
		const userid = "${userid}";
        $(document).ready(function(){
            $.ajax({
                type: "GET",
                url: "/user/mypage/" + userid,
            }).done(function(data){ // done - success 와 동일
                let fields = $(".input-field");
                $(fields[0]).append(data.userid);
                $(fields[1]).append(data.username);
                $(fields[2]).append(data.nickname);
                $(fields[3]).append(data.email);
            }).fail(function (error) {
                //alert(JSON.stringify(error));
                alert('게시물 로드 오류');
            });
        });
    </script>
</head>
<body>
    <div class="post-container0" style="margin-top: 8%; background-color:white; padding: 0px; display: flex;">
    <a href="main" style="text-align: left; font-family: Merienda; font-weight: bold; width: 50%; color:black;">
        <h2 style="font-weight: bold;">CoolWorld</h2>
    </a>
		<div class="s1" style="text-align: right; width: 50%;">
			<a href="mypage" style="margin: 2%;" id="line">마이페이지</a>
			<a href="newpost" style="margin: 2%;" id="line">게시물작성</a>
			<a href="#" id="logoutBtn" style="margin: 2%;">로그아웃</a>
		</div>
	</div>
	<form name="postInfo" id="postInfo">
	<div class="post-container1">
        <div class="post-container2">
        <h4 style="text-align: center;">내 정보
			<a href="#" style="margin: 2%;" id="line2">팔로워</a>
            <a href="#" id="logoutBtn" style="margin: 2%;">팔로우</a>
        </h4>
        <div class="input-field"><strong>아이디:</strong></div>
        <div class="input-field"><strong>성함:</strong></div>
        <div class="input-field"><strong>닉네임:</strong></div>
        <div class="input-field"><strong>이메일:</strong></div>
        <button type="button" class="btn btn-primary">내 정보 변경</button>
        <button type="button" class="btn btn-primary">내가 작성한 글</button>
        </div>
    </div>
    </form>
</body>
</html>