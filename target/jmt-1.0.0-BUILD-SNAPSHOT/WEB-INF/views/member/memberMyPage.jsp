<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>

<html>
<head>
	<meta charset="UTF-8">
	<title>myPage</title>
	<link href="../resources/css/common/mainCss.css" rel="stylesheet" type="text/css" />
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/js/toastr.min.js"></script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/css/toastr.min.css">
  	
	<style>
		.my-page{
			position: relative;
			text-align: center;
			color: #fff;
			font-weight: bold;
			margin-bottom: 2px;
			width: 600px;
			height: 37px;
			background-color: #fa0050;
		}
		.displayCanvas{
			max-width: 600px;
		}
		.myPage{
			display: table-row-group;
		    vertical-align: middle;
		    border-color: inherit;
		}
		.table-hover{
			display: flex;
			flex-direction: column;
			width: 100%;
			position: relative;
			margin-top: 20px;
			margin-bottom: 20px;
			height: auto;
		}	
		.first {
			position: relative;
			background-color: #fa0050;
			text-align: center;
			color: #fff;
			font-weight: bold;
			width: 100px;
			max-height: auto;
		}
		.output{
			position: relative;
			width: 498px;
		}
		/* 닉네임 변경 버튼 */
		#changeName {
			position: relative;
			width: 100px;
			background-color: #ff8a00;
		}
		/* 비밀번호 변경 버튼 */
		#activateChangePwd {
			position: relative;
			width: 120px;
			background-color: #ff8a00;
		}
		/* 주소 변경 버튼 */
		#updateAddress{
			position: relative;
			background-color: #ff8a00;
			color: white;
			width: 110px;	
		}
		/* 비밀번호 변경 area */
		#pwdArea {
			width: 200px;
			display: none;
		}
		/* 비밀번호 변경 버튼 */
		#changePwd {
			position: relative;
			background-color: #ff8a00;
			width: 80px;
			margin-top: 7px;
		}
		/* pwd input */
		#memberPwd2{
			width: 200px;
		}
		/* mail input */
		#memberMail1 {
			width: 120px;
			border: 1px solid #ddd;
		}
		#memberMail2 {
			width: 200px;
			border: 1px solid #ddd;
		} 
		/* name input */
		#memberName {
			width: 200px;
			border: 1px solid #c0c0c0;
		}
		/* address input */
		#memberAddress {
			width: 350px;
			border: 1px solid #c0c0c0;
		}
		/* 회원정보 변경 버튼 */
		#update { 
			position: relative;
			margin-top: -20px;
			mrgin-bottom: 20px;
			margin-left: 3px;
			width: 49%;
			font-weight: bold;
			background-color: #fa0050;
		}
		#delete{
			position: relative;
			margin-top: -20px;
			mrgin-bottom: 20px;
			width: 49%;
			font-weight: bold;
			background-color: #ff8a00; 
			color: #fff;
		}
		.member_container {
			display: flex;
			justify-content: center;
/* 			align-items: center; */
		}
		.member_navi_wrap{
			margin-right: 30px;
			margin-top: 22px;
		}
		.member_navi_wrap ul{
			
			
		}
		.member_navi_wrap li{
			
		}
		.member_navi_wrap li a {
		    padding: 20px 30px;
		    background-color: #ff8a00;
		    display: block;
		    color: white;
		    border-radius: 5px;
		    margin-bottom: 10px;
		    
		}
		.member_navi_wrap li a:link {color: white;}
		.member_navi_wrap li a:visited {color: white;}
		.member_navi_wrap li a:active {color: black;}
		.member_navi_wrap li a:hover {color: black;} 
		
	</style>
</head>

<!-- member-myPage ------------------------------------------------------------------------------------>
<body>
	<div class="member_container">
		<div class="member_navi_wrap">
			<ul>
				<li><a class="member_menu_01" href="/member/memberMyPage">my 요기요</a></li>
				<li><a class="member_menu_02" href="/member/memberOrderList">주문내역</a></li>
				<li><a class="member_menu_03" href="/member/memberReviewList">리뷰관리</a></li>
			</ul>
		</div>

		<div class="displayCanvas">
			<div class="myPage">
				<form class="form-inline">
					<table class="table table-hover">
						<tr>
							<td class="my-page">my 요기요</td>
						</tr>
						<tbody class="form-update">
							<tr>
								<td class="first">아이디</td>
								<td class="output" colspan="2">
								<span id="memberId"></span>
								<%-- ${member.memberId } --%></td>
							</tr>

							<tr>
								<td class="first">닉네임</td>
								<td class="output" colspan="2"><input type="text"
									id="memberName" name="memberName"<%--value=" ${member.memberName }"--%>>&nbsp;
									<button type="button" class="btn btn-info" id="changeName">닉네임
										변경</button></td>
							</tr>

							<tr>
								<td class="first" id="first_pwd">비밀번호</td>
								<td class="output" colspan="2">
									<button type="button" class="btn btn-info"
										id="activateChangePwd">비밀번호 변경</button>
									<div id="pwdArea">
										<br> <br>
										<label for="memberPwd">기존 비밀번호</label>
										<input type="password" class="form-control" id="memberPwd" placeholder="Enter password" name="memberPwd"><br>
										<label for="newPwd">변경할 비밀번호</label>
										<input type="password" class="form-control" id="newPwd" placeholder="Enter password" name="newPwd">
										<br>
										<label for="newPwd2">비밀번호 확인</label>
										<input type="password" class="form-control" id="newPwd2" placeholder="Enter password" name="newPwd2">
										<button type="button" class="btn btn-info" id="changePwd">변경</button>
									</div>
								</td>
							</tr>

							<tr>
								<td class="first">주소</td>
								<td class="output" colspan="2">
									<input type="text" id="memberAddress" name="memberAddress">&nbsp;
									<button type="button" class="btn btn-updateAddress" id="updateAddress" onclick="execDaumPostcode()">주소 변경</button>
								</td>
							</tr>

							<tr>
								<td class="first">이메일</td>
								<td class="output" colspan="2">

									<div class="form-group">
										<input type="text" id="memberMail1" name="memberMail1">
										@ <input type="text" id="memberMail2" name="memberMail2">
										<select id="selectMail">
											<option selected="selected">직접 입력</option>
											<option>naver.com</option>
											<option>daum.net</option>
											<option>gmail.com</option>
										</select>
									</div>
							</tr>
						</tbody>
					</table>
					<button type="button" class="btn btn-success" id="update"<%-- onclick="location.href='/member/updateMyPage?memberId=${member.memberId}'" --%>>변경정보 저장</button>
					<button type="button" class="btn btn-delete" id="delete" onclick="location.href='/member/memberDelete'">회원 탈퇴</button>
					<br>
				</form>
			</div>
		</div>
	</div>
	<br>
	<!-- script ---------------------------------------------------------------------------------------------------------------------------------->
	<script>
		function printMember(member) {
			console.log(member);
			$("#pwdArea").hide();
			$("#memberId").text(member.memberId);
			$("#memberName").val(member.memberName);
			$("#memberAddress").val(member.memberAddress);
			// 이메일을 읽어와 @를 기준으로 분리
			var indexOfAt = member.memberMail.indexOf('@');
			var memberMail1 = member.memberMail.substr(0, indexOfAt);
			var memberMail2 = member.memberMail.substr(indexOfAt+1);
			console.log(memberMail1);
			console.log(memberMail2);
			$("#memberMail1").val(memberMail1);
			$("#memberMail2").val(memberMail2);
			
			// #selectMail에서 선택한 이메일 서버와 memberMail2에 출력되는 서버를 동기화한다
			var $select = $("#selectMail").find("option");
			$select.each(function(idx, option) {
				if($(option).text() == memberMail2) {
					$($select[idx]).prop("selected", true);
				}
			});
		}
		
		$(function(){
			var member = JSON.parse('${member}')
			printMember(member);
			
			// 사용자가 선택한 이메일을 memberMail2에 출력
			// 사용자가 선택한 이메일이 직접 입력인 경우 memberMail2 편집 활성화, 아닌 경우 비활성화
			$("#selectMail").on("change", function() {
				var choice = $("#selectMail").val();
				console.log(choice);
				if(choice != "직접 입력") {
					$("#memberMail2").val(choice);
					$("#memberMail2").prop("disabled", true);
				}else if(choice == "직접 입력") {
					// input 상자의 내용이 없어야 placeholder가 출력된다
					$("#memberMail2").val("");
					$("#memberMail2").attr("placeholder", choice);
					$("#memberMail2").prop("disabled", false);
				}
			});
			// 닉네임 변경 버튼을 클릭한 경우 ajax 처리
			$("#changeName").on("click", function() {
				var param = {
					_method:"patch",
					_csrf:"${_csrf.token}",
					memberName:$("#memberName").val()
				}
				$.ajax({
					url: "/member/memberName",
					method: "post",
					data:param,
					success: function(memberName) {
 						toastr.success('닉네임 변경성공', '서버 메시지');
					}, error: function(xhr) {
						console.log(xhr.status);
 						toastr.error("사용자를 찾을 수 없습니다", '서버 메시지');
					}
				})
			});
			// 비밀번호 변경 화면 보이기
			$("#activateChangePwd").on("click", function() {
				$("#pwdArea").toggle();
			});
			
			// 비밀번호 변경 버튼을 클릭한 경우 ajax 처리
			$("#changePwd").on("click", function() {
				var newPwd = $("#newPwd");
				var newPwd2 = $("#newPwd2");
				var regexp = /^(?=.*[!@#$%^&*])[0-9A-Za-z!@#$%^&*]{8,10}/;
				// 정규식 확인
				if(!regexp.test(newPwd.val())) {
					toastr.error("비밀번호는 특수문자를 포함하는 영숫자 8~10자입니다")
					newPwd.val("");
					newPwd2.val("");
					return;
				}	
				// 비밀번호 일치 확인
				else if(newPwd.val() != newPwd2.val()) {
					newPwd2.val("");
					newPwd2.attr("placeholder", "비밀번호가 일치하지 않습니다");
					return;
				}
				var param = {
					_method:"patch",
					_csrf:"${_csrf.token}",
					memberPwd: $("#memberPwd").val(),
					newPwd: newPwd.val()
				};
				$.ajax({
					url: "/member/memberPwd",
					method: "post",
					data:param,
					success: function() {
						console.log("ffffff");
						toastr.success("비밀번호를 변경했습니다", '서버 메시지');
					}, error: function(xhr) {
						console.log(xhr.status);
 						toastr.error("비밀번호 변경에 실패했습니다", '서버 메시지');
					}
				})
			});
			// 변경 버튼을 클릭한 경우 ajax 처리
			$("#update").on("click", function(){
	
				// 비밀번호를 입력한 경우 
				if($("#newPwd").val()!="") {
					var newPwd = $("#newPwd");
					var newPwd2 = $("#newPwd2");
					var regexp = /^(?=.*[!@#$%^&*])[0-9A-Za-z!@#$%^&*]{8,10}/;
					if(!regexp.test(newPwd.val())) {
 						toastr.error("비밀번호는 대문자, 숫자, 특수문자를 포함하는 영숫자 8~10자입니다")
						newPwd.val("");
						newPwd2.val("");
						return;
					} else if(newPwd.val() != newPwd2.val()) {
						newPwd2.val("");
						newPwd2.attr("placeholder", "비밀번호가 일치하지 않습니다");
						return;
					}
					
				}
				// memberMail1과 memberMail2를 연결해 이메일 생성
				var memberMail = $("#memberMail1").val() + "@" + $("#memberMail2").val();
				var memberAddress = $("#memberAddress").val();
				var memberName = $("#memberName").val();
				var token = "${_csrf.token}"
				var header = "${_csrf.headerName}"
				
				var param = {
							 'memberName': memberName,
							 'memberMail': memberMail,
							 'memberAddress': memberAddress
							}
				
				$.ajax({
					type: "post",
					url: "/member/memberUpdate",
					data : param,
					beforeSend: function(xhr) {   		/*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
						xhr.setRequestHeader(header, token);
					},
					success:function(data) {
						console.log('data', data);
						toastr.success("정보를 변경했습니다", "서버 메시지");
					}, error: function() {
					
					}
				});
			});
			
		});
		
	</script> 
	
	<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
	
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
                $("#memberAddress").val(addr); 
                /* document.getElementById("search_input").value = addr; */
                // 커서를 상세주소 필드로 이동한다.
                /* document.getElementById("sample6_detailAddress").focus(); */
            }
        }).open();
    }
		
	</script> 
	  
</body>
</html>