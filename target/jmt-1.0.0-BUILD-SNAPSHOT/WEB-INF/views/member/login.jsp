<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
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
<!--memberLogin------------------------------------------------------------------------------------------------------------->
<body id="asp_check" style="margin-top:0px;">
	<div id="content" class="container fluid">
		<div class="login-wrap">
			<h1 class="d-none">요기요</h1>
			<form class="form-login" method="post">
				<div class="login-form">
					<div class="title"></div>
					
			        <div class="btn_login_Sortation">
						<button type="button" class="btn login-Sortation_member" onclick="location.href='/member/login'">	
								<span class="ico-Sortation ico-member"></span> 일반회원 로그인
						</button>
						<button type="button" class="btn login-Sortation_owner" onclick="location.href='../owner/ownerLogin'">
							<span class="inner">
								<span class="ico-Sortation ico-owner"></span> 사장님 로그인
							</span>
						</button>
					</div>
					
					<ul class="list-group">
						<li class="list-group-item">
							<input type="text"id="id-input" name="memberId" placeholder="아이디 입력(필수)" />
						</li>

						<li class="list-group-item">
							<input type="password" id="pwd-input" name="memberPwd" placeholder="비밀번호 입력(필수)" />
						</li>
					</ul>
					
					<c:if test="${LoginFailMessage!=null}">
						<p> Error : <c:out value="${LoginFailMessage}"/> </p>
					</c:if>
					
					<div class="checkbox">
						<input type="checkbox" id="keep-login" name="_spring_security_remember_me" />
						<label for="keep-login">
							 <span></span>자동로그인
						</label> 
							<span class="inquiry"> 
								<a href="/member/findId">아이디 찾기</a> | <a href="/member/findPwd">비밀번호 찾기</a>
							</span>
					</div>

					<span class="txt"> 개인정보보호를 위해 <strong>개인 pc에서 사용</strong>해주세요.
					</span>
				</div>

				<button type="submit" class="btn btn_login" disabled="disabled">로그인</button>
				<input type="hidden" name="${_csrf.parameterName}" value= "${_csrf.token}" />
				<div class="btn_social_login">
					<button type="button" id= "naver_id_login" class="btn btn_join1 naver" onclick="location.href='${url}'">
						<span class="ico-social ico-naver"></span> 네이버로 로그인
					</button>
					<button type="button" class="btn btn_join1 kakao">
						<span class="ico-social ico-kakao"></span> 카카오로 로그인
					</button>
				</div>
				
			</form>
		</div>

		<div class="signupbox">
			<img src="https://www.yogiyo.co.kr/mobile/image/signin_banner.png"
				class="signup-img" alt="요기요 가입하기"
				onclick="window.location.href='/member/join'">
		</div>
	</div>
	
	<!-- 네이버 스크립트 -->
	<script>
	
		$(document).ready(function(){	
			$(".login-Sortation_member").addClass('active');
			
			$("#id-input, #pwd-input").on('input', function(){
				var btnLogin = $('.btn_login');
				var loginBox = $('#id-input');
				var pwdBox = $('#pwd-input');
				
				if(loginBox.val() && pwdBox.val() != ""){ //id 인풋창과 pwd 인풋창에 입력되는 값이 공백이 아니면
					btnLogin.attr("disabled", false); // 로그인 버튼 사용 가능 (disabled를 거짓으로 만듬)
				}else{								 // id와 pwd input창에 입력이 안되었다면
					btnLogin.attr("disabled", true); // 로그인 버튼 사용 불가 (disabled를 그대로)
				}
			});
		});	
		
		$(".btn_login").click(function(){
			//alert("로그인 버튼 작동 "); 
			$(".form-login").attr("action", "/member/login"); // 로그인 메서드 서버 요청
			$(".form-login").submit();
		}); 

	</script>
	
</body>

</html>

