<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>

<html>
<head>

	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link rel="apple-touch-icon-precomposed"
		  href="https://www.yogiyo.co.kr/mobile/image/app_128x128.png" />
	<link rel="apple-touch-icon-precomposed" sizes="144x144"
		  href="https://www.yogiyo.co.kr/mobile/image/app_144x144.png" />
	<link rel="icon" type="image/x-icon"
		  href="https://www.yogiyo.co.kr/mobile/image/favicon.ico" />
	<link href="../resources/css/common/mainCss.css" rel="stylesheet"
		  type="text/css" />
	<script src="https://code.jquery.com/jquery-3.4.1.js"
			integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
			crossorigin="anonymous">
	</script>
	
</head>

<body id="asp_check" style="margin-top: 0px;">
	<!--logout------------------------------------------------------------------------------------------------------------>
	<div id="content" class="container fluid">
		<div class="login-wrap">
			<form class="form-login">
				<div class="login-form">
					<div class="title2"></div>
					<div class="login-status">
						<span> 
							<strong>								
								<sec:authentication property= "principal.username" />
							</strong> 
							<br> 
							님으로 로그인되어 있습니다.
						</span>
					</div>

					<button type="submit" class="btn btn_logout">로그아웃</button>
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				</div>
			</form>
		</div>

	<!--script--------------------------------------------------------------------------------------------------------------->
	<script>
	
		$(".btn_logout").click(function(){
			//alert("로그아웃 버튼 작동 "); 
			$(".form-login").attr("action", "/owner/logoutAsk"); // 로그인 메서드 서버 요청
			$(".form-login").submit();
		});
	</script>
	<!--script--------------------------------------------------------------------------------------------------------------->
</body>
</html>