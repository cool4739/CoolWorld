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
	<link type="text/css" href="/resources/css/CoolWorld.css?1" rel="stylesheet"><!-- css적용안될때 .css뒤에 ?뒤에 문자열을 아무거나 집어넣자 -->
	<link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Merienda:wght@300..900&display=swap" rel="stylesheet"> <!--위3줄폰트-->
	<style>
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
        $(document).ready(function(){
            function addPost(content, views, comments, likes) {
                let newPost = `
                    <div class="post-container2">
                        <div class="post-content">${'${'}content}</div>
                        <div class="post-info">
                            <span>조회수: ${'${'}views}</span>
                            <span>댓글: ${'${'}comments}</span>
                            <span class="like-button" style="color: gray; cursor: pointer;">🖤 공감:
                                <span class="like-count">${'${'}likes}</span>
                            </span>
                        </div>
                    </div>
                `;
                $(".post-container1").append(newPost);
            }

            $.ajax({
                type: "GET",
                url: "/post/read",
            }).done(function(data){ // done - success 와 동일
                data.forEach(function(post) {
                    addPost(post.content, post.views, post.comments, post.likes);
                });
            }).fail(function (error) {
                //alert(JSON.stringify(error));
                alert('게시물 로드 오류');
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
	<div class="post-container1">
    </div>
</body>
</html>