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
			width: 110px;	
		}
		.btn-address {
			background-color: #ff8a00;
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
		#ownerPwd2{
			width: 200px;
		}
		/* mail input */
		#ownerMail1 {
			width: 120px;
			border: 1px solid #ddd;
		}
		#ownerMail2 {
			width: 200px;
			border: 1px solid #ddd;
		} 
		/* name input */
		#ownerName {
			width: 200px;
			border: 1px solid #c0c0c0;
		}
		/* address input */
		#ownerAddress {
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
		/* asideMyPage */
		.owner_container {
			display: flex;
			justify-content: center;
			/* align-items: center; */
		}
		.owner_navi_wrap{
			margin-right: 15px;
			margin-top: 22px;
		}
		.owner_navi_wrap ul{
			
			
		}
		.owner_navi_wrap li{
			
		}
		.owner_navi_wrap li a {
			padding: 20px 30px;
		    background-color: #ff8a00;
		    display: block;
		    color: white;
		    border-radius: 5px;
		    margin-bottom: 6px;
		}
		.owner_navi_wrap li a:link {color: white;}
		.owner_navi_wrap li a:visited {color: white;}
		.owner_navi_wrap li a:active {color: black;}
		.owner_navi_wrap li a:hover {color: black;} 
		
	</style>
</head>

<!-- owner-myPage ------------------------------------------------------------------------------------>
<body>
	<div class="owner_container">
	<div class="owner_navi_wrap">
			<ul>
				<li><a class="owner_menu_01" href="/owner/ownerMyPage">my 요기요</a></li>
				<li><a class="owner_menu_02" href="/store/createStore">가게등록</a></li>
				<li><a class="owner_menu_03" href="/owner/ownerMyStoreList">가게관리</a></li>
				<li><a class="owner_menu_04" href="">리뷰관리</a></li>
			</ul>
		</div>
		
		<div class="displayCanvas">
			<div class="myPage">
				<form class="form-inline">
					<table class="table table-hover">
						<tr>
							<td class="my-page">my page</td>
						</tr>
						<tbody class="form-update">
							<tr>
								<td class="first">아이디</td>
								<td class="output" colspan="2">
									<span id="ownerId"></span>
									<%-- ${owner.ownerId } --%>
								</td>
							</tr>
							
							<tr>
								<td class="first">닉네임</td>
								<td class="output" colspan="2">
									<input type="text" id="ownerName" name="ownerName" <%--value=" ${owner.ownerName }"--%>>&nbsp;
									<button type="button" class="btn btn-info" id="changeName">닉네임 변경</button>
								</td>
							</tr>
							
							<tr>
								<td class="first" id="first_pwd">비밀번호</td>
								<td class="output" colspan="2">
									<button type="button" class="btn btn-info" id="activateChangePwd">비밀번호 변경</button>
									<div id="pwdArea">
										<br> <br> 
										<label for="ownerPwd">기존 비밀번호</label>
										<input type="password" class="form-control" id="ownerPwd"
											   placeholder="Enter password" name="ownerPwd"><br>
										<label for="newPwd">변경할 비밀번호</label>
										<input type="password" class="form-control" id="newPwd"
										       placeholder="Enter password" name="newPwd"><br>
										<label for="newPwd2">비밀번호 확인</label>
										<input type="password" class="form-control" id="newPwd2"
											   placeholder="Enter password" name="newPwd2">
										<button type="button" class="btn btn-info" id="changePwd">변경</button>
									</div>
								</td>
							</tr>
							
							<tr>
								<td class="first">이메일</td>
								<td class="output" colspan="2">
									<div class="form-group">
										<input type="text" id="ownerMail1" name="ownerMail1">
										@
										<input type="text" id="ownerMail2" name="ownerMail2">
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
				
				<button type="button" class="btn btn-success" id="update" <%-- onclick="location.href='/owner/updateMyPage?ownerId=${owner.ownerId}'" --%>>변경정보 저장</button>
				<button type="button" class="btn btn-delete" id="delete" onclick="location.href='/owner/ownerDelete'">회원 탈퇴</button>
				<br>
			</form>
		</div>
	</div>
	</div>
		

	<br>
<!-- script ---------------------------------------------------------------------------------------------------------------------------------->
	<script>
		
		function printOwner(owner) {
			console.log(owner);
			$("#pwdArea").hide();
			$("#ownerId").text(owner.ownerId);
			$("#ownerName").val(owner.ownerName);
// 			$(".owner_menu_03").attr('href', '?ownerId=owner.ownerId');
// 			$(".owner_menu_04").attr('href', '?ownerId=owner.ownerId');

			// 이메일을 읽어와 @를 기준으로 분리
			var indexOfAt = owner.ownerMail.indexOf('@');
			var ownerMail1 = owner.ownerMail.substr(0, indexOfAt);
			var ownerMail2 = owner.ownerMail.substr(indexOfAt+1);
			console.log(ownerMail1);
			console.log(ownerMail2);
			$("#ownerMail1").val(ownerMail1);
			$("#ownerMail2").val(ownerMail2);
			
			// #selectMail에서 선택한 이메일 서버와 ownerMail2에 출력되는 서버를 동기화한다
			var $select = $("#selectMail").find("option");
			$select.each(function(idx, option) {
				if($(option).text() == ownerMail2) {
					$($select[idx]).prop("selected", true);
				}
			});
		}
		$(function(){
			var owner = JSON.parse('${owner}')
			printOwner(owner);
			
			// 사용자가 선택한 이메일을 ownerMail2에 출력
			// 사용자가 선택한 이메일이 직접 입력인 경우 ownerMail2 편집 활성화, 아닌 경우 비활성화
			$("#selectMail").on("change", function() {
				var choice = $("#selectMail").val();
				console.log(choice);
				if(choice != "직접 입력") {
					$("#ownerMail2").val(choice);
					$("#ownerMail2").prop("disabled", true);
				}else if(choice == "직접 입력") {
					// input 상자의 내용이 없어야 placeholder가 출력된다
					$("#ownerMail2").val("");
					$("#ownerMail2").attr("placeholder", choice);
					$("#ownerMail2").prop("disabled", false);
				}
			});
			// 닉네임 변경 버튼을 클릭한 경우 ajax 처리
			$("#changeName").on("click", function() {
				var param = {
					_method:"patch",
					_csrf:"${_csrf.token}",
					ownerName:$("#ownerName").val()
				}
				$.ajax({
					url: "/owner/ownerName",
					method: "post",
					data:param,
					success: function(ownerName) {
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
					ownerPwd: $("#ownerPwd").val(),
					newPwd: newPwd.val()
				};
				$.ajax({
					url: "/owner/ownerPwd",
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
					// toastr.error("비밀번호는 대문자, 숫자, 특수문자를 포함하는 영숫자 8~10자입니다")
						newPwd.val("");
						newPwd2.val("");
						return;
					} else if(newPwd.val() != newPwd2.val()) {
						newPwd2.val("");
						newPwd2.attr("placeholder", "비밀번호가 일치하지 않습니다");
						return;
					}
					
				}
				// ownerMail1과 ownerMail2를 연결해 이메일 생성
				var ownerMail = $("#ownerMail1").val() + "@" + $("#ownerMail2").val();
				var ownerName = $("#ownerName").val();
				var token = "${_csrf.token}"
				var header = "${_csrf.headerName}"
				var param = {
							 'ownerName': ownerName,
							 'ownerMail': ownerMail
							}

				$.ajax({
					type: "post",
					url: "/owner/ownerUpdate",
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
	 
	  
</body>
</html>