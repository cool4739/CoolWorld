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
        let isOwner = false;
        $(document).ready(function(){
            function addPost(postid, userid, content, imagepath, owner) {
                let newPost = `
                    <div class="post-container2">
                    <h4 style="text-align: center;">게시물 작성</h4>
                        <textarea id="content" name="content" class="input-field" rows="5" required>${'${'}content}</textarea>
                        <button type="submit" class="btn btn-primary">작성 완료</button>
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
                isOwner = post.owner;
                addPost(post.postid, post.userid, post.content, post.imagepath);
                });
            }).fail(function () {
                alert('게시물 로드 오류');
            });

            $(document).on("submit", "#postInfo", function () {
                event.preventDefault(); //불필요한 페이지새로고침 방지
                if (!isOwner) {
                    alert("수정 권한이 없습니다.");
                    return;
                }
                const data = {
                    postid: postid,
                    content: $('#content').val()
                };
                $.ajax({
                    type: "PUT",
                    url: "/post/update",
                    data:JSON.stringify(data)
                }).done(function(result){ // done - success 와 동일
                    alert('성공적으로 수정되었습니다.');
                    location.href= "/postinfo/" + postid;
                }).fail(function (error) {
                    //alert(JSON.stringify(error));
                    alert('수정 실패');
                });
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
	<form name="postInfo" id="postInfo">
	<div class="post-container1">

    </div>
    </form>
</body>
</html>