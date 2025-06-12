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
		function checkValue() {
			if(!document.postInfo.nickname.value) {
				alert("닉네임을 입력하세요.");
				return false;
			}
			if(!document.postInfo.currentPassword.value) {
				alert("현재 비밀번호를 입력하세요.");
				return false;
			}
			if(!document.postInfo.newPassword.value) {
				alert("새 비밀번호를 입력하세요.");
				return false;
			}
		}
		const userid = "${userid}";
        $(document).ready(function(){
            $.ajax({
                type: "GET",
                url: "/user/mypage/" + userid,
            }).done(function(data){ // done - success 와 동일
                let fields = $(".input-field");
                $(fields[0]).append(data.userid);
                $(fields[1]).append(data.username);
                $(fields[3]).append(data.email);
            }).fail(function (error) {
                //alert(JSON.stringify(error));
                alert('로드 오류');
            });
            $("#logoutBtn").click(function (e) {
                e.preventDefault();
                $.ajax({
                    type: "POST",
                    url: "/user/logout",
                    contentType: false,
                    dataType: "text"
                }).done(function () {
                    alert("로그아웃 되었습니다.");
                    location.href = "/";
                }).fail(function () {
                    alert("로그아웃 실패");
                });
            });

            $("#updateBtn").click(function () {
                if (checkValue() == false) {
                    return false;
                } else {
                    const nickname = $("#nickname").val();
                    const currentPassword = $("#currentPassword").val();
                    const newPassword = $("#newPassword").val();
                    const confirmPassword = $("#confirmPassword").val();

                    if (newPassword && newPassword !== confirmPassword) {
                        alert("새 비밀번호가 일치하지 않습니다.");
                        return;
                    }

                    const data = {
                        userid: userid,
                        nickname: nickname,
                        currentPassword: currentPassword,
                        newPassword: newPassword
                    };

                    $.ajax({
                        type: "PUT",
                        url: "/user/update",
                        data: JSON.stringify(data),
                        contentType: "application/json; charset=UTF-8",
                    }).done(function (result) {
        				if(result == 0) {
        				    alert("현재 비밀번호가 일치하지 않습니다.");
        				} else if(result == 1) {
        				    alert("다른 닉네임을 입력해주세요.");
        				} else if(result == 2) {
        				    alert("새 비밀번호를 다시 입력해주세요.");
        				    location.href='/';
        				} else if(result == 3){
        				    alert("정보가 변경되었습니다.");
        				    location.href = "/mypage";
        				} else {
        				    alert("반환값오류");
        				}
                    }).fail(function (err) {
                        alert(JSON.stringify(error));
                    });
                }
            });
        });
    </script>
</head>
<body>
    <div class="post-container0" style="margin-top: 8%; background-color:white; padding: 0px; display: flex;">
    <h2 style="font-weight: bold; text-align: left; font-family: Merienda; font-weight: bold; width: 50%;">
      <a href="main" style="color: black; text-decoration: none; display: inline-block;">CoolWorld</a>
    </h2>
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
        <div class="input-field">
            <strong>닉네임:</strong>
            <input type="text" id="nickname" class="form-control" style="width: 300px;" />
        </div>
        <div class="input-field"><strong>이메일:</strong></div>
        <h5>비밀번호 변경</h5>
        <div class="input-field">
            <strong>현재 비밀번호:</strong>
            <input type="password" id="currentPassword" class="form-control" style="width: 300px;" />
        </div>
        <div class="input-field">
            <strong>새 비밀번호:</strong>
            <input type="password" id="newPassword" class="form-control" style="width: 300px;" />
        </div>
        <div class="input-field">
            <strong>비밀번호 확인:</strong>
            <input type="password" id="confirmPassword" class="form-control" style="width: 300px;" />
        </div>
        <button type="button" class="btn btn-primary" id="updateBtn">변경완료</button>
        </div>
    </div>
    </form>
</body>
</html>