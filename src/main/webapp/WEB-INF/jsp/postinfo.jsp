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
		const userid = "${userid}";
		const postid = "${postid}";
        $(document).ready(function(){
            function timeSet(uptime) {
                const date = new Date(uptime); // uptime이 문자열이면 Date로 파싱 가능
                const year = date.getFullYear();
                const month = (date.getMonth() + 1).toString().padStart(2, '0'); // 0-based
                const day = date.getDate().toString().padStart(2, '0');
                const hour = date.getHours().toString().padStart(2, '0');
                const minute = date.getMinutes().toString().padStart(2, '0');

                return `${'${'}year}.${'${'}month}.${'${'}day} ${'${'}hour}:${'${'}minute}`;
            }

            function addPost(postid, userid, nickname, content, views, comments, likes, uptime, imagepath, owner) {
                let newPost = `
                    <div class="post-container2">

                        <div style="display: flex;">
                            <div class="post-author" style="font-weight:bold; margin-bottom:4px; width:50%;">${'${'}nickname}@${'${'}userid}</div>
                            <div style="text-align: right; width:50%;">
                                ${'${'}owner ? '<a href="" style="margin: 3%;" id="line">수정</a><a href="" id="" style="margin-left: 7%;">삭제</a>' : ''}
                            </div>
                        </div>

                        <div class="dumi" style="margin-bottom:8px; display: -webkit-box; font-size: 20px; color: #555; margin-bottom: 15px; white-space: pre-wrap; word-break: break-all;">${'${'}content}</div>
                        <div class="post-stats" style="font-size: 0.9em; color: gray;">
                            조회수: ${'${'}views} | 댓글: ${'${'}comments} | 🖤 공감: ${'${'}likes} | ${'${'}uptime}
                        </div>
                        ${'${'}imagepath ? `<div class="post-image" style="margin-top:8px;">
                            <img src="${'${'}imagepath}" alt="post image" style="max-width:100%; height:auto; border-radius:4px;">
                        </div>` : ''}
                    </div>
                `;
                $(".post-container1").append(newPost);
            }

            $.ajax({
                type: "GET",
                url: "/post/info/" + postid + "-" + userid,
            }).done(function (data) {
                console.log(data);
                data.forEach(function (post) {
                const formattedTime = timeSet(post.uptime);
                addPost(post.postid, post.userid, post.nickname, post.content, post.views, post.comments, post.likes, formattedTime, post.imagepath, post.owner);
                });
            }).fail(function () {
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
	    <h2 style="font-weight: bold; text-align: left; font-family: Merienda; font-weight: bold; width: 50%;">
          <a href="/main" style="color: black; text-decoration: none; display: inline-block;">CoolWorld</a>
        </h2>
		<div class="s1" style="text-align: right; width: 50%;">
			<a href="/mypage" style="margin: 2%;" id="line">마이페이지</a>
			<a href="/newpost" style="margin: 2%;" id="line">게시물작성</a>
			<a href="#" id="logoutBtn" style="margin: 2%;">로그아웃</a>
		</div>
	</div>
	<div class="post-container1">
    </div>
</body>
</html>