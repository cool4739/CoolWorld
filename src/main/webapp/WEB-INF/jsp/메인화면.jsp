<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta http-equiv="X-UA-Compatible" content="ie=edge">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<style>
		.html { <!--이렇게 하면 10px=1rem이라는데... 반응형으로 텍스트...음 -->
			fond-size: 62.5%;
		}
		.container1 {
			float: left;
			text-align: center;

		}
		.bar {
			background-color: #D9D9D9;
			position: fixed;
			top: 0px;
			bottom: 0px;
			right: 0px;
		}
		.circle {
			width : 1.5vw;
			height : 3vh;
			border-radius: 50%;
			float: left;
			margin-right: 10px;
		}
		<!--가로 스크롤 바
		.wrap-vertical{
			width: 275px;
			padding: 20px;
			overflow: scroll;
			color: #112031;
			background: #F0D9FF;
			border: 1px solid #000;
			overflow: auto;
			white-space: nowrap;
		}
		.wrap-vertical::-webkit-scrollbar{
			display: none; 
		}
		-->
	</style>
</head>
<body>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<h1 style="text-align: center; margin-top: 1%; font-family:BernhardFashion BT; font-weight: bold; font-size: 2.4rem;">Cafe_in</h1>
	<div class="container1" style="position: absolute; height: 15vh; width: 18.4vw; left: 25%; top: 10%; background-color: #EAEAEA; border: 3px solid #A0A0A0; border-radius: 20px;">
		<img src="resources/img/coffee.png" style="float: left; margin: 1% 1%;" alt="이미지">
		<input type="text" class="form-control" id="exampleFormControlInput1" style="position: absolute; bottom: 10%; right: 5%; width: 10vw; height: 5vh;" placeholder="검색란">
	</div>
	<div class="container1" style="position: absolute; width: 18.4vw; height: 9vh; left: 25%; top: 27%; background-color: #EAEAEA; border: 3px solid #A0A0A0; border-radius: 20px;">
		<button type="submit" class="btn" style="width: 2.5vw; height: 5vh; background-color: orange; border-radius: 50%; float: left; margin: 4.5% 0px 0px 9%;">a</button>
		<button type="submit" class="btn" style="width: 2.5vw; height: 5vh; background-color: orange; border-radius: 50%; float: left; margin: 4.5% 0px 0px 9%;">b</button>
		<button type="submit" class="btn" style="width: 2.5vw; height: 5vh; background-color: orange; border-radius: 50%; float: left; margin: 4.5% 0px 0px 9%;">c</button>
		<button type="submit" class="btn" style="width: 2.5vw; height: 5vh; background-color: orange; border-radius: 50%; float: left; margin: 4.5% 0px 0px 9%;">d</button>
		<!--나중에 버튼을 동물이미지로 변경?-->
	</div>
	<div class="container1" style="position: absolute; width: 18.4vw; left: 25%; top: 39%; background-color: #EAEAEA;  border: 3px solid #A0A0A0; border-radius: 20px;">
		<button type="button" class="btn btn-outline-warning" style="margin: 7% 3%; width: 3.5vw; height: 4.5vh;">#~~~</button>
		<button type="button" class="btn btn-outline-warning" style="margin: 7% 3%; width: 3.5vw; height: 4.5vh;">#~~~</button>
		<button type="button" class="btn btn-outline-warning" style="margin: 7% 3%; width: 3.5vw; height: 4.5vh;">#~~~</button>
		<button type="button" class="btn btn-outline-warning" style="margin: 7% 3%; width: 3.5vw; height: 4.5vh;">#~~~</button>
		<button type="button" class="btn btn-outline-warning" style="margin: 7% 3%; width: 3.5vw; height: 4.5vh;">#~~~</button>
		<button type="button" class="btn btn-outline-warning" style="margin: 7% 3%; width: 3.5vw; height: 4.5vh;">#~~~</button>
		<button type="button" class="btn btn-outline-warning" style="margin: 7% 3%; width: 3.5vw; height: 4.5vh;">#~~~</button>
		<button type="button" class="btn btn-outline-warning" style="margin: 7% 3%; width: 3.5vw; height: 4.5vh;">#~~~</button>
		<button type="button" class="btn btn-outline-warning" style="margin: 7% 3%; width: 3.5vw; height: 4.5vh;">#~~~</button>
	</div>
	<div class="container1" style="position: absolute; left: 47%; top: 10%; padding: 1%; background-color: #EAEAEA; width: 35vw; border: 3px solid #A0A0A0; border-radius: 20px;">
		<div class="container1" style="width: 15.6vw; height: 44vh; border: 3px solid black; margin-bottom: 1%; background-color: white;" onclick="location.href='카페정보'">
			<div style="margin: 2%; float: right;"><!--추천버튼-->
				<img src="https://user-images.githubusercontent.com/102495751/167248594-2f214c14-5c6d-4156-816d-b796147e5c6c.png" style="width: 1.5vw;" alt="♡">
			</div>
			<div style="margin-left: 4%; float: left; width: 14.3vw;"><!--그룹별추천-->
				<div class="circle" style="background-color: red;">5</div>
				<div class="circle" style="background-color: yellow;">1</div>
				<div class="circle" style="background-color: green;">7</div>
				<div class="circle" style="background-color: orange;">2</div>
				<div style="margin: 4%; margin-top: 0px; float: right;"><!--총추천-->
					<img src="https://user-images.githubusercontent.com/102495751/167248761-2a757747-acd9-42fd-a0c7-62c4d43bab0f.png" style="width: 1.5vw;" alt="(all)">15
				</div>
			</div>
			<div style="margin: 4%; margin-top: 30%; width: 14.2vw; border: 1px solid black; height: 24vh;"><!--카페사진-->
				<img src="https://user-images.githubusercontent.com/102495801/167244893-164ba9bd-a358-4ff1-88ea-0f25f822d44c.jpg" alt="이미지" style= "width: 100%; height: 100%;">
			</div>
			<div style="background-color: black; height: 2px; margin: 4%;"></div>
			<div style="margin-left: 4%; float: left;"><!--카페이름-->
				a카페
			</div>
			<div style="margin-right: 4%; float: right;"><!--작성자-->
				by Jason
			</div>
			<div style="width: 10vw; margin-top: 1%; margin-left: 4%; float: left; text-align: left;"><!--태그-->
				#~~~ #~~~ #~~~
			</div>
		</div>
		<div class="container1" style="width: 15.6vw; height: 44vh; border: 3px solid black; float: right; margin-left: 2%; margin-bottom: 1%; background-color: white;">
			<div style="margin: 2%; float: right;"><!--추천버튼-->
				<img src="https://user-images.githubusercontent.com/102495751/167248594-2f214c14-5c6d-4156-816d-b796147e5c6c.png" style="width: 1.5vw;" alt="♡">
			</div>
			<div style="margin-left: 4%; float: left; width: 14.3vw;"><!--그룹별추천-->
				<div class="circle" style="background-color: red;">5</div>
				<div class="circle" style="background-color: yellow;">1</div>
				<div class="circle" style="background-color: green;">7</div>
				<div class="circle" style="background-color: orange;">2</div>
				<div style="margin: 4%; margin-top: 0px; float: right;"><!--총추천-->
					<img src="https://user-images.githubusercontent.com/102495751/167248761-2a757747-acd9-42fd-a0c7-62c4d43bab0f.png" style="width: 1.5vw;" alt="(all)">15
				</div>
			</div>
			<div style="margin: 4%; margin-top: 30%; width: 14.2vw; border: 1px solid black; height: 24vh;"><!--카페사진-->
				<img src="https://user-images.githubusercontent.com/102495801/167244811-58e443d6-4921-49d7-9fe9-fbcdac6ec4d0.jpg" alt="이미지" style= "width: 100%; height: 100%;">
			</div>
			<div style="background-color: black; height: 2px; margin: 4%;"></div>
			<div style="margin-left: 4%; float: left;"><!--카페이름-->
				a카페
			</div>
			<div style="margin-right: 4%; float: right;"><!--작성자-->
				by Jason
			</div>
			<div style="width: 10vw; margin-top: 1%; margin-left: 4%; float: left; text-align: left;"><!--태그-->
				#~~~ #~~~ #~~~
			</div>
		</div>
		<div class="container1" style="width: 15.6vw; height: 44vh; border: 3px solid black; margin-bottom: 1%; background-color: white;">
			<div style="margin: 2%; float: right;"><!--추천버튼-->
				<img src="https://user-images.githubusercontent.com/102495751/167248594-2f214c14-5c6d-4156-816d-b796147e5c6c.png" style="width: 1.5vw;" alt="♡">
			</div>
			<div style="margin-left: 4%; float: left; width: 14.3vw;"><!--그룹별추천-->
				<div class="circle" style="background-color: red;">5</div>
				<div class="circle" style="background-color: yellow;">1</div>
				<div class="circle" style="background-color: green;">7</div>
				<div class="circle" style="background-color: orange;">2</div>
				<div style="margin: 4%; margin-top: 0px; float: right;"><!--총추천-->
					<img src="https://user-images.githubusercontent.com/102495751/167248761-2a757747-acd9-42fd-a0c7-62c4d43bab0f.png" style="width: 1.5vw;" alt="(all)">15
				</div>
			</div>
			<div style="margin: 4%; margin-top: 30%; width: 14.2vw; border: 1px solid black; height: 24vh;"><!--카페사진-->
				<img src="https://user-images.githubusercontent.com/102495801/167244913-196aea78-ddbb-4664-89b2-f2dd0213f556.jpg" alt="이미지" style= "width: 100%; height: 100%;">
			</div>
			<div style="background-color: black; height: 2px; margin: 4%;"></div>
			<div style="margin-left: 4%; float: left;"><!--카페이름-->
				a카페
			</div>
			<div style="margin-right: 4%; float: right;"><!--작성자-->
				by Jason
			</div>
			<div style="width: 10vw; margin-top: 1%; margin-left: 4%; float: left; text-align: left;"><!--태그-->
				#~~~ #~~~ #~~~
			</div>
		</div>
		<div class="container1" style="width: 15.6vw; height: 44vh; border: 3px solid black; float: right; margin-left: 2%; margin-bottom: 1%; background-color: white;">
			<div style="margin: 2%; float: right;"><!--추천버튼-->
				<img src="https://user-images.githubusercontent.com/102495751/167248594-2f214c14-5c6d-4156-816d-b796147e5c6c.png" style="width: 1.5vw;" alt="♡">
			</div>
			<div style="margin-left: 4%; float: left; width: 14.3vw;"><!--그룹별추천-->
				<div class="circle" style="background-color: red;">5</div>
				<div class="circle" style="background-color: yellow;">1</div>
				<div class="circle" style="background-color: green;">7</div>
				<div class="circle" style="background-color: orange;">2</div>
				<div style="margin: 4%; margin-top: 0px; float: right;"><!--총추천-->
					<img src="https://user-images.githubusercontent.com/102495751/167248761-2a757747-acd9-42fd-a0c7-62c4d43bab0f.png" style="width: 1.5vw;" alt="(all)">15
				</div>
			</div>
			<div style="margin: 4%; margin-top: 30%; width: 14.2vw; border: 1px solid black; height: 24vh;"><!--카페사진-->
				<img src="https://user-images.githubusercontent.com/102495801/167244893-164ba9bd-a358-4ff1-88ea-0f25f822d44c.jpg" alt="이미지" style= "width: 100%; height: 100%;">
			</div>
			<div style="background-color: black; height: 2px; margin: 4%;"></div>
			<div style="margin-left: 4%; float: left;"><!--카페이름-->
				a카페
			</div>
			<div style="margin-right: 4%; float: right;"><!--작성자-->
				by Jason
			</div>
			<div style="width: 10vw; margin-top: 1%; margin-left: 4%; float: left; text-align: left;"><!--태그-->
				#~~~ #~~~ #~~~
			</div>
		</div>
		<div class="container1" style="width: 15.6vw; height: 44vh; border: 3px solid black; margin-bottom: 1%; background-color: white;">
			<div style="margin: 2%; float: right;"><!--추천버튼-->
				<img src="https://user-images.githubusercontent.com/102495751/167248594-2f214c14-5c6d-4156-816d-b796147e5c6c.png" style="width: 1.5vw;" alt="♡">
			</div>
			<div style="margin-left: 4%; float: left; width: 14.3vw;"><!--그룹별추천-->
				<div class="circle" style="background-color: red;">5</div>
				<div class="circle" style="background-color: yellow;">1</div>
				<div class="circle" style="background-color: green;">7</div>
				<div class="circle" style="background-color: orange;">2</div>
				<div style="margin: 4%; margin-top: 0px; float: right;"><!--총추천-->
					<img src="https://user-images.githubusercontent.com/102495751/167248761-2a757747-acd9-42fd-a0c7-62c4d43bab0f.png" style="width: 1.5vw;" alt="(all)">15
				</div>
			</div>
			<div style="margin: 4%; margin-top: 30%; width: 14.2vw; border: 1px solid black; height: 24vh;"><!--카페사진-->
				<img src="https://user-images.githubusercontent.com/102495801/167244811-58e443d6-4921-49d7-9fe9-fbcdac6ec4d0.jpg" alt="이미지" style= "width: 100%; height: 100%;">
			</div>
			<div style="background-color: black; height: 2px; margin: 4%;"></div>
			<div style="margin-left: 4%; float: left;"><!--카페이름-->
				a카페
			</div>
			<div style="margin-right: 4%; float: right;"><!--작성자-->
				by Jason
			</div>
			<div style="width: 10vw; margin-top: 1%; margin-left: 4%; float: left; text-align: left;"><!--태그-->
				#~~~ #~~~ #~~~
			</div>
		</div>
		<div class="container1" style="width: 15.6vw; height: 44vh; border: 3px solid black; float: right; margin-left: 2%; margin-bottom: 1%; background-color: white;">
			<div style="margin: 2%; float: right;"><!--추천버튼-->
				<img src="https://user-images.githubusercontent.com/102495751/167248594-2f214c14-5c6d-4156-816d-b796147e5c6c.png" style="width: 1.5vw;" alt="♡">
			</div>
			<div style="margin-left: 4%; float: left; width: 14.3vw;"><!--그룹별추천-->
				<div class="circle" style="background-color: red;">5</div>
				<div class="circle" style="background-color: yellow;">1</div>
				<div class="circle" style="background-color: green;">7</div>
				<div class="circle" style="background-color: orange;">2</div>
				<div style="margin: 4%; margin-top: 0px; float: right;"><!--총추천-->
					<img src="https://user-images.githubusercontent.com/102495751/167248761-2a757747-acd9-42fd-a0c7-62c4d43bab0f.png" style="width: 1.5vw;" alt="(all)">15
				</div>
			</div>
			<div style="margin: 4%; margin-top: 30%; width: 14.2vw; border: 1px solid black; height: 24vh;"><!--카페사진-->
				<img src="https://user-images.githubusercontent.com/102495801/167244913-196aea78-ddbb-4664-89b2-f2dd0213f556.jpg" alt="이미지" style= "width: 100%; height: 100%;">
			</div>
			<div style="background-color: black; height: 2px; margin: 4%;"></div>
			<div style="margin-left: 4%; float: left;"><!--카페이름-->
				a카페
			</div>
			<div style="margin-right: 4%; float: right;"><!--작성자-->
				by Jason
			</div>
			<div style="width: 10vw; margin-top: 1%; margin-left: 4%; float: left; text-align: left;"><!--태그-->
				#~~~ #~~~ #~~~
			</div>
		</div>
		<div class="container1" style="width: 15.6vw; height: 44vh; border: 3px solid black; margin-bottom: 1%; background-color: white;">
			<div style="margin: 2%; float: right;"><!--추천버튼-->
				<img src="https://user-images.githubusercontent.com/102495751/167248594-2f214c14-5c6d-4156-816d-b796147e5c6c.png" style="width: 1.5vw;" alt="♡">
			</div>
			<div style="margin-left: 4%; float: left; width: 14.3vw;"><!--그룹별추천-->
				<div class="circle" style="background-color: red;">5</div>
				<div class="circle" style="background-color: yellow;">1</div>
				<div class="circle" style="background-color: green;">7</div>
				<div class="circle" style="background-color: orange;">2</div>
				<div style="margin: 4%; margin-top: 0px; float: right;"><!--총추천-->
					<img src="https://user-images.githubusercontent.com/102495751/167248761-2a757747-acd9-42fd-a0c7-62c4d43bab0f.png" style="width: 1.5vw;" alt="(all)">15
				</div>
			</div>
			<div style="margin: 4%; margin-top: 30%; width: 14.2vw; border: 1px solid black; height: 24vh;"><!--카페사진-->
				<img src="https://user-images.githubusercontent.com/102495801/167244893-164ba9bd-a358-4ff1-88ea-0f25f822d44c.jpg" alt="이미지" style= "width: 100%; height: 100%;">
			</div>
			<div style="background-color: black; height: 2px; margin: 4%;"></div>
			<div style="margin-left: 4%; float: left;"><!--카페이름-->
				a카페
			</div>
			<div style="margin-right: 4%; float: right;"><!--작성자-->
				by Jason
			</div>
			<div style="width: 10vw; margin-top: 1%; margin-left: 4%; float: left; text-align: left;"><!--태그-->
				#~~~ #~~~ #~~~
			</div>
		</div>
		<div class="container1" style="width: 15.6vw; height: 44vh; border: 3px solid black; float: right; margin-left: 2%; margin-bottom: 1%; background-color: white;">
			<div style="margin: 2%; float: right;"><!--추천버튼-->
				<img src="https://user-images.githubusercontent.com/102495751/167248594-2f214c14-5c6d-4156-816d-b796147e5c6c.png" style="width: 1.5vw;" alt="♡">
			</div>
			<div style="margin-left: 4%; float: left; width: 14.3vw;"><!--그룹별추천-->
				<div class="circle" style="background-color: red;">5</div>
				<div class="circle" style="background-color: yellow;">1</div>
				<div class="circle" style="background-color: green;">7</div>
				<div class="circle" style="background-color: orange;">2</div>
				<div style="margin: 4%; margin-top: 0px; float: right;"><!--총추천-->
					<img src="https://user-images.githubusercontent.com/102495751/167248761-2a757747-acd9-42fd-a0c7-62c4d43bab0f.png" style="width: 1.5vw;" alt="(all)">15
				</div>
			</div>
			<div style="margin: 4%; margin-top: 30%; width: 14.2vw; border: 1px solid black; height: 24vh;"><!--카페사진-->
				<img src="https://user-images.githubusercontent.com/102495801/167244811-58e443d6-4921-49d7-9fe9-fbcdac6ec4d0.jpg" alt="이미지" style= "width: 100%; height: 100%;">
			</div>
			<div style="background-color: black; height: 2px; margin: 4%;"></div>
			<div style="margin-left: 4%; float: left;"><!--카페이름-->
				a카페
			</div>
			<div style="margin-right: 4%; float: right;"><!--작성자-->
				by Jason
			</div>
			<div style="width: 10vw; margin-top: 1%; margin-left: 4%; float: left; text-align: left;"><!--태그-->
				#~~~ #~~~ #~~~
			</div>
		</div>
	</div>
	<div class="bar" style="width: 5vw;">
		<a href="메인화면">
			<img src="https://user-images.githubusercontent.com/102495801/167056604-ed2c2e9c-426d-455b-84f9-54bb4f82a0c2.png" alt="main_img" style="margin-top: 30%; width: 2vw; margin-left: 30%;">
		</a>
		<a href="카페글쓰기">
			<img src="https://user-images.githubusercontent.com/102495801/167056127-afdaad04-d13b-4a33-a4c0-9c2d8904ead8.png" alt="write_img" style="margin-top: 30%; width: 2vw; margin-left: 30%;">
		</a>
		<a href="사용자마이페이지">
			<img src="https://user-images.githubusercontent.com/102495801/167056576-0a2c3920-d8f8-47b2-bdcb-dd4d2a9cd205.png" alt="mypage_img" style="margin-top: 30%; width: 2vw; margin-left: 30%;">
		</a>
	</div>
</body>
</html>