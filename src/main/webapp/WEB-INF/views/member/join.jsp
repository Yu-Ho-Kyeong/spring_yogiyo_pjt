<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>

<html>
<head>
	<meta charset="UTF-8">
	<meta name="_csrf_header" content="${_csrf.headerName}" />
	<meta name="_csrf" content="${_csrf.token}" />
	<title>회원가입</title>
	<link href="../resources/css/common/mainCss.css" rel="stylesheet" type="text/css" />
	<link rel="apple-touch-icon-precomposed"
		  href="https://www.yogiyo.co.kr/mobile/image/app_128x128.png" />
	<link rel="apple-touch-icon-precomposed" sizes="144x144"
		  href="https://www.yogiyo.co.kr/mobile/image/app_144x144.png" />
	<link rel="icon" type="image/x-icon"
		  href="https://www.yogiyo.co.kr/mobile/image/favicon.ico" />
	<script src="https://code.jquery.com/jquery-3.4.1.js"
			integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
			crossorigin="anonymous">
	</script>
</head>

<body id="section" style="margin-top: 0px;">
	<!-- memberJoin ---------------------------------------------------------------------------------------------------------------->
	<div id="content" class="container fluid">
		<div class="join-wrap">
			<h1 class="d-none">요기요</h1>
			<form class="form-join" method="post">
				<!-- onsubmit="return false" -->
				<div class="join-form">
					<div class="title"></div>
					<ul class="list-group">
						<label>회원정보입력</label>
						<li class="list-group-item">
							<input type="text" id="id-input" name="memberId" placeholder="아이디 입력(필수)" />
							<span class="id-input-re-1">사용 가능한 ID입니다.</span> 
							<span class="id-input-re-2">이미 사용중인 ID입니다.</span>
						</li>
						<span class= "final-id-ck">사용하실 id를 입력해주세요.</span>

						<li class="list-group-item">
							<input type="password" id="pwd-input" name="memberPwd" placeholder="비밀번호 입력(필수)" />							
						</li>
						<span class = "final-pwd-ck">비밀번호를 입력해주세요.</span>

						<li class="list-group-item">
							<input type="password" id="pwdck-input" name="memberPwd" placeholder="비밀번호 확인(필수)" />
							<span class="pwdck-input-re-1">비밀번호가 일치합니다.</span>
							<span class="pwdck-input-re-2">비밀번호가 일치하지 않습니다.</span> 
						</li>
						<span class= "final-pwdck-ck">비밀번호를 입력해주세요.</span>
					
						<li class="list-group-item">
							<input type="text" id="nic-input" name="memberName" placeholder="닉네임 입력(필수)" />
							<span class="nickName-input-re-1">사용 가능한 닉네임입니다.</span>
							<span class="nickName-input-re-2">이미 사용중인 닉네임입니다.</span>
						</li>
						<span class = "final-nic-ck">사용하실 닉네임을 입력해주세요.</span>
					</ul>
					
					<ul class= "list-group2">
						<label>주소 입력</label>
						<li class="list-group-item2">
							<input type="text" id="address-input" name="memberAddress" placeholder="동,면,읍" />
							<input type="button" class="btn-address" onclick="execDaumPostcode()" value="검색"/> 
						</li>
						<span class = "final-addr-ck">주소를 입력해주세요.</span>
					</ul>
					
					<ul class= "list-group">
						<label>핸드폰 번호 입력</label>
						<li class="list-group-item">
							<input type="text" id="memberPhoneNo-input" name="memberPhoneNo" placeholder="- 제외하고 입력" />
						</li>
						<span class = "final-phone-ck">핸드폰 번호를 입력해주세요.</span>
					</ul>
						
					<ul class="list-group2"> 
						<label>이메일 인증</label>
						<li class="list-group-item2">  
							<input type="text" id="email-input" name="memberMail" placeholder="이메일 입력(필수)" /> 
							<input type="button" class="btn-auth" value="인증" />
						</li>
						<span class = "final-email-ck">이메일주소를 입력해주세요.</span>

<!-- 						<li class="list-group-item2"> -->
<!-- 							<input type="text" class="auth_check_input_box" id="auth_check_input_box_false" placeholder="인증번호 입력(필수)" disabled="disabled" /> -->
<!-- 							<input type="button" class="btn-authCk" value="확인" /> -->
<!-- 						</li> -->
<!-- 						<span class = "final-authNo-ck">인증번호를 입력해주세요.</span> -->
<!-- 						<sapn class="auth_check_input_box_warn"></sapn> -->
<!-- 						<div class="m-msg">인증번호가 도착하지 않았을 경우 "인증"버튼을 다시 눌러주세요.</div> -->
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
	<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
		var code = ""; // 이메일전송 인증번호 저장을 위한 코드
		/* 유효성 검사 통과유무 변수 */
		var idCheck = false; // 이메일 체크
		var idckCheck = false; // 이메일 중복 검사
		var pwdCheck = false; // 비번 체크
		var pwdckCheck = false; // 비번 확인 체크
		var pwdckcorCheck = false; // 비번 확인 일치 확인
		var nicCheck = false; //닉네임 체크
		var nicckCheck = false; //닉네임 중복검사
		var emailCheck = false; // 이메일 주소 체크 
// 		var authNoCheck = false; //인증번호 체크
// 		var authNoCorrect = false; // 인증번호 틀림 
		var addressCheck = false; // 주소 공백 체크
		var phoneCheck = false; // 핸드폰번호 공백 체크


		$(document).ready(function() { 
			$(".btn_join").click(function() { //회원가입 버튼(회원가입 기능 작동)
				
				var id = $('#id-input').val(); //email 입력란
				var pwd = $('#pwd-input').val(); // pwd 입력란
				var pwdck = $('#pwdck-input').val(); // pwdck 입력란
				var nickName = $('#nic-input').val(); //nickName 입력란
				var email = $('#email-input').val(); //email 입력란
// 				var authNo = $('#auth_check_input_box_false').val(); //인증번호 입력란 
				var address = $('#address-input').val(); //주소 입력창 
				var phone = $('#memberPhoneNo-input').val(); //핸드폰 번호 입력창 
				
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
				 // nick 유효성 검사
				if(nickName == ""){
					$('.final-nic-ck').css('display', 'block');
					nicCheck = false;
				}else{
					$('.final-nic-ck').css('dispaly', 'none');
					nicCheck = true;
				} 
				 // address 유효성 검사
				if(address == ""){
					$('.final-addr-ck').css('display', 'block');
					nicCheck = false;
				}else{
					$('.final-addr-ck').css('dispaly', 'none');
					nicCheck = true;
				} 
				// email 유효성 검사
				if(email == ""){
					$('.final-email-ck').css('display', 'block');
					emailCheck = false;
				}else{
					$('.final-email-ck').css('dispaly', 'none');
					emailCheck = true;
				} 
				// 인증번호 유효성 검사
// 				if(authNo == ""){
// 					$('.final-authNo-ck').css('display', 'block');
// 					authNoCheck = false;
// 				}else{
// 					$('.final-authNo-ck').css('dispaly', 'none');
// 					authNoCheck = true;
// 				} 
				// 인증번호 유효성 검사
				if(phone == ""){
					$('.final-phone-ck').css('display', 'block');
					phoneCheck = false;
				}else{
					$('.final-phone-ck').css('dispaly', 'none');
					phoneCheck = true;
				} 
				
				// 최종 유효성 검사
				  if(idCheck&&idckCheck&&pwdCheck&&pwdckCheck&&pwdckcorCheck&&nicCheck&&nicckCheck&&emailCheck&&phoneCheck ==  true){
					  
					    $(".form-join").attr("action", "/member/join"); 
						$(".form-join").submit();
						alert("가입되었습니다."); 	
						
				 } else{
					 return false; 
				 }   
		        
			});
		
		});
		
		
		//id 중복검사
		$('#id-input').on("propertychange change keyup paste input", function() { // input창에 변화가 감지될때마다 함수 실행
			var memberId = $('#id-input').val();
			var data = {memberId : memberId}
			var header = $("meta[name='_csrf_header']").attr("content");
		    var token = $("meta[name='_csrf']").attr("content");

			$.ajax({
				type : "POST" ,
				url : "memberIdChk" , 
				data : data ,
				beforeSend: function(xhr){
							xhr.setRequestHeader(header, token);
							} ,	// 헤드의 csrf meta태그를 읽어 CSRF 토큰 함께 전송
				success : function(result) {
					console.log("성공 여부" + result);
					if (result == "success") {
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
		});// function 종료
		
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
					$('.pwdck-input-re-2').css("display", "inline-block");
					$('.pwdck-input-re-1').css("display", "none");
					pwdckcorCheck = false;
				} // if문 종료
			
		});// function 종료
		
		
		//memberName 중복검사
		$('#nic-input').on("propertychange change keyup paste input", function() { // input창에 변화가 감지될때마다 함수 실행
			/* console.log("keyup test"); */
			var memberName = $('#nic-input').val();
			var data = {memberName : memberName}
			var header = $("meta[name='_csrf_header']").attr("content");
		    var token = $("meta[name='_csrf']").attr("content");

			$.ajax({
				type : "POST" ,
				url : "memberNicChk" ,
				data : data ,
				beforeSend: function(xhr){
							xhr.setRequestHeader(header, token);
							} ,	// 헤드의 csrf meta태그를 읽어 CSRF 토큰 함께 전송
				success : function(result) {
					console.log("성공 여부" + result);
					if (result == "success") {
						$('.nickName-input-re-1').css("display", "inline-block");
						$('.nickName-input-re-2').css("display", "none");
						nicckCheck = true;
					} else { 
						$('.nickName-input-re-2').css("display", "inline-block");
						$('.nickName-input-re-1').css("display", "none");
						nicckCheck = false;
					}
						
				}// success 종료

			});// ajax 종료

		});// function 종료
		
		/* 인증번호 이메일 전송 */
		$(".btn-auth").click(function(){
			   var memberMail = $("#email-input").val(); // 입력한 이메일
			   var authCheckBox = $('.auth_check_input_box'); // 인증번호 입력란
			   var boxColor = $('#auth_check_input_box_false'); // 인증번호 입력란 박스
			   var warning = $('.auth_check_input_box_warn'); // 이메일 경고창
						     
			    if(memberMail == ""){
					$('.final-email-ck').css("display", "inline-block");
					return false;
			    }else{
			    	$('.final-email-ck').css("display", "none");
			    }
			    
			    $.ajax({
			        type:"GET",
			        url:"mailCheck?memberMail=" + memberMail ,    
			        success : function(data){
			        	console.log("data: " + data);
			        	authCheckBox.attr("disabled", false);
			        	boxColor.attr("id", "auth_check_input_box_true")
			        	code = data;
			        }
			    });  
			});
			
			
			$(".btn-authCk").click(function(){
				
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
			
			function execDaumPostcode() {
		        new daum.Postcode({
		            oncomplete: function(data) {
		                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
		
		                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
		                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
		                var addr = ''; // 주소 변수
		                var extraAddr = ''; // 참고항목 변수
		
		                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
		                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
		                    addr = data.roadAddress;
		                } else { // 사용자가 지번 주소를 선택했을 경우(J)
		                    addr = data.jibunAddress;
		                }
		
		                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
		                if(data.userSelectedType === 'R'){
		                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
		                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
		                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
		                        extraAddr += data.bname;
		                    }
		                    // 건물명이 있고, 공동주택일 경우 추가한다.
		                    if(data.buildingName !== '' && data.apartment === 'Y'){
		                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
		                    }
		                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
		                    if(extraAddr !== ''){
		                        extraAddr = ' (' + extraAddr + ')';
		                    }
		                 	// 주소변수 문자열과 참고항목 문자열 합치기
		                    addr += extraAddr;
		                
		                } else {
		                	addr += ' ';
		                }
		
		                // 우편번호와 주소 정보를 해당 필드에 넣는다.
		                /* document.getElementById('search_input').value = data.zonecode; */
		                $("#address-input").val(addr);
		                /* document.getElementById("search_input").value = addr; */
		                // 커서를 상세주소 필드로 이동한다.
		                /* document.getElementById("sample6_detailAddress").focus(); */
		            }
		        }).open();
		    }

	</script>
</body>
</html>
