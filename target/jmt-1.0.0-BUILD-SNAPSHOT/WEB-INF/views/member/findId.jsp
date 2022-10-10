<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="_csrf_header" content="${_csrf.headerName}" />
	<meta name="_csrf" content="${_csrf.token}" />
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>일반회원 로그인</title>
	<link rel="apple-touch-icon-precomposed" href="https://www.yogiyo.co.kr/mobile/image/app_128x128.png" />
	<link rel="apple-touch-icon-precomposed" sizes="144x144" href="https://www.yogiyo.co.kr/mobile/image/app_144x144.png" />
	<link rel="icon" type="image/x-icon" href="https://www.yogiyo.co.kr/mobile/image/favicon.ico" />
	<link href="../resources/css/common/mainCss.css" rel="stylesheet" type="text/css" />
	<script src="https://code.jquery.com/jquery-3.4.1.js"
			integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
			crossorigin="anonymous">
	</script>
</head>

<!--member_findAccount------------------------------------------------------------------------------------------------------------->
<body id="asp_check" style="margin-top:0px;">
	<div id="content" class="container fluid">
		<div class="join-wrap">
			<h1 class="d-none">요기요</h1>
			<form class="form-join" action="/member/findId" method="post">
				<!-- onsubmit="return false" -->
				<div class="join-form">
					<div class="title"></div>
					<ul class="list-group">
						<label>닉네임 입력</label>
						<li class="list-group-item">
							<input type="text" id="nic-input" name="memberName" placeholder="닉네임을 입력해주세요" />
						</li>
						<span class = "final-nic-ck">닉네임을 입력해주세요.</span>
					</ul>
					
					<ul class="list-group2"> 
						<label>이메일 입력</label>
						<li class="list-group-item2">  
							<input type="text" id="mail-input" name="memberMail" placeholder="이메일을 입력해주세요" /> 
						</li>
						<span class = "final-email-ck">이메일주소를 입력해주세요.</span>

					</ul>
					 
					<button type="submit" class="btn btn_join">아이디 찾기</button>
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				</div>

			</form>
		</div>
	</div>
<!-- script -------------------------------------------------------------------------------------------------------------->
	
	<script>
	
		/* 유효성 검사 통과유무 변수 */
		var nameCheck = false; // 닉네임 입력 체크
		var mailCheck = false; // 이메일 입력 체크 
		
		
		$(document).ready(function() { 
			$(".btn_join").click(function() { // id 찾기 버튼
				
				var name = $('#nic-input').val(); // memberName 입력란
				var mail = $('#mail-input').val(); // email 입력란
				
				// name 유효성 검사
				if(name == ""){
					$('.final-nic-ck').css('display', 'block');
					nameCheck = false;
				}else{
					$('.final-nic-ck').css('dispaly', 'none');
					nameCheck = true;
				}
				
				// mail 유효성 검사
				if(mail == ""){
					$('.final-email-ck').css('display', 'block');
					mailCheck = false;
				}else {
					$('.final-email-ck').css('dispaly', 'none');
					mailCheck = true;
				}
				
				// 최종 유효성 검사
				if(nameCheck && mailCheck ==  true){ 
					$(".form-join").submit();
					
					
	
				}else {
					return false; 
				}   
			});
			
		});
		
		var msg = "${msg}";
			 
			if (msg != "") {
				alert(msg);
			}
		
		
	</script>

</body>
</html>