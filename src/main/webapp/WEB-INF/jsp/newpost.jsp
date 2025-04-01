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
	<link type="text/css" href="/resources/css/CoolWorld.css?4" rel="stylesheet"><!-- css적용안될때 .css뒤에 ?뒤에 문자열을 아무거나 집어넣자 -->
	<link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Merienda:wght@300..900&display=swap" rel="stylesheet"> <!--위3줄폰트-->
	<style>
	</style>
    <script>
        $.ajaxSetup({
            dataType : "text",
            contentType: 'application/json; charset=utf-8',
			success:function(result){
				if(result == 0) {
				    alert("다시 로그인해주세요.");
				} else if(result == 1) {
				    alert("성공적으로 작성되었습니다.");
				}
			},
			error: function (jqXHR) {
                //alert("jqXHR status code:"+jqXHR.status+" message:"+jqXHR.responseText);
            }
		});//ajaxSetup
        $(document).ready(function(){
            $("#postInfo").submit(function(event) {
                event.preventDefault(); //불필요한 페이지새로고침 방지
                const data = {
                    content: $('#content').val()
                };
                $.ajax({
                    type: "POST",
                    url: "/post/create",
                    data:JSON.stringify(data)
                }).done(function(){ // done - success 와 동일
                    location.href='/';
                }).fail(function (error) {
                    //alert(JSON.stringify(error));
                    alert('잘못된 접근입니다');
                });
            });
        });
    </script>
</head>
<body>
    <div class="post-container1" style="margin-top: 8%; background-color:white; padding: 0px; display: flex;">
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
        <h4 style="text-align: center;">게시물 작성</h3>
            <textarea id="content" name="content" class="input-field" placeholder="내용을 입력하세요" rows="5" required></textarea>
            <button type="submit" class="btn btn-primary">작성 완료</button>
        </div>
    </div>
    </form>
</body>
</html>