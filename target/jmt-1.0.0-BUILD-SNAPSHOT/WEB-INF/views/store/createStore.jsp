<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<link href="../resources/css/common/mainCss.css" rel="stylesheet" type="text/css" />
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<title>가게 등록</title>
</head>
<style>
	/* 가게분류 select */
	#categoryName{
		width: 100%; 
	}
	/* 주문최소금액 input */
	#storeMinPrice{
		width: 100px; 
	}
	/* 배달시간 input */
	#storeDeliveryTime{
		width: 110px; 
	}
	/* 가게정보 textarea */
	#ownerInfo{
		width: 100%;
		height: 200px; 
	}
	/* 주소입력1 input */
	#storeAddress1{
		 font-size: 14px;
		 padding: 6px 12px;
		 height: 34px;
		 box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
		 transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
	}
	#storeAddress1:focus{
		 outline: 0;
         box-shadow: inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(102, 175, 233, .6);
	}
	#storeAddress1::-webkit-input-placeholder {
	  color: #999;
	}
	/* 주소입력2,3 input */
	#storeAddress2, #storeAddress3{
	
	}
	/* 취소버튼, 등록버튼 */
	.btn_enroll, .btn_cancle{
		width: 49.5%;
		margin-top: 10px;
	}
	.btn_enroll {
		background-color: #fa0050;
		color: white;
	}
	input[type="checkbox"]{
		display: block;
	}
	
</style>

<body>
<!-- create store ---------------------------------------------------------------------------------------------------------------->
	<div id="content" class="container fluid">
		<div class="join-wrap">
			<h1 class="d-none">요기요</h1>
			<form class="form-join" id="create-form" method="post" action="/store/createStore" enctype="multipart/form-data">
				
				<div class="join-form">
					<div class="title"></div>
					
					<ul class="list-group">
						<label>가게 로고</label>
						<li class="list-group-item">
							<input type="file" name="file" id="storeLogoUrl">
						</li>
					</ul> 
					
					<ul class="list-group">
						<label>가게 분류</label>
						<li class="list-group-item2">
						<select name="categoryId" id="categoryId" class="form-control">
						 	<option value="6">한식</option>
						 	<option value="1">1인분 주문</option>
						 	<option value="2">프렌차이즈</option>
						 	<option value="11">디저트</option>
						 	<option value="12">편의점마트</option>
						 	<option value="3">치킨</option>
						 	<option value="4">양식</option>
						 	<option value="5">중식</option>
						 	<option value="7">일식</option>
						 	<option value="8">족발</option>
						 	<option value="9">야식</option>
						 	<option value="10">분식</option>
						</select>
						</li>
						</ul>
 					
 					<ul class="list-group">
 						<label>가게 이름</label>
						<li class="list-group-item">
							<input type="text" id="storeName" name="storeName" placeholder="가게이름을 입력해주세요." />
							<span id="msg_name"></span>
						</li>
					</ul>
			
 					<ul class="list-group">
 						<label>가게 정보</label>
						<li class="list-group-item">
							<textarea name="ownerInfo" id="ownerInfo" rows="5" cols="40"></textarea>
							<span id="msg_info"></span>
						</li>
					</ul>
							
					<ul class= "list-group2">
						<label>주소 입력</label>
						<li class="list-group-item2">
							<input type="hidden" id="storeAddress" name="storeAddress"/>
							<input type="text" id="storeAddress1" name="storePostNo" placeholder="주소검색 버튼을 클릭해주세요."/>
							<input type="button" class="btn-address" onclick="execDaumPostcode()" value="검색"/>
							<input type="text" class="form-control" id="storeAddress2" name="storeRoadPost" placeholder="동,면,읍" />
							<input type="text" class="form-control" id="storeAddress3" name="storeDetailPost" placeholder="상세주소" />
							<span id="msg_address"></span>
						</li>
					</ul>
							
					<ul class="list-group">
						<label>open 시간</label>
						<li class="list-group-item">
							<input type="text" id="storeOpenTime" name="storeOpenTime" placeholder="9시 오픈 -> 0900" />
							<span id="msg_open_time"></span>
						</li>
					</ul>
						
					<ul class="list-group">	
						<label>close 시간</label>
						<li class="list-group-item">
							<input type="text" id="storeCloseTime" name="storeCloseTime" placeholder="23시 마감 -> 2300" />
							<span id="msg_close_time"></span>
						</li>
					</ul>
						
					<ul class="list-group">	
						<label>가게 전화번호</label>
						<li class="list-group-item">
							<input type="text" id="storeTel" name="storeTel" placeholder="ex) 0322631275(-제외하고 입력)" />
							<span id="msg_store_tel"></span>
						</li>
					</ul>
						
					<ul class="list-group">	
						<label>최소 주문금액</label>
						<li class="list-group-item">
							<input type="text" id="storeMinPrice" name="storeMinPrice" placeholder="최소 주문금액" />원
							<span id="msg_min_price"></span>
						</li>
					</ul>
					
					<ul class="list-group">	
						<label>결제 방식</label>
						<li class="list-group-item">
							<input type="checkbox" id="storePaymentMethod" name="storePaymentMethod" value="요기서결제" checked="checked" />
							<label for="storePaymentMethod1"><span></span>요기서결제  </label>
							<input type="checkbox" id="storePaymentMethod" name="storePaymentMethod" value="현금" checked="checked" />
							<label for="storePaymentMethod2"><span></span>현금  </label>
							<input type="checkbox" id="storePaymentMethod" name="storePaymentMethod" value="신용카드" checked="checked" />
							<label for="storePaymentMethod3"><span></span>신용카드  </label>
							<span id="msg_payment_method"></span>
						</li>
					</ul>
					
					<ul class="list-group">	
						<label>배달 시간</label>
						<li class="list-group-item">
							<input type="text" id="storeDeliveryTime" name="storeDeliveryTime" placeholder="배달 예상 시간" />분
							<span id="msg_delivery_time"></span>
						</li>
					</ul>
	
					<button type="button" class="btn btn_enroll">가게등록</button>
					<button type="button" class="btn btn_cancle" onclick="location.href='/owner/ownerMyPage'">취소</button>
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				</div>
			</form>
		</div>
	</div>
<!-- script -------------------------------------------------------------------------------------------------------------->
	<script>
	
		$(function(){
	
			// 가게이름 
			function checkName() {
					var name = $("#storeName").val();
					if(name.length==0) {
						$("#msg_name").text("필수입력입니다").css("color", "red").css("font-size", "0.75em");
						return false;
					} else {
						$("#msg_name").text("ok").css("color", "green").css("font-size", "0.75em");
						return true;
					}	
			}
			// 가게주소
			function checkAddress3() {
				var address1=$("#storeAddress1").val();
				var address2=$("#storeAddress2").val();
				var address3=$("#storeAddress3").val();
				var address=address1+address2+address3;
				
				if(address3.length==0) {
					$("#msg_address").text("상세주소를 입력해주세요").css("color", "red").css("font-size", "0.75em");
					return false;
				} else {
					$("#msg_address").text("ok").css("color", "green").css("font-size", "0.75em");
					return true;
				}
			}
			// 가게 오픈시간 
			function checkOpenTime() {
				var openTime = $("#storeOpenTime").val();
				if(openTime.length==0) {
					$("#msg_open_time").text("필수입력입니다").css("color", "red").css("font-size", "0.75em");
					return false;
				} 
				else {
					$("#msg_open_time").text("ok").css("color", "green").css("font-size", "0.75em");
					return true;
				}
			}
			// 가게 마감시간 
			function checkCloseTime() {
				var closeTime = $("#storeCloseTime").val();
				if(closeTime.length==0) {
					$("#msg_close_time").text("필수입력입니다").css("color", "red").css("font-size", "0.75em");
					return false;
				}
				else {
					$("#msg_close_time").text("ok").css("color", "green").css("font-size", "0.75em");
					return true;
				}
			}
			// 가게 전화번호
			function checkTel() {
				var tel = $("#storeTel").val();
				if(tel.length==0) {
					$("#msg_store_tel").text("필수입력입니다").css("color", "red").css("font-size", "0.75em");
					return false;
				}
				else {
					$("#msg_store_tel").text("ok").css("color", "green").css("font-size", "0.75em");
					return true;
				}
			}
			// 가게 최소 주문금액
			function checkPrice(){
				var price = $("#storeMinPrice").val();
				if(price.length==0){
					$("#msg_min_price").text("필수입력입니다").css("color","red").css("font-size", "0.75em");
					return false;
				}
				else {
					$("#msg_min_price").text("ok").css("color", "green").css("font-size", "0.75em");
					return true;
				}
			}
			// 가게 정보
			function checkContent(){
				var content = $("#ownerInfo").val();
				if(content.length == 0){
					$("#msg_info").text("필수입력입니다").css("color","red").css("font-size", "0.75em");
					return false;
				}
				else {
					$("#msg_info").text("ok").css("color", "green").css("font-size", "0.75em");
					return true;
				}
			}
			// 가게 분류
			function checkCategory(){
				var categoryName = $("#categoryName").val();
				return true;
			}
			// 가게이름 
			function checkTime() {
					var deliveryTime = $("#storeDeliveryTime").val();
					if(deliveryTime.length==0) {
						$("#msg_delivery_time").text("필수입력입니다").css("color", "red").css("font-size", "0.75em");
						return false;
					} else {
						$("#msg_delivery_time").text("ok").css("color", "green").css("font-size", "0.75em");
						return true;
					}	
			}
			
				$("#storeName").on("blur", function() {
					checkName();
				})				
				$("#storeAddress3").on("blur", function() {
					checkAddress3();
				})				
				$("#storeOpenTime").on("blur", function() {
					checkOpenTime();
				})				
				$("#storeCloseTime").on("blur", function() {
					checkCloseTime();
				})				
				$("#storeTel").on("blur", function() {
					checkTel();
				})
				$("#storeMinPrice").on("blur", function() {
					checkPrice();
				})
				$("#ownerInfo").on("blur", function() {
					checkContent();
				})
				$("#storeDeliveryTime").on("blur", function() {
					checkTime();
				})
				checkCategory();
				
				$(".btn_enroll").on("click", function() {

					var token = "${_csrf.token}"
					var header = "${_csrf.headerName}"		
					var form = $('#create-form')[0]
					var formData = new FormData(form) 
					var storeAddress = $("#storePostNo").val() + $("#storeRoadPost").val() + $("#storeDetailPost").val()
		
					for(var key of formData.keys()) {
						console.log(key + ' : ' + formData.get(key) )
					}
					
					$.ajax({
						url: '/store/createStore',
						data: formData,
						processData: false,
						contentType: false,
						type: 'POST',
						success: function( data ) {
							alert(data)
							location.href="/owner/ownerMyStoreList"
						},
						error: function(xhr, status, error) {
							console.log("status : " + xhr.status)
							console.log("response : " + xhr.responseText)
							console.log("status : " + status)
							console.log("error : " + error)
						}
					})
							
				});
	
			});
		
	</script>

	<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
		function execDaumPostcode() {
			        new daum.Postcode({
			            oncomplete: function(data) {
			            	// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
			            	 
			                // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
			                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
			                var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
			                var extraRoadAddr = ''; // 도로명 조합형 주소 변수
			 
			                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
			                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
			                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
			                    extraRoadAddr += data.bname;
			                }
			                // 건물명이 있고, 공동주택일 경우 추가한다.
			                if(data.buildingName !== '' && data.apartment === 'Y'){
			                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
			                }
			                // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
			                if(extraRoadAddr !== ''){
			                    extraRoadAddr = ' (' + extraRoadAddr + ')';
			                }
			                // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
			                if(fullRoadAddr !== ''){
			                    fullRoadAddr += extraRoadAddr;
			                }
			 
			                // 우편번호와 주소 정보를 해당 필드에 넣는다.
			               	document.getElementById('storeAddress1').value = data.zonecode; 
			            	document.getElementById('storeAddress2').value = fullRoadAddr;
			                
			                
			                $("storeAddress1").val(data.zonecode);
			                $("storeAddress2").val(fullRoadAddr);
			                
			            }
			         }).open();
			     }

	</script>
</body>
</html>