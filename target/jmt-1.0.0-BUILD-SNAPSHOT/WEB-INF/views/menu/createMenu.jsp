<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<link href="../resources/css/common/mainCss.css" rel="stylesheet" type="text/css" />
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<title>메뉴 등록</title>
</head>
<style>
	#menuPrice{
		width: 150px;
	}
	
	.btn_cancle, .btn_join{
	width: 49.5%;
	height: 40px;
	}
	.btn_join{
		margin-top: -4px;	
	}
</style>

<body>
<!-- create menu ---------------------------------------------------------------------------------------------------------------->
	<div id="content" class="container fluid">
		<div class="join-wrap">
			<h1 class="d-none">요기요</h1>
			<form class="form-join" method="post" action="/menu/createMenu" enctype="multipart/form-data">
				<div class="join-form">
					<div class="title"></div>
					<ul class="list-group">
						<label>메뉴 이미지</label>
						<li class="list-group-item">
							<input type="file" name="file" id="menuUrl">
						</li>
						 <br> 
						<label>메뉴 이름</label>
						<li class="list-group-item">
							<input type="text" id="menuName" name="menuName" placeholder="메뉴이름 입력(필수)" />
							<span id="msg_name"></span>							
						</li>
 						<br>
 						<label>메뉴 정보</label>
						<li class="list-group-item5">
							<textarea name="menuInfo" id="menuInfo" rows="5" cols="40"></textarea>
							<span id="msg_Info"></span>	
						</li>
						<br>
						<label>메뉴 가격</label>
						<li class="list-group-item">
							<input type="text" id="menuPrice" name="menuPrice" placeholder="메뉴가격 입력(필수)" />원
							<span id="msg_price"></span>	
						</li>
						
						<li>
							<input type="hidden" id="storeNo" name="storeNo" />
							<input type="hidden" id="ownerId" name="ownerId" />
						</li>
					</ul>
					
					
					<button type="button" class="btn btn_join">메뉴등록</button>
					<button type="button" class="btn btn_cancle" onclick="location.href='/owner/ownerMyStoreList'">취소</button>
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				</div>
			</form>
		</div>
	</div>
	
	<!-- script -------------------------------------------------------------------------------------------------------------->
	<script>
		// todo var 쓰면안되는이유 ES6에 대해서 공부
		// Jquery - 무거움 - 쓰지않는것 권장
		$(function(){
			var storeNo = ${param['storeNo']};
				console.log(storeNo);
			
			$(document).ready(function(){
				$("#storeNo").val(storeNo);
			});
			
			// 메뉴이름 공백 체크
			function checkName() {
					var name = $("#menuName").val();
					if(name.length==0) {
						$("#msg_name").text("필수입력입니다").css("color", "red").css("font-size", "0.75em");
						return false;
					} else {
						$("#msg_name").text("ok").css("color", "green").css("font-size", "0.75em");
						return true;
					}	
			}
			// 메뉴가격 공백 체크
			function checkPrice(){
				var price = $("#menuPrice").val();
				if(price.length==0){
					$("#msg_price").text("필수입력입니다").css("color","red").css("font-size", "0.75em");
					return false;
				}
				else {
					$("#msg_price").text("ok").css("color", "green").css("font-size", "0.75em");
					return true;
				}
			}
			// 메뉴정보 공백 체크
			function checkInfo(){
				var info = $("#menuInfo").val();
				if(info.length==0){
					$("#msg_info").text("필수입력입니다").css("color","red").css("font-size", "0.75em");
					return false;
				}
				else {
					
					return true;
				}
			}

			$("#menuName").on("blur", function() {
				checkName();
			})

			$("#menuPrice").on("blur", function() {
				checkPrice();
			})
			$("#menuInfo").on("blur", function() {
				checkInfo();
			})
			
			$(".btn_join").on("click", function() { //메뉴등록 버튼
				var token = "${_csrf.token}"
				var header = "${_csrf.headerName}"
				var form = $('.form-join')[0]
				var formData = new FormData(form)
				
					for(let key of formData.keys()) {
						console.log(key + ' : ' + formData.get(key) );
					}
					
					$.ajax({
						type: 'POST',
						url: '/menu/createMenu',
						data: formData,
						processData: false,
						contentType: false,
						success: function( data ) {
							alert(data);
							location.href="/owner/ownerMyStoreList";
						},
						error: function(xhr, status, error) {
							console.log("status : " + xhr.status);
							console.log("response : " + xhr.responseText);
							console.log("status : " + status);
							console.log("error : " + error);
							alert('회원님의 가게가 아닙니다.');
						}
					})
	
			});
		});
 	
	</script>
</body>
</html>