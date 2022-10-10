<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="_csrf_header" content="${_csrf.headerName}" />
	<meta name="_csrf" content="${_csrf.token}" />
	<title>회원 탈퇴</title>
	<link href="../resources/css/common/mainCss.css" rel="stylesheet" type="text/css" />
	<script src="https://code.jquery.com/jquery-3.4.1.js"
			integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
			crossorigin="anonymous">
	</script>
</head>
<!--ownerDelete------------------------------------------------------------------------------------------------------------->
<body id="asp_check" style="margin-top:0px;">
	<div id="content" class="container fluid">
		<div class="login-wrap">
			<h1 class="d-none">요기요</h1>
			<form class="form-login" method="post">
				<div class="login-form">
					
					<h1>회원정보확인</h1>
					<p><strong>${owner.ownerId}</strong>님의 정보를 안전하게 보호하기 위해 비밀번호를 다시 한번 확인 합니다.</p>	
					
					<ul class="list-group">
						<li class="list-group-item">
							<label>아이디</label>
							<input type="text"id="id-input" name="ownerId" placeholder="${owner.ownerId}" />
						</li>

						<li class="list-group-item">
						<label>비밀번호</label>
							<input type="password" id="pwd-input" name="ownerPwd" placeholder="비밀번호를 입력해주세요" />
							<span class = "final-pwd-ck">비밀번호를 입력해주세요.</span>
						</li>
						<c:if test="${msg!=null}">
							<p> Error : <c:out value="${msg}"/> </p>
						</c:if>
					</ul>
				</div>

				<button type="button" class="btn btn_login">확인</button>
				<input type="hidden" name="${_csrf.parameterName}" value= "${_csrf.token}" />
			</form>
		</div>
	</div>
	
<!-- script -------------------------------------------------------------------------------------------------->
	<script>
	
		/* 유효성 검사 통과유무 변수 */
		var pwdCheck = false;	
		
		$(document).ready(function(){
			$(".btn_login").click(function() { //확인 버튼
				var pwd = $('#pwd-input').val(); // pwd 입력란
				var result = confirm("정말 탈퇴하시겠습니까?");
				
				if( !result )
					return
	
				// pwd 유효성 검사
				if(pwd == ""){
					$('.final-pwd-ck').css('display', 'block');
					pwd.focus();
					pwdCheck = false;
				}else{
					$('.final-pwd-ck').css('dispaly', 'none');
					pwdCheck = true;
				}
				
				if(pwdCheck == true){
					$(".form-login").attr("action", "/owner/ownerDelete");
					$(".form-login").submit();
				}
			});
			
		});	
			
			
	
	</script>
</body>
</html>