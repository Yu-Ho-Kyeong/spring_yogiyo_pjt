<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>사장님 회원 로그인</title>
	<link href="../resources/css/common/mainCss.css" rel="stylesheet" type="text/css" />
	<link rel="apple-touch-icon-precomposed" href="https://www.yogiyo.co.kr/mobile/image/app_128x128.png" />
	<link rel="apple-touch-icon-precomposed" sizes="144x144" href="https://www.yogiyo.co.kr/mobile/image/app_144x144.png" />
	<link rel="icon" type="image/x-icon" href="https://ceo.yogiyo.co.kr/favicon.ico" />
	<meta name="naver-site-verification" content="4cdda9d96d7ffd83e486b2bf7d2d63e5ea479f3b" />
	<meta name="google-site-verification" content="sjuYAwgH5hN_We8OTVoWve7cwBlU5yvn6sADTbxCmsU" />
	<script src="https://code.jquery.com/jquery-3.4.1.js"
			integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
			crossorigin="anonymous">
	</script>
	<style>
	input::placeholder {
		font-size: 15px;
		color: #808080;		
	}
	</style>
</head>
<!--ownerLogin------------------------------------------------------------------------------------------------------------->
<body id="asp_check" style="margin-top:0px;">
	<div id="content" class="container fluid">
		<div class="login-wrap">
			<h1 class="d-none">요기요</h1>
			<form class="form-login" method="post">
				<div class="login-form">
					<div class="owner-title"></div>
					
			        <div class="btn_login_Sortation">
						<button type="button" class="btn login-Sortation_member" onclick="location.href='../member/login'">	
								<span class="ico-Sortation ico-member"></span> 일반회원 로그인
						</button>
						<button type="button" class="btn login-Sortation_owner" onclick="location.href='/owner/ownerLogin'">
							<span class="inner">
								<span class="ico-Sortation ico-owner"></span> 사장님 로그인
							</span>
						</button>
					</div>
					
					<ul class="list-group">
						<li class="list-group-item">
							<input type="text"id="id-input" name="ownerId" placeholder="아이디 입력(필수)" />
						</li>

						<li class="list-group-item">
							<input type="password" id="pwd-input" name="ownerPwd" placeholder="비밀번호 입력(필수)" />
						</li>
					</ul>
					
					<c:if test="${LoginFailMessage!=null}">
						<p> Error : <c:out value="${LoginFailMessage}"/> </p>
					</c:if>
					<c:if test="${msg!=null}">
						<p> Error : <c:out value="${msg}"/> </p>
					</c:if>
					
					<div class="checkbox">
						<input type="checkbox" id="keep-login" name="_spring_security_remember_me" />
						<label for="keep-login">
							 <span></span>자동로그인
						</label> 
							<span class="inquiry"> 
								<a href="">아이디 찾기</a> | <a href="">비밀번호 찾기</a>
							</span>
					</div>

					<span class="txt"> 개인정보보호를 위해 <strong>개인 pc에서 사용</strong>해주세요.
					</span>
				</div>

				<!-- 
                <div class="login-status">
                    <span>
                        <strong></strong>
                        <br>
                        님으로 로그인되어 있습니다.
                    </span>
                </div> 
                -->
				<button type="submit" class="btn btn_login" disabled="disabled">로그인</button>
				<input type="hidden" name="${_csrf.parameterName}" value= "${_csrf.token}" />
			</form>
		</div>
	</div>
	
	<!-- 네이버 스크립트 -->
	<script>
	
		$(document).ready(function(){	
			$(".login-Sortation_owner").addClass('active');
			
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
				$(".form-login").attr("action", "/owner/ownerLogin"); // 로그인 메서드 서버 요청
				$(".form-login").submit();
			}); 

	</script>
	
</body>
</html>