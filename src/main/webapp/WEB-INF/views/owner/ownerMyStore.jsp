<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link href="../resources/css/common/mainCss.css" rel="stylesheet" type="text/css" />
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/js/toastr.min.js"></script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/css/toastr.min.css">
	<style>
		.btn_login{
			position: relative;
			margin-top: -20px;
			mrgin-bottom: 20px;
			margin-left: 1px;
			width: 49.5%;
			font-weight: bold;
			background-color: #fa0050;
		}
		.btn_previous{
			position: relative;
			margin-top: -20px;
			mrgin-bottom: 20px;
			width: 49.5%;
			font-weight: bold;
			background-color: #ff8a00; 
		}
		.list-group-item input[type=button]{
                color: rgb(0, 0, 0);
                background-color: #fff;
                border: 1px solid rgba(0,0,0,.125);
                outline: none;
                width: 60px;
                height: 30px;
                text-align: center;
    			cursor: pointer;
            }
		/* 주소 변경 버튼 */
		#updateAddress{
			position: relative;
			background-color: #fa0050;
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
			 max-width: 673px; 
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
		.btn-back{
			font-size: 10px;
			color: grey;
		}
		#msg_min_price{
			font-size: 9px;
			color: #fa0050;
		}
		#msg_payment_method{
			font-size: 9px;
			color: #fa0050;
		}
		#storePostNo{
			width: 700px;
		}
	</style>
</head>
<body>
	<div id="content" class="container fluid">
		<div class="login-wrap">
			<h1 class="d-none">요기요</h1>
			<form class="form-login" method="post" action="/owner/updateStore" enctype="multipart/form-data">
				<div class="login-form">
					
					<h1>my store</h1>
					<p><strong><sec:authentication property= "principal.username" /></strong>님으로 로그인되어 있습니다.</p>	
					
					<ul class="list-group">
						<li class="list-group-item">
							<label>가게로고</label>
							<input type="file" name="file" id="storeLogoUrl" value="${myStore.storeLogoUrl}"  />
<%-- 							<span><img alt="가게로고" src="/store/img?fileName=${myStore.storeLogoUrl}" id="storeLogoImg" height="150px;" width="150px;"/></span> --%>
							<span><img alt="가게로고" src="${myStore.storeLogoUrl}" id="storeLogoImg" height="150px;" width="150px;"/></span>
						</li>
					</ul>	
					
					<ul class="list-group">
						<li class="list-group-item">
						<label>가게 분류</label>
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
						<li class="list-group-item">
						<label>가게 이름</label>
							<input type="text" id="storeName" name="storeName" value="${myStore.storeName}"/>
							<span id="msg_name"></span>
						</li>
					</ul>
					
					<ul class="list-group">
						<li class="list-group-item">
						<label>가게 정보</label>
							<textarea name="ownerInfo" id="ownerInfo" rows="5" cols="40">${myStore.ownerInfo}</textarea>
							<span id="msg_info"></span>
						</li>
					</ul>	
					
					<ul class= "list-group">
						<li class="list-group-item">
							<label>가게 주소</label><br>
							<input type="hidden" id="storeAddress" name="storeAddress"/>
							<input type="text" id="storePostNo" name="storePostNo" value="${myStore.storePostNo}"/>
							<input type="button" class="btn-address" onclick="execDaumPostcode()" value="검색"/>
							<input type="text" class="form-control" id="storeRoadPost" name="storeRoadPost" value="${myStore.storeRoadPost}" />
							<input type="text" class="form-control" id="storeDetailPost" name="storeDetailPost" value="${myStore.storeDetailPost}" />
							<span id="msg_address"></span>
						</li>
					</ul>
					
					<ul class="list-group">
						<li class="list-group-item">
						<label>open 시간</label>
							<input type="text" id="storeOpenTime" name="storeOpenTime" value="${myStore.storeOpenTime}" />
							<span id="msg_open_time"></span>
						</li>
					</ul>
					
					<ul class="list-group">	
						<li class="list-group-item">
							<label>close 시간</label>
							<input type="text" id="storeCloseTime" name="storeCloseTime" value="${myStore.storeCloseTime}" />
							<span id="msg_close_time"></span>
						</li>
					</ul>
					
					<ul class="list-group">	
						<li class="list-group-item">
							<label>가게 전화번호</label>
							<input type="text" id="storeTel" name="storeTel" value="${myStore.storeTel}" />
							<span id="msg_store_tel"></span>
						</li>
					</ul>
					
					<ul class="list-group">		
						<li class="list-group-item">
							<label>최소 주문금액</label><br>
							<input type="text" id="storeMinPrice" name="storeMinPrice" value="${myStore.storeMinPrice}원" />
							<span id="msg_min_price">  ※수정시 '원'을 뺴고 입력해주세요.</span>
						</li>
					</ul>	
					
					<ul class="list-group">		
						<li class="list-group-item">
							<label>배달 예상시간</label><br>
							<input type="text" id="storeDeliveryTime" name="storeDeliveryTime" value="${myStore.storeDeliveryTime}분" />
							<span id="msg_deliverty_time">※수정시 '분'을 뺴고 입력해주세요.</span>
						</li>
					</ul>	
					<ul class="list-group">		
						<li class="list-group-item">
							<label>결제 방식</label><br>
							<span id="storePaymentMethod">${myStore.storePaymentMethod}</span>
							<span id="msg_payment_method"></span>
						</li>
					</ul>	
		
					<ul class="list-group">	
						<li class="list-group-item">
							<label>가게 별점</label><br>
							<span id="storeStarPoint">${myStore.storeStarPoint}점</span>
						</li>
					</ul>
					
					<ul class="list-group">	
						<li class="list-group-item">
							<label>리뷰 </label><br>
							<span id="storeReviewCnt">${myStore.storeReviewCnt}개</span>
						</li>
					</ul>
						
				</div>

				<button type="button" class="btn btn_login">변경된 정보 저장</button>
				<button type="button" class="btn btn_previous" onclick="location.href='/owner/ownerMyStoreList'">이전으로</button>
				<input type="hidden" name="${_csrf.parameterName}" value= "${_csrf.token}" />
				<input type="hidden" id="storeNo" name="storeNo"/>
			</form>
		</div>
	</div>
	
	
	<script>
	
		$(function() {
			var categoryId = "${myStore.categoryId}"
			$('#categoryId').val(categoryId)
			
		})
	</script>
	
	<script>

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
	                $("#storeAddress-input").val(addr); 
	                /* document.getElementById("search_input").value = addr; */
	                // 커서를 상세주소 필드로 이동한다.
	                /* document.getElementById("sample6_detailAddress").focus(); */
	            }
	        }).open();
	    }	
	</script> 
	  
</body>
</html>