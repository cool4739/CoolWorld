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
    </script>
</head>
<body>
    <div class="post-container1" style="margin-top: 8%; background-color:white; padding: 0px; display: flex;">
	    <h2 style="text-align: left; font-family: Merienda; font-weight: bold; width: 50%;">CoolWorld</h2>
		<div class="s1" style="text-align: right; width: 50%;">
			<a href="mypage" style="margin: 2%;" id="line">마이페이지</a>
			<a href="newpost" style="margin: 2%;" id="line">게시물작성</a>
			<a href="#" id="logoutBtn" style="margin: 2%;">로그아웃</a>
		</div>
	</div>
	<div class="post-container1">
        <div class="post-container2">
        <h3 style="text-align: center;">게시물 작성</h3>
        <form action="submitPost" method="POST">
            <textarea name="content" class="input-field" placeholder="게시물 내용을 입력하세요" rows="5" required></textarea>
            <button type="submit" class="btn btn-primary">작성 완료</button>
        </form>
        </div>
    </div>
</body>
</html>