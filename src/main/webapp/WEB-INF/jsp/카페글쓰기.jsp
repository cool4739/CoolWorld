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
      .zone_hashtags {
            width: 100%;
            list-style-type: none;
         padding-left: 0%;
        }
        .zone_hashtags li {
            margin: 0.2em;
        }
        .zone_hashtags textarea {
            width: 32.5vw;
            height: 30vh;
         margin-top: 2%;

        }
        .zone_hashtags button {
            border-radius: 0.2em;
            background-color: orange;
            border: 0;
            padding: 0.2em 0.8em;
            color: #fff;
            float: right;
        }
        .zone_hashtags li::after {
            display: block;
            content: '';
            clear: right;
        }
        .hashtag {
            display: inline-block;
            border-radius: 0.2em;
            border: 1px solid #0969da;
            background-color: #ddf4ff;

        }
        #ta_r {
            border: 1px solid gray;
            color: gray;
            padding: 0.5em;
         width: 32.5vw;
        }
   </style>
   <script>
        $.ajaxSetup({
            dataType : "json",
                contentType: 'application/json; charset=utf-8',
        		success:function(result){
        		    alert(result);
        	    },
        		error: function (jqXHR) {
                    alert("jqXHR status code:"+jqXHR.status+" message:"+jqXHR.responseText);
            }
        });//ajaxSetup
        function extract_hashtags() {
            var content_from = document.getElementById('ta_w');
            var hashtag_to = document.getElementById('ta_r');

            var hashtag = [];
            content_from.value.replace(/#[^#\s]+/g, function () {
                hashtag.push(arguments[0]);
            });

            hashtag_edit = hashtag.map((v) => { return '<span class="hashtag">' + v + '</span>'; });
            hashtag_html = hashtag_edit.join(' ');

            if (hashtag_html == '') {
                hashtag_to.innerHTML = '자동태그';
            } else {
                hashtag_to.innerHTML = hashtag_html;
            }
        }
        $(document).ready(function(){
            $("#userInfo").submit(function(event) {
                if (checkValue() == false) {
                    alert('입력해');
                    return false;
                } else {
                    event.preventDefault();
                    const data = {
                         id: $('#user_id').val(),
                         pw: $('#user_pw').val(),
                         nick: $('#user_nick').val(),
                         email: $('#user_email').val(),
                         com: $('#user_com').val(),
                         sex: $('#user_sex').val(),
                     };
                     $.ajax({
                         type: "POST",
                         url: "/user",
                         data:JSON.stringify(data)
                     }).done(function(){ // done - success 와 동일
                         alert('성공');
                         location.href='설문조사';
                     }).fail(function (error) {
                         alert(JSON.stringify(error));
                     });
                }
            });
        });
        </script>
</head>
<body>
   <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
   <h1 style="text-align: center; margin-top: 1%; font-family:BernhardFashion BT; font-weight: bold; font-size: 2.4rem;">Cafe_in</h1>
   <div class="container1" style="position: absolute; border-bottom: 1px solid black; left: 25%; top: 10%; background-color: #EAEAEA; border: 3px solid #A0A0A0; border-radius: 20px;">
      <img src="https://icon-icons.com/icons2/510/PNG/128/coffee_icon-icons.com_50414.png" style="float: left; width: 7vw;" alt="이미지">
   </div>
   <div class="bar" style="width: 5vw;">
      <a href="메인화면.html">
         <img src="https://user-images.githubusercontent.com/102495801/167056604-ed2c2e9c-426d-455b-84f9-54bb4f82a0c2.png" alt="main_img" style="margin-top: 30%; width: 2vw; margin-left: 30%;">
      </a>
      <a href="카페글쓰기.html">
         <img src="https://user-images.githubusercontent.com/102495801/167056127-afdaad04-d13b-4a33-a4c0-9c2d8904ead8.png" alt="write_img" style="margin-top: 30%; width: 2vw; margin-left: 30%;">
      </a>
      <a href="마이페이지 사용자.html">
         <img src="https://user-images.githubusercontent.com/102495801/167056576-0a2c3920-d8f8-47b2-bdcb-dd4d2a9cd205.png" alt="mypage_img" style="margin-top: 30%; width: 2vw; margin-left: 30%;">
      </a>
   </div>
   <div class="container1" style="position: absolute; left: 35%; top: 10%; padding: 1%; width: 35vw; border: 3px solid #A0A0A0; border-radius: 20px;">
      <form name="" action="" method="get"><!--form태그를 넣어봤는데 추후에 서버에 실적용이 되는지 모르겠다-->
         <div style="border-bottom: 2px solid black; height: 6vh;">
            <h2>카페 글쓰기</h2>
         </div>
         <textarea placeholder="카페이름" style="resize: none; width: 32.5vw; height: 3.5vh; margin-top: 2%;"></textarea>
         <ul class="zone_hashtags">
            <li><textarea id="ta_w" placeholder="홍보내용"></textarea></li>
            <div style="float: left; margin-top: 2%;">파일첨부</div>
            <div class="col-auto" style="float: right;">
               <button type="button" onclick="extract_hashtags()">변환</button>
               <!--홍보내용만 submit할수있는 방법이 없을까..?-->
            </div>

            <div class="container1" style="width: 32.5vw; padding: 2%;">
               <div style="width: 8vw; border: 1px solid black; height: 16.5vh; float:left;"><!--카페사진-->
                  <img src="" alt="이미지">
               </div>
               <div style="margin-left: 2%; width: 8vw; border: 1px solid black; height: 16.5vh; float:left;">
                  <img src="" alt="이미지">
               </div>
               <input type="file" accept="image/*," multiple required style="float: left; margin-top: 2%;"/>
            </div>
            <textarea placeholder="태그입력" style="resize: none; width: 32.5vw; height: 3.5vh; margin-top: 2%;"></textarea>
            <div id="ta_r" style="text-align:left;">자동태그</div>
            <li><button type="button" onclick="location.href='메인화면.html'">완료</button></li>
         </ul>
      </form>
   </div>
</body>
</html>