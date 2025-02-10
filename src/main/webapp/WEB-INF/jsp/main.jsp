<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta http-equiv="X-UA-Compatible" content="ie=edge">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<link type="text/css" href="/resources/css/CoolWorld.css?2" rel="stylesheet"><!-- css적용안될때 .css뒤에 ?뒤에 문자열을 아무거나 집어넣자 -->
	<link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Merienda:wght@300..900&display=swap" rel="stylesheet"> <!--위3줄폰트-->
	<style>
        .post-container1 {
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
            display: flex;
            justify-content: center;
            padding: 20px;
        }
        .post-container2 {
            background: white;
            padding: 20px;
            width: 500px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        .post-title {
            font-size: 20px;
            font-weight: bold;
            margin-bottom: 10px;
        }
        .post-content {
            font-size: 14px;
            color: #555;
            margin-bottom: 15px;
        }
        .post-info {
            display: flex;
            justify-content: space-between;
            font-size: 12px;
            color: #888;
        }
	</style>
	<script>
	</script>
</head>
<body>
	<h2 style="text-align: center; margin-top: 8%; font-family:Merienda; font-weight: bold;">CoolWorld</h2>
	<div class="post-container1">
    <div class="post-container2">
        <div class="post-title">게시물 제목</div>
        <div class="post-content">여기에 게시물 내용이 일부 표시됩니다. 더보기 기능을 추가할 수도 있습니다.</div>
        <div class="post-info">
            <span>조회수: 120</span>
            <span>댓글: 15</span>
            <span>공감: 42</span>
        </div>
    </div>
    </div>
</body>
</html>