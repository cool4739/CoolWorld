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
		.heart-btn {
			background: none;
			border: none;
			cursor: pointer;
			font-size: 1.1em;
			padding: 0;
			margin-right: 3px;
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
		const postid = "${postid}";
        $(document).ready(function(){
            // textarea에서 Enter로 제출 (Shift+Enter는 줄바꿈)
            $("#comment").keydown(function(e) {
                if (e.keyCode === 13 && !e.shiftKey) {
                    e.preventDefault(); // 기본 Enter 동작(줄바꿈) 방지
                    $("#commentForm").submit();
                }
            });

            function timeSet(uptime) {
                const date = new Date(uptime); // uptime이 문자열이면 Date로 파싱 가능
                const year = date.getFullYear();
                const month = (date.getMonth() + 1).toString().padStart(2, '0'); // 0-based
                const day = date.getDate().toString().padStart(2, '0');
                const hour = date.getHours().toString().padStart(2, '0');
                const minute = date.getMinutes().toString().padStart(2, '0');

                return `${'${'}year}.${'${'}month}.${'${'}day} ${'${'}hour}:${'${'}minute}`;
            }

            function addPost(postid, userid, nickname, content, views, comments, likes, uptime, imagepath, owner, liked) {
                const heartIcon = liked ? '❤️' : '🖤';
                let newPost = `
                    <div class="post-container2">
                        <div style="display: flex;">
                            <div class="post-author" style="font-weight:bold; margin-bottom:4px; width:50%;">${'${'}nickname}#${'${'}userid}</div>
                            <div style="text-align: right; width:50%;">
                                ${'${'}owner ? '<a href="/postupdate/${postid}" style="margin: 3%;" id="line">수정</a><a href="#" id="deleteBtn" style="margin-left: 7%;">삭제</a>' : ''}
                            </div>
                        </div>
                        <div class="dumi" style="margin-bottom:8px; display: -webkit-box; font-size: 20px; color: #555; margin-bottom: 15px; white-space: pre-wrap; word-break: break-all;">${'${'}content}</div>
                        <div class="post-stats" style="font-size: 0.9em; color: gray;">
                            조회수: ${'${'}views} | 댓글: ${'${'}comments} |
                            <button class="heart-btn" data-postid="${postid}">
                                <span>${'${'}heartIcon}</span>
                            </button>
                            공감: <span>${'${'}likes}</span> | ${'${'}uptime}
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
                addPost(post.postid, post.userid, post.nickname, post.content, post.views, post.comments, post.likes, formattedTime, post.imagepath, post.owner, post.liked);
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

            $(document).on("click", "#deleteBtn", function () {
                $.ajax({
                    type: "DELETE",
                    url: "/post/delete/" + postid,
                }).done(function () {
                    alert("게시글이 삭제되었습니다.");
                    location.href = "/";
                }).fail(function () {
                    alert("삭제 실패");
                });
            });


            $("#commentForm").submit(function(event){
				event.preventDefault(); //불필요한 페이지새로고침 방지
                const data = {
                    postid: postid,
                    comment: $("#comment").val()
                };
				$.ajax({
					type: "POST",
					url: "/post/comment",
					data:JSON.stringify(data)
				}).done(function () {
					$("#comment").val("");
					loadComment(); // 댓글 새로고침
				}).fail(function () {
					alert("댓글 작성 실패");
				});
			});

            $(document).on("click", "#commentDeleteBtn", function () {
                const commentid = $(this).closest('.comment-item').find('div:first').text();
                $.ajax({
                    type: "DELETE",
                    url: "/post/commentDelete/" + commentid,
                }).done(function () {
                    alert("댓글이 삭제되었습니다.");
                    loadComment();
                }).fail(function () {
                    alert("삭제 실패");
                });
            });

			// [추가] 댓글 로드 함수
			function loadComment(){
				$.ajax({
					type: "GET",
					url: "/post/commentList/" + postid + "-" + userid,
				}).done(function (data) {
				    console.log(data);
					$("#commentList").empty();
					data.forEach(function(data){
					    const formattedTime = timeSet(data.uptime);
						$("#commentList").append(`
							<div class="comment-item" style="display:flex; justify-content:space-between; align-items:center;">
							    <div style="display:none;">${'${'}data.commentid}</div>
								<div class="comment-name" style="font-weight:bold;">${'${'}data.nickname}#${'${'}data.userid}</div>
								<div>${'${'}data.owner ? '<a href="#" id="commentDeleteBtn">삭제</a>' : ''}</div>
								<div class="comment-time" style="">${'${'}formattedTime}</div>
							</div>
							<div class="comment-comment" style="white-space: pre-wrap; word-break: break-all; margin-bottom: 5%;">${'${'}data.comment}</div>
						`);
					});
				}).fail(function () {
				    alert("댓글 로드 실패");
			    });
			}

			// 페이지 로드시 댓글 불러오기
			loadComment();

			// 공감 클릭 이벤트
            $(document).on("click", ".heart-btn", function() {
                const heartSpan = $(this).find("span");
                const likesSpan = $(this).closest(".post-stats").find("span").last();
                const data = {
                    postid: postid
                };

                $.ajax({
                    type: "POST",
                    url: "/post/like",
                    data:JSON.stringify(data)
                }).done(function(data) {
                    if(data.liked) {
                        heartSpan.text("❤️");
                        likesSpan.text(parseInt(likesSpan.text()) + 1);
                    } else {
                        heartSpan.text("🖤");
                        likesSpan.text(parseInt(likesSpan.text()) - 1);
                    }
                }).fail(function() {
                    alert("공감 처리 중 오류가 발생했습니다.");
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

	<div class="post-container3">
	    <div class="post-container2">
	        <h5>댓글 목록</h5>
		    <!-- [추가] 댓글 목록 -->
		    <div id="commentList" class="mt-4">
			    <!-- 댓글이 여기에 동적으로 로드됩니다 -->
		    </div>
		</div>
		<form id="commentForm" style="width: 50%; margin: 0 auto;">
		    <h5>댓글 작성</h5>
			<textarea id="comment" rows="3" class="form-control" placeholder="댓글을 입력하세요" required></textarea>
			<button type="submit" class="btn btn-primary mt-2" style="">등록</button>
		</form>
	</div>

</body>
</html>