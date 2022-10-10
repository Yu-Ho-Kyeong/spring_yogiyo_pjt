<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>여기냐? 결제하기</title>
	<link rel="appletouchiconprecomposed" href="https://www.yogiyo.co.kr/mobile/image/app_128x128.p" />
	<link rel="appletouchiconprecomposed" sizes="144x144" href="https://www.yogiyo.co.kr/mobile/image/app_144x144.p" />
	<link href="/resources/css/common/mainCss.css" rel="stylesheet" type="text/css" />
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<style>
		.ng-hide{
			display: none;
		}
	</style>
</head>
<body>
	<div id="content" class="container-fluid">
		<div class="checkout-wrap">
			<form action="/order/pay" method="post" class="form-checkout">

				<div class="col-sm-8">
					<div class="sub-title">
						<span>결제하기</span>
					</div>
					<div class="panel-group" data-allow-multiple="true" bs-collapse="">
						<div class="panel panel-default">
							<div class="panel-heading" id="panel-heading1">
								<h4 class="panel-title">
									<a bs-collapse-toggle="" class="clearfix" data-toggle="collapse"> 
										<span class="menu-name pull-left">배달정보</span>
										<i class="pull-right icon-arr-up" id="pull-right1"></i>
									</a>
								</h4>
							</div>
							<div class="panel-collapse collapse am-collapse in" id="panel-collapse1">
								<div class="panel-body">
									<div class="form-horizontal">
										<div class="form-group">
											<label for="address" class="col-sm-2 control-label">주소</label>
											<div class="col-sm-10">
												<input type="hidden" class="form-control address" name="orderAddress" />
												<input type="text" class="form-control address1"
													   placeholder="배달 주소" 
													   name="orderAddress1"
													   value="${memberInfo.memberAddress}"
													   onclick="execDaumPostcode()">
											</div>											
										</div>
										
										<div class="form-group">
						                	<div class="col-sm-offset-2 col-sm-10">
							                	<input type="text"
							                		   class="form-control address_detail" 
							                		   placeholder="(필수)상세주소 입력" 
							                		   name="address_detail" 
							                		   required="required">
							                    <span class="help-block mar0">
							                    	<span class="text-danger ng-hide">상세 주소를  입력해주세요.</span>
							                    </span>
						                  </div>
						                </div>
										
										<div class="form-group">
											<label for="phone" class="col-sm-2 control-label">휴대전화번호</label>

											<div class="ol-sm-offset-2 col-sm-10">
												<div class="">
													<input type="tel"
														   class="form-control input-type1"
														   placeholder="(필수)휴대전화 번호 입력"
														   name="orderTel"
														   value="${memberInfo.memberPhoneNo}"					   
														   required="required">
												</div>

												<span class="help-block mar0 ng-hide">
													<span class="text-danger">전화번호를 입력해주세요. (050 등 안심번호 사용 불가)</span> 
													<span class="text-danger ng-hide">휴대전화번호는 숫자만 입력해주세요.</span>
												</span>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>

						<div class="panel panel-default" bs-collapse="">
							<div class="panel-heading" id="panel-heading2">
								<h4 class="panel-title">
									<a class="clearfix"
									   data-toggle="collapse">
										<span class="menu-name pull-left">주문시 요청사항</span> 
										<i class="pull-right icon-arr-up" id="pull-right2"></i>
									</a>
								</h4>
							</div>
							
							<div class="panel-collapse collapse am-collapse in" id="panel-collapse2">
								<div class="panel-body">
								
									<textarea class="form-control"
											  rows="3"
											  name="orderRequest"
											  maxlength="100"
											  placeholder="코로나19 예방을 위해 비대면 배달 권장드립니다. 요기서 결제 선택 후, &quot;문 앞 배달&quot;을 요청사항에 남겨주세요."></textarea>
									
									<div class="txt-limit">
										<div class="txt-length">0 / 100</div>
										<span class="help-block ng-hide">
											<span class="text-danger">최대 100자까지 입력 가능합니다.</span>
										</span>
									</div>
								</div>
							</div>
						</div>

						<div class="panel panel-default clearfix">
							<div class="panel-heading">
								<h4 class="panel-title">
									<a class="clearfix"> 결제수단 선택
<!-- 										<span>(현장결제는 지원하지 않습니다.)</span> -->
									</a>
								</h4>
							</div>
							
							<!-- 요기요 결제 -->
							<div class="panel-collapse collapse am-collapse in">
								<div class="panel-body payment-wrap">
									<div class="ygy-payment clearfix">
										<div>
											<strong>요기서결제</strong> 
											<span class="stxt">웹에서 미리 결제</span> 
											<span class="ng-hide">
												<span class="coupon ng-hide">0원</span> 
												<span class="coupon1 ng-hide">-0%</span>
											</span>
											<p class="txt-ie">
<!-- 												<em>* 현재 페이 결제만 가능합니다.</em> -->
											</p>
										</div>
										<div class="btn-group">
											<label class="btn btn-default2">
												<!-- <i class="icon-check icon-npay"></i> --> 
												<input type="radio"
													   name="orderPaymentMethod"
													   value="0"
													   required="required">만나서 결제
											</label>  
										</div>		
										<div class="btn-group">
											<label class="btn btn-default">
												<i class="icon-check icon-npay"></i> 
												<input type="radio"
													   name="orderPaymentMethod"
													   value="1"
													   required="required">카카오페이
											</label>  
										</div>		
									</div>

									<div class="ng-hide">
										<strong>현장결제</strong> 
										<span class="stxt ng-hide">음식받고 직접 결제</span>
										<p class="stxt">* 로그인 후, 음식받고 직접 결제할 수 있어요!</p>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>

				<div class="col-sm-4 order-wrap-pc" style="top: 0px; position: relative;">
					<div class="order-list">
						<div class="panel panel-default">
							<div class="panel-heading">
								<h3 class="panel-title">주문내역</h3>
							</div>
							<div class="panel-body checkout-order-list">
								<input type="hidden" name="orderStoreName" value="${store.store.storeName}"/>
								<div class="list-group-item restaurant_name">${store.store.storeName}</div>
								<ul class="list-group order-list">
									<!-- ngRepeat: item in cart.get().items -->
									<c:forEach items="${cartList}" var="cart">
										<li class="list-group-item">
											<div class="order-item clearfix">
												<div class="order-name">
													<input type="hidden" name="orderMenu" value="${cart.menuName}" />
													<span class="menu-name">${cart.menuName}</span> x 
													<input type="hidden" name="orderAmount" value="${cart.cartAmount}" />
													<span class="cart-amount">${cart.cartAmount}</span>개
												</div>
												<div class="order-price">
													<fmt:formatNumber value="${cart.menuPrice * cart.cartAmount}" pattern="#,###,###" />원
													<input type="hidden" name="storeNo" value="${cart.storeNo}">
												</div>
												
											</div>
										</li>
									</c:forEach>
									<!-- end ngRepeat: item in cart.get().items -->
								</ul>
								
								<div class="list-group1">
<!-- 									<span class="list-group-item clearfix ng-hide" -->
<!-- 										ng-show="additional_price > 0"> -->
<!-- 										<div class="order-name">추가 금액</div> -->
<!-- 										<div class="order-price"> -->
<!-- 											<span class="additional_price">원</span> -->
<!-- 										</div> -->
<!-- 									</span>  -->
<!-- 								<span class="list-group-item clearfix ng-hide" ng-show="delivery_fee > 0"> -->
<!-- 									<div class="order-name">배달료</div> -->
<!-- 									<div class="order-price"> -->
<!-- 										<span class="delivery_fee">0원</span> -->
<!-- 									</div> -->
<!-- 									</span>  -->
<!-- 									<span class="list-group-item clearfix ng-hide"> -->
<!-- 										<div class="order-name">즉시할인</div> -->
<!-- 										<div class="order-price"> -->
<!-- 											<span class="delivery_discount">0원</span> -->
<!-- 										</div> -->
<!-- 									</span>  -->
<!-- 									<span class="list-group-item clearfix ng-hide"> -->
<!-- 										<div class="order-name">추가할인</div> -->
<!-- 										<div class="order-price"> -->
<!-- 											<span class="additional_discount">0원</span> -->
<!-- 										</div> -->
<!-- 									</span>  -->
<!-- 									<span class="list-group-item clearfix ng-hide"> -->
<!-- 										<div class="order-name">쿠폰할인</div> -->
<!-- 										<div class="order-price"> -->
<!-- 											<span class="coupon_discount"></span> -->
<!-- 										</div> -->
<!-- 									</span>  -->
									
									<span class="list-group-item total-order-price clearfix">
										<div class="order-name">총 결제 금액</div>
										<div class="order-price">
											<span class="total_price">
												<input type="hidden" name="orderTotalPrice" value="${totalPrice}" />
												<fmt:formatNumber value="${totalPrice}" pattern="#,###,###" />원
											</span>
										</div>
									</span>
								</div>
							</div>
						</div>

						<div class="agree-set">
							<small> 
								<span ng-hide="check_login()">
									<a href="#/policy/" target="_blank">이용약관</a>,
								</span> 
								
								<span ng-hide="check_login()">
									<a ng-href="#/collect_default/" target="_blank" href="#/collect_default/">개인정보 수집 및 이용</a>,
								</span> 
								
								<span>
									<a ng-href="#/partner/573498/" target="_blank" href="#/partner/573498/">개인정보 제3자 제공</a> 
									<span ng-hide="check_login()">,
									</span> 
									
									<span ng-hide="check_login()">
										<a ng-href="#/efinance_agreement/" target="_blank" href="#/efinance_agreement/">전자금융거래 이용약관</a>,
									</span> 
									<span ng-hide="check_login()">
										<a href="/p/faq/#4-4" target="_blank">만 14세 이상 이용자</a>
									</span> 내용 확인하였으며 결제에 동의합니다. 
								</span>
							</small>
						</div>

						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						<input type="hidden" name="memberId" value="${memberInfo.memberId}" />
						<button type="button" class="btn btn-lg btn-block btn-ygy1">결제하기</button>
					</div>
				</div>
			</form>
		</div>
	</div>
	
<!-- 	<form action="/order/pay" method="post"> -->
<%-- 		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> --%>
<!-- 		<input type="submit" value="등록" /> -->
<!-- 	</form> -->
	
	<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
	
		var addressCheck = false; // 주소 공백 체크
		
		$(document).ready(function(){
			
			$("#panel-heading1").click(function(){ // 배달정보 클릭시  input창 열고 닫기
				$('#panel-collapse1').slideToggle()
				$(this).children().children().children('#pull-right1').toggleClass('icon-arr-up')
				$(this).children().children().children('#pull-right1').toggleClass('icon-arr-down')
			})
			$("#panel-heading2").click(function(){ // 요청사항 클릭시  input창 열고 닫기
				$('#panel-collapse2').slideToggle()
				$(this).children().children().children('#pull-right2').toggleClass('icon-arr-up')
				$(this).children().children().children('#pull-right2').toggleClass('icon-arr-down')
			})
			
			$(".btn-default").click(function(){ // 네이버페이 클릭시 active
				$(".btn-default").addClass('btn btn-default active')
				$(".btn-default2").removeClass('active')
			})
			$(".btn-default2").click(function(){ // 만나서 결제 클릭시 active
				$(".btn-default2").addClass("btn btn-default2 active")
				$(".btn-default").removeClass("active")
			})
			
			// 결제하기
			var addressDetail
			$(".btn-ygy1").click(function(){
				var form = $(".form-checkout")
				var address1 = $(".address1").val();
				var address = $(".address").val();
				addressDetail = $(".address_detail").val()
				var token = "${_csrf.token}"
				var header = "${_csrf.headerName}"
				address = address1 + " " + addressDetail
				
				checkAddress()			
				
				$('.address').val(address)
				
				// 주소 미입력시
				if( !addressCheck ){
					alert("상세주소를 입력해주세요")
					return
				}
				
				
				// 만나서 바로 결제
// 				if( ~~~~ ) {
// 					form.attr("action", "/바로주문insert")
					form.submit()	
// 					return					
// 				}
			})	
			
			
			$(".address_detail").on("blur", function() {
				checkAddress();
			})
			
			
			// 상세주소 미입력시 메세지 출력
			function checkAddress() {
				addressDetail = $(".address_detail").val()
				if(addressDetail == undefined || addressDetail.length == 0) {
					$(".text-danger").removeClass("ng-hide");
					addressCheck = false;
				}else{
					$(".text-danger").addClass("ng-hide");
					addressCheck = true;
				}
			}
		})
			
	</script>
	
	<script>
		function execDaumPostcode() { //다음지도 api
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
	                $(".address1").val(addr); 
	                /* document.getElementById("search_input").value = addr; */
	                // 커서를 상세주소 필드로 이동한다.
	                /* document.getElementById("sample6_detailAddress").focus(); */
	            }
	        }).open();
	    }	
	</script> 
</body>
</html>