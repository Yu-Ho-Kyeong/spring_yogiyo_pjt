<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>여기냐? 사장님 사이트</title>
	<meta name="_csrf_header" content="${_csrf.headerName}" />
	<meta name="_csrf" content="${_csrf.token}" />
	<link href="../resources/css/common/mainCss.css" rel="stylesheet" type="text/css" />
	<link rel="apple-touch-icon-precomposed"
		  href="https://www.yogiyo.co.kr/mobile/image/app_128x128.png" />
	<link rel="apple-touch-icon-precomposed" sizes="144x144"
		  href="https://www.yogiyo.co.kr/mobile/image/app_144x144.png" />
	<link rel="icon" type="image/x-icon"
		  href="https://ceo.yogiyo.co.kr/favicon.ico" />
	<script src="https://code.jquery.com/jquery-3.4.1.js"
			integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
			crossorigin="anonymous">
	</script>
</head>
<body>
	<div id="content" class="container fluid">
		<div class="owner-join-wrap">
			<h1 class="d-none">요기요</h1>
			<form class="form-join" method="post">
				<!-- onsubmit="return false" -->
				<div class="join-form">
					<div class="title"></div>
					<ul class="list-group">
						<label>회원정보입력</label>
						<li class="list-group-item">
							<input type="text" id="id-input" name="ownerId" placeholder="아이디 입력(필수)" />
							<span class="id-input-re-1">사용 가능한 ID입니다.</span> 
							<span class="id-input-re-2">이미 사용중인 ID입니다.</span>
						</li>
						<span class= "final-id-ck">id를 입력해주세요.</span>

						<li class="list-group-item">
							<input type="password" id="pwd-input" name="ownerPwd" placeholder="비밀번호 입력(필수)" />							
						</li>
						<span class = "final-pwd-ck">비밀번호를 입력해주세요.</span>

						<li class="list-group-item">
							<input type="password" id="pwdck-input" name="ownerPwd" placeholder="비밀번호 확인(필수)" />
							<span class="pwdck-input-re-1">비밀번호가 일치합니다.</span>
							<span class="pwdck-input-re-2">비밀번호가 일치하지 않습니다.</span> 
						</li>
						<span class= "final-pwdck-ck">비밀번호를 입력해주세요.</span>
						
						<li class="list-group-item">
							<input type="text" id="nic-input" name="ownerName" placeholder="이름 입력(필수)" />
						</li>
						<span class = "final-nic-ck">이름을 입력해주세요.</span>
					</ul>
					
					<ul class="list-group2"> 
						<label>이메일 인증</label>
						<li class="list-group-item2">  
							<input type="text" id="email-input" name="ownerMail" placeholder="이메일 입력(필수)" /> 
							<input type="button" class="btn-auth" value="인증" />
						</li>
						<span class = "final-email-ck">이메일주소를 입력해주세요.</span>
					</ul>
					
					<ul class="list-group3">
						<label>약관동의</label>
						<li class="list-group-item3"> <input type="checkbox" id="allcheck" />
						 <label for="allcheck">
							<span></span>전체동의
						</label> 
						</li>
						
						<br />
						
						<il class="list-group-item3"> <input type="checkbox"id="check01" class="input-text">
						<label for="check01">
							<span></span>이용약관(필수) <a href="" class="chk_a">내용보기></a>
						</label> 
						</il>
						
						<br />
						
						<il class="list-group-item3"> <input type="checkbox" id="check02" class="input-text">
						<label for="check02">
							<span></span>개인정보처리방침(필수) <a href="" class="chk_a">내용보기></a>
						</label>
						</il>
						
						<br />
						
						<il class="list-group-item3"> <input type="checkbox" id="check03" class="input-text">
						<label for="check03">
							<div class="check03_a">
								<span></span>마케팅 수신 동의(선택) <a href="" class="chk_a">내용보기></a>
							</div>
						</label> 
						</il>
					</ul>
					
					<button type="submit" class="btn btn_join">회원가입</button>
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				</div>
			</form>
		</div>
	</div>

	<!-- script -------------------------------------------------------------------------------------------------------------->
	<script>
		var code = ""; // 이메일전송 인증번호 저장을 위한 코드
		/* 유효성 검사 통과유무 변수 */
		var idCheck = false; // id 입력 체크
		var idckCheck = false; // id 중복 체크
		var pwdCheck = false; // pwd 입력 체크
		var pwdckCheck = false; // pwd 일치 체크
		var pwdckcorCheck = false; // pwd 확인 일치 확인
		var nameCheck = false;
		var emailCheck = false; // mail 입력 체크 
// 		var authNoCheck = false; //인증번호 입력 체크
// 		var authNoCorrect = false; // 인증번호 일치여부 
	
		$(document).ready(function() { 
			
			/* $(".btn_join").removeClass("disabled"); */
			
			$("button[type=submit]").click(function() {//회원가입 버튼(회원가입 기능 작동)
				
				var id = $('#id-input').val(); //ownerId 입력란
				var pwd = $('#pwd-input').val(); // ownerPwd 입력란
				var pwdck = $('#pwdck-input').val(); // ownerPwdck 입력란
				var name = $('#nic-input').val(); //ownerName 입력란
				var email = $('#email-input').val(); //ownerMail 입력란
// 				var authNo = $('#auth_check_input_box_false').val(); //인증번호 입력란
				
				 // id 유효성 검사
				if(id == ""){
					$('.final-id-ck').css('display', 'block');
					idCheck = false;
				}else{
					$('.final-id-ck').css('dispaly', 'none');
					idCheck = true;
				}
				// pwd 유효성 검사
				if(pwd == ""){
					$('.final-pwd-ck').css('display', 'block');
					pwdCheck = false;
				}else{
					$('.final-pwd-ck').css('dispaly', 'none');
					pwdCheck = true;
				}
				// pwdcd 유효성 검사
				if(pwdck == ""){
		            $('.final-pwdck-ck').css('display','block');
		            pwdckCheck = false;
		        }else{
		            $('.final-pwdck-ck').css('display', 'none');
		            pwdckCheck = true;
		        }
				// name 유효성 검사
				if(name == ""){
		            $('.final-nic-ck').css('display','block');
		            nameCheck = false;
		        }else{
		            $('.final-nic-ck').css('display', 'none');
		            nameCheck = true;
		        }
				// mail 유효성 검사
				if(email == ""){
					$('.final-email-ck').css('display', 'block');
					emailCheck = false;
				}else{
					$('.final-email-ck').css('dispaly', 'none');
					emailCheck = true;
				}
// 				// 인증번호 유효성 검사
// 				if(authNo == ""){
// 					$('.final-authNo-ck').css('display', 'block');
// 					authNoCheck = false;
// 				}else{
// 					$('.final-authNo-ck').css('dispaly', 'none');
// 					authNoCheck = true;
// 				} 
				
				// 최종 유효성 검사
				if(idCheck&&idckCheck&&pwdCheck&&pwdckCheck&&pwdckcorCheck&&nameCheck&&emailCheck ==  true){
					  
					$(".form-join").attr("action", "/owner/ownerJoin"); 
					$(".form-join").submit();
					alert("가입되었습니다."); 	
						
				} else{
					return false; 
				}   
				 	 
			});
		
		});
		
		//id 중복검사
		$('#id-input').on("propertychange change keyup paste input", function() { // input창에 변화가 감지될때마다 함수 실행
							console.log("keyup test"); 
					var ownerId = $('#id-input').val();
					var data = {ownerId : ownerId} 
					var header = $("meta[name='_csrf_header']").attr("content");
			        var token = $("meta[name='_csrf']").attr("content");

					$.ajax({
						type : "POST" ,
						url : "ownerIdChk" , 
						data : data ,
						beforeSend: function(xhr){
									xhr.setRequestHeader(header, token);
									} ,	// 헤드의 csrf meta태그를 읽어 CSRF 토큰 함께 전송
						success : function(result) {
							console.log("성공 여부" + result);
							if (result == 'success') {
								$('.id-input-re-1').css("display", "inline-block");
								$('.id-input-re-2').css("display", "none");
								idckCheck = true;
							} else { 
								$('.id-input-re-2').css("display", "inline-block");
								$('.id-input-re-1').css("display", "none");
								idckCheck = false;
							}
						}// success 종료

					});// ajax 종료
		});
		// function 종료
		
		// 비밀번호 확인 일치 유효성 검사
		$('#pwdck-input').on("propertychange change keyup paste input", function() { // input창에 변화가 감지될때마다 함수 실행
			/* console.log("keyup test"); */
			var pwd = $('#pwd-input').val();
			var pwdck = $('#pwdck-input').val();
			$('.final_pwdck_ck').css('display', 'none');
		
			if (pwd == pwdck) {
				$('.pwdck-input-re-1').css("display", "inline-block");
				$('.pwdck-input-re-2').css("display", "none");
				pwdckcorCheck = true;
			} else { 
				$('.pwdck-input-re-1').css("display", "none");
				$('.pwdck-input-re-2').css("display", "inline-block");
				pwdckcorCheck = false;
			} // if문 종료
		
		});// function 종료
		
		/* 인증번호 생성 */
		$(".btn-auth").click(function(){
		    var ownerMail = $("#email-input").val(); // 입력한 이메일
		    var authCheckBox = $('.auth_check_input_box'); // 인증번호 입력란
		    var boxColor = $('#auth_check_input_box_false'); // 인증번호 입력란 박스
		    var warning = $('.auth_check_input_box_warn'); // 이메일 경고창
		     
		    if(ownerMail == ""){
				$('.final-email-ck').css("display", "inline-block");
				return false;
		    }else{
		    	$('.final-email-ck').css("display", "none");
		    }
		    
		    $.ajax({
		        type:"GET",
		        url:"mailCheck?ownerMail=" + ownerMail ,
		        success : function(data){
		        	/* console.log("data: " + data); */
		        	authCheckBox.attr("disabled", false);
		        	boxColor.attr("id", "auth_check_input_box_true")
		        	code = data;
		        }
		    });  
		});
		
		//인증번호 비교
		$(".btn-authCk").on("click", function(){
			
			var inputCode = $('.auth_check_input_box').val(); // 사용자가 입력한 인증번호
			var checkResult = $('.auth_check_input_box_warn'); // 비교결과
			
			if(inputCode == code){ //일치할 경우
				checkResult.html("인증번호가 일치합니다.");
				checkResult.attr("class", "correct");
				authNoCorrect = true;
			}else {					// 일치하지 않을 경우
				checkResult.html("인증번호를 다시 확인해주세요.");
				checkResult.attr("class", "incorrect");
				authNoCorrect = false;
			}

		});
		
		// 전체동의 체크박스
		$(document).ready(function() {
			$("#allcheck").click(function(){
				if($("#allcheck").is(":checked")) 
					$(".input-text").prop("checked", true);
				else $(".input-text").prop("checked", false);
			});
			
			$(".input-text").click(function(){
				var total = $(".input-text").length;
				var checked = $(".input-text:checked").length;
				
				if(total != checked) $("#allcheck").prop("checked", false);
				else $("#allcheck").prop("checked", true);
			});
		
		});
		
	</script>
</body>
</html>