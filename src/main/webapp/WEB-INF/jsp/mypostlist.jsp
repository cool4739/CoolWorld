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
            let currentPage = 0;
            const pageSize = 10;
            let loading = false; // 중복 호출 방지용

            function addPost(postid, content, views, comments, likes, liked) {
                const heartIcon = liked ? '❤️' : '🖤';
                let newPost = `
                    <div class="post-container2" style="cursor:pointer;" onclick="location.href='/postinfo/${'${'}postid}'">
                        <div class="post-content">${'${'}content}</div>
                        <div class="post-info">
                            <span>조회수: ${'${'}views}</span>
                            <span>댓글: ${'${'}comments}</span>
                            <span>${'${'}heartIcon} 공감: ${'${'}likes}</span>
                        </div>
                    </div>
                `;
                $(".post-container1").append(newPost); // 맨 앞에 추가됨 → 최신 글이 위로
            }

            function loadPosts(page) {
                if (loading) return;
                loading = true;

                $.ajax({
                    type: "GET",
                    url: "/post/mypostlistread/" + userid,
                    data: {
                        page: page,
                        size: pageSize
                    }
                }).done(function (data) {
                    if (data.length === 0) {
                        // 더 이상 불러올 게시물이 없으면 스크롤 이벤트 제거
                        $(window).off("scroll");
                    } else {
                        data.forEach(function (post) {
                            addPost(post.postid, post.content, post.views, post.comments, post.likes, post.liked);
                        });
                        currentPage++;
                    }
                }).fail(function () {
                    alert('게시물 로드 오류');
                }).always(function () {
                    loading = false;
                });
            }

            loadPosts(currentPage); // 최초 5개 로드

            $(window).scroll(function () {
                // 문서 높이 - 윈도우 높이 - 스크롤탑이 100 이하가 되면 (즉, 바닥에 가까우면)
                if ($(window).scrollTop() + $(window).height() >= $(document).height() - 100) {
                    loadPosts(currentPage);
                }
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
    <h2 style="font-weight: bold; text-align: left; font-family: Merienda; font-weight: bold; width: 50%;">
      <a href="main" style="color: black; text-decoration: none; display: inline-block;">CoolWorld</a>
    </h2>
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