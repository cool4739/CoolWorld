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
	<link type="text/css" href="/resources/css/CoolWorld.css?2" rel="stylesheet"><!-- css적용안될때 .css뒤에 ?뒤에 문자열을 아무거나 집어넣자 -->
	<link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Merienda:wght@300..900&display=swap" rel="stylesheet"> <!--위3줄폰트-->
	<style>
        .post-container1 {
            margin: 0 auto;
            background-color: #f9f9f9;
            padding: 20px;
            width: 50%;
            min-width: 500px;
        }
        .post-container2 {
            margin: 0 auto;
            background: white;
            padding: 20px;
            width: 50%;
            min-width: 250px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        .post-title {
            overflow:hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
            font-size: 20px;
            font-weight: bold;
            margin-bottom: 10px;
        }
        .post-content {
            display: -webkit-box;
            -webkit-line-clamp: 3;
            -webkit-box-orient: vertical;
            overflow:hidden;
            text-overflow: ellipsis;
            font-size: 14px;
            color: #555;
            margin-bottom: 15px;
        }
        .post-info {
            overflow:hidden;
            text-overflow: ellipsis;
            display: flex;
            justify-content: space-between;
            font-size: 12px;
            color: #888;
            white-space: nowrap;
        }
	</style>
    <script>
        $.ajaxSetup({
            dataType : "text",
            contentType: 'application/json; charset=utf-8',
			success:function(result){
				//alert(result);
			},
			error: function (jqXHR) {
                //alert("jqXHR status code:"+jqXHR.status+" message:"+jqXHR.responseText);
            }
		});//ajaxSetup
        $(document).ready(function () {
            function addPost(title, content, views, comments, likes) {
                let newPost = `
                    <div class="post-container2">
                        <div class="post-title">${title}</div>
                        <div class="post-content">${content}</div>
                        <div class="post-info">
                            <span>조회수: ${views}</span>
                            <span>댓글: ${comments}</span>
                            <span class="like-button" data-liked="false">❤️ 공감: ${likes}</span>
                        </div>
                    </div>
                `;
                $(".post-container1").append(newPost); // 게시물 리스트에 추가
            }

            function loadNewPosts() {
                $.ajax({
                    url: "/getNewPosts", // 서버의 엔드포인트
                    method: "GET",
                    dataType: "json",
                    success: function (data) {
                        data.forEach(post => {
                            addPost(post.title, post.content, post.views, post.comments, post.likes);
                        });
                    },
                    error: function (err) {
                        console.error("게시물을 불러오는 중 오류 발생:", err);
                    }
                });
            }

            loadNewPosts(); //게시물 로드

            $(document).on("click", ".like-button", function () {
                let postId = $(this).closest(".post-container2").attr("data-post-id"); // 게시물 ID 가져오기
                let isLiked = $(this).attr("data-liked") === "true"; // 현재 좋아요 상태 확인
                let likeCount = parseInt($(this).text().replace(/\D/g, "")); // 숫자만 추출

                $.ajax({
                    url: "/updateLike",
                    method: "POST",
                    data: { postId: postId, liked: !isLiked },
                    success: function (response) {
                        console.log("좋아요 상태 업데이트 완료");
                    },
                    error: function (err) {
                        console.error("서버 오류:", err);
                    }
                });

                if (isLiked) { // OFF
                    $(this).attr("data-liked", "false").css("color", "#888").text(`🖤 공감: ${likeCount}`);
                } else { // ON
                    $(this).attr("data-liked", "true").css("color", "red").text(`❤️ 공감: ${likeCount + 1}`);
                }
            });
        });
    </script>
</head>
<body>
    <div class="post-container1" style="margin-top: 8%; background-color:white; padding: 0px; display: flex;">
	    <h2 style="text-align: left; font-family: Merienda; font-weight: bold; width: 50%;">CoolWorld</h2>
		<div class="s1" style="text-align: right; width: 50%;">
			<a href="mypage" style="margin: 2%;" id="line">마이페이지</a>
			<a href="newpost" style="margin: 2%;" id="line">게시물작성</a>
			<a href="" style="margin: 2%;">로그아웃</a>
		</div>
	</div>
	<div class="post-container1">
        <div class="post-container2">
            <div class="post-title">게시물 제목</div>
            <div class="post-content">게시물 내용</div>
            <div class="post-info">
                <span>조회수: xxx</span>
                <span>댓글: yyy</span>
                <span class="like-button" data-liked="false">❤️ 공감: zzz</span>
            </div>
        </div>
    </div>
</body>
</html>