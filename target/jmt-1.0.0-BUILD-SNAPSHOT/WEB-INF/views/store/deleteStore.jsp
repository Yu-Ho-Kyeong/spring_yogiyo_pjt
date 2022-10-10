<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
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
			<form class="form-login" method="post" action="/owner/ownerMyStoreList">
				<div class="login-form">
					
					<h1>회원정보확인</h1>
					<p><strong></strong>님의 정보를 안전하게 보호하기 위해 비밀번호를 다시 한번 확인 합니다.</p>	
					
					<ul class="list-group">
						<li class="list-group-item">
							<label>가게명</label>
							<span id="storeName"/>${myStore.storeName}</sapn>
						</li>
						<li class="list-group-item">
							<label>아이디</label>
							<input type="text"id="ownerId" name="ownerId" />
						</li>

						<li class="list-group-item">
						<label>비밀번호</label>
							<input type="password" id="ownerPwd" name="ownerPwd" placeholder="비밀번호를 입력해주세요" />
							<span class = "final-pwd-ck">비밀번호를 입력해주세요.</span>
						</li>
						<c:if test="${msg!=null}">
							<p> Error : <c:out value="${msg}"/> </p>
						</c:if>
					</ul>
				</div>

				<button type="button" class="btn btn_login">확인</button>
				<input type="hidden" name="storeNo" value= "${myStore.storeNo}" />
				<input type="hidden" name="${_csrf.parameterName}" value= "${_csrf.token}" />
			</form>
		</div>
	</div>
	
<!-- script -------------------------------------------------------------------------------------------------->
	<script>
	
		/* 유효성 검사 통과유무 변수 */
		var pwdCheck = false;	
		
		$(document).ready(function(){
			
			function printOwner(owner){
				$("#ownerId").val(owner.ownerId);
				$("strong").text(owner.ownerId);
			}
			
			$(function(){
				var owner = JSON.parse('${owner}')
				printOwner(owner);
				
			})
			
			$(".btn_login").click(function() { //확인 버튼
				var pwd = $('#ownerPwd').val(); // pwd 입력란
				var result = confirm("정말 가게를 삭제하시겠습니까?");
				var form = $(".form-login");
				console.log(form);
				
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
					
					var form = $(".form-login").serialize();
					var token = "${_csrf.token}"
					var header = "${_csrf.headerName}"
					console.log(form);
					
					$.ajax({
						type: "post",
						url: "/store/deleteStore",
						data : form,
						beforeSend: function(xhr) {   		/*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
							xhr.setRequestHeader(header, token);
						},
						success: function(data) {
							console.log('data', data);
							location.href="/owner/ownerMyStoreList";
							alert("가게를 삭제했습니다.")
						}, error: function(xhr, status, error) {
							console.log("status : " + xhr.status)
							console.log("response : " + xhr.responseText)
							console.log("status : " + status)
							console.log("error : " + error)
						}
					});
// 					form.attr("action", "/store/deleteStore");
// 					form.submit();
					
				}
			});
			
		});	

	</script>
</body>
</html>