<%@ page language="java" contentType="text/html; charset=UTF8" pageEncoding="UTF8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>	
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>

<html>
<head>
	<meta charset= "UTF8">
	<title>요기냐?</title>
	<link rel="appletouchiconprecomposed" href="https://www.yogiyo.co.kr/mobile/image/app_128x128.p" />
	<link rel="appletouchiconprecomposed" sizes="144x144" href="https://www.yogiyo.co.kr/mobile/image/app_144x144.p" />
	<link href="/resources/css/common/mainCss.css" rel="stylesheet" type="text/css" />
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
		
	<style>
	html {
		scroll-behavior: smooth;
	}
	
	.no_review {
		display: none;
	}
	
	.ng-hide{
		display: none;
	}
	.sub-list .in{
		display: block;
	    visibility: visible;
    }
    .btn-add-cart{
    	color: red;
    	font-size: 12px;
    }
    #replyDeco{
	background-color:#FBEFF5;
	}
	</style>
</head>
<body>
	<!-- sotreList-->
	<div id="content" class="container-fluid">
	<!-- category-menu-->
	<c:import url="/include/categoryMenu"></c:import>
		<div class="restaurant-detail row">
			<div class="col-sm-8">
				<c:forEach items="${getStoreDetail}" var="store">
				<div class="restaurant-info">
					<div class="restaurant-title">
						<span class="restaurant-name">${store.storeName}</span>
					</div>
					<div class="restaurant-content">
						<!-- 썸네일로고 -->
						<img class="logo" alt="가게로고" src="${store.storeLogoUrl}">
																	 						
						<ul class="list">
							<li>
								<span class="stars star-point"> 
									<c:if test="${store.storeStarPoint < 1 or store.storeStarPoint == null}">
										<span class="full">☆☆☆☆☆</span>
									</c:if> 
									<c:if test="${store.storeStarPoint >= 1 and store.storeStarPoint < 2}">
										<span class="full">★☆☆☆☆</span>
									</c:if> 
									<c:if test="${store.storeStarPoint >= 2 and store.storeStarPoint < 3}">
										<span class="full">★★☆☆☆</span>
									</c:if>
									<c:if test="${store.storeStarPoint >= 3 and store.storeStarPoint < 4}">
										<span class="full">★★★☆☆</span>
									</c:if>
									<c:if test="${store.storeStarPoint >= 4 and store.storeStarPoint < 5}">
										<span class="full">★★★★☆</span>
									</c:if> 
									<c:if test="${store.storeStarPoint == 5}">
										<span class="full">★★★★★</span>
									</c:if>
									
									<fmt:formatNumber value="${store.storeStarPoint}" pattern=".0"/>
								</span>
							</li>
							
							<li class="discount-desc">
								<span class="ng-binding">
									<fmt:formatNumber value="${store.storeMinPrice}" pattern="#,###,###"/>원 이상 주문 시 ${store.storeCuponBase}원 할인
								</span>
							</li>
							<li>최소주문금액 
								<span class="ng-binding">
									<fmt:formatNumber value="${store.storeMinPrice}" pattern="#,###,###"/>원
								</span>
							</li>
							<li class="">결제 
								<span class="ico-payment-yogiyo yogiseo-payment">${store.storePaymentMethod}</span>
							</li>
							<li class="delivery-time-tooltip">배달시간 
								<span class="ng-binding">${store.storeDeliveryTime}분 예상
									<button type="button" class="btn-tooltip" data-toggle="tooltip"
											data-html="true" id="delivery-time-tooltip"
											data-placement="bottom"
											data-original-title="최근 주문의 배달시간을 분석한 정보 입니다. <br> 실제 배달시간과는 차이가 있을 수 있습니다.">&nbsp;
									</button>
								</span>
							</li>
							<li class="disposable-menu-tooltip">일회용품
								 <span>일회용품(비닐봉투 등) 구매 비용 추가
									<button type="button" class="btn-tooltip" data-toggle="tooltip"
											data-html="true" id="disposable-menu-tooltip"
											data-placement="bottom"
											data-original-title="일회용품 무상제공 규제 정책에 따라 주문 시,<br>비닐봉투 등의 구매 비용이 자동 추가됩니다.">&nbsp;
									</button>
								</span>
							</li>
							
							<li class="full-w">
								<span class="coupon-base ng-binding">${store.storeCuponBase}할인</span>
								<span class="coupon-base coupon-style1"></span> <!-- 할인율이 0 이상이면 보이기 -->
							</li>
						</ul>
					</div>
					<div class="clearfix"></div>
					
				</div>
				
				<!-- owner_intro -->
				<div class="owner_intro_message">
					<strong>사장님알림</strong>
					<span class="tc" onclick="goInfo()">
						${store.ownerInfo}
					</span>
				</div>
				
				<!-- menu 3 tab -->
				<ul class="nav nav-tabs restaurant-tab">
					<li class="active">
						<a class="tab" id="menu_tab" href="#menu" >메뉴
							<span class="menu-cnt"><c:out value="${store.storeMenuCnt}"/></span>
						</a>
					</li>
						
					<li class="">
						<a class="tab" id="review_tab" href="#review">클린리뷰
							<span class="review-cnt"><c:out value="${store.storeReviewCnt}"/></span>
						</a>
					</li>
					
					<li><a class="tab" id="info_tab" href="#info">정보</a></li>
				</ul>
				</c:forEach>
				
				<div id="navConDiv">
				
				</div>

				<!-- 메뉴 -->
				<jsp:include page="/WEB-INF/views/store/listMenu.jsp"></jsp:include>
				<!-- 리뷰 : 전체 평균 별점 출력 -->
				<div id="review" class="ng-hide">
					<div class="star-point-wrap">
						<div class="inner">
							<div class="restaurant-star-point">
								<!-- 여기2 -->
								
								<c:if test="${reviewAVG.avgReviewStarPoint == null}">
									<strong class="ng-binding">0.0</strong>
								</c:if>
								<strong class="ng-binding">${reviewAVG.avgReviewStarPoint}</strong>
								<span class="star-point">
									<c:if test="${reviewAVG.avgReviewStarPoint < 1 or reviewAVG.avgReviewStarPoint == null}">
										<span class="full">☆☆☆☆☆</span>
									</c:if> 
									<c:if test="${reviewAVG.avgReviewStarPoint >= 1 and reviewAVG.avgReviewStarPoint < 2}">
										<span class="full">★☆☆☆☆</span>
									</c:if> 
									<c:if test="${reviewAVG.avgReviewStarPoint >= 2 and reviewAVG.avgReviewStarPoint < 3}">
										<span class="full">★★☆☆☆</span>
									</c:if>
									<c:if test="${reviewAVG.avgReviewStarPoint >= 3 and reviewAVG.avgReviewStarPoint < 4}">
										<span class="full">★★★☆☆</span>
									</c:if>
									<c:if test="${reviewAVG.avgReviewStarPoint >= 4 and reviewAVG.avgReviewStarPoint < 5}">
										<span class="full">★★★★☆</span>
									</c:if> 
									<c:if test="${reviewAVG.avgReviewStarPoint == 5}">
										<span class="full">★★★★★</span>
									</c:if>
								</span>
							</div>
							
							<!-- 맛,양,배달 평균 별점 출력-->
							<ul class="star-point-list">
								<li>
									<span class="category-tit">맛</span>
																
									 <span class="star-point">
										<c:if test="${reviewAVG.avgReviewMatPoint < 1 or reviewAVG.avgReviewMatPoint == null}">
											<span class="full">☆☆☆☆☆</span>
										</c:if> 
										<c:if test="${reviewAVG.avgReviewMatPoint >= 1 and reviewAVG.avgReviewMatPoint < 2}">
											<span class="full">★☆☆☆☆</span>
										</c:if> 
										<c:if test="${reviewAVG.avgReviewMatPoint >= 2 and reviewAVG.avgReviewMatPoint < 3}">
											<span class="full">★★☆☆☆</span>
										</c:if>											
										<c:if test="${reviewAVG.avgReviewMatPoint >= 3 and reviewAVG.avgReviewMatPoint < 4}">
											<span class="full">★★★☆☆</span>
										</c:if>
										<c:if test="${reviewAVG.avgReviewMatPoint >= 4 and reviewAVG.avgReviewMatPoint < 5}">
											<span class="full">★★★★☆</span>
										</c:if> 
										<c:if test="${reviewAVG.avgReviewMatPoint == 5}">
											<span class="full">★★★★★</span>
										</c:if>
										
										<c:if test="${reviewAVG.avgReviewMatPoint == null}">
											<span class="points">0.0</span>
										</c:if>
										<span class="points">${reviewAVG.avgReviewMatPoint}</span>
									</span>	
								</li>
								
								<li>
									<span class="category-tit">양</span>
										
									<span class="star-point">
									 <c:if test="${reviewAVG.avgReviewYangPoint < 1 or reviewAVG.avgReviewYangPoint == null}">
										<span class="full">☆☆☆☆☆</span>
									</c:if> 
									<c:if test="${reviewAVG.avgReviewYangPoint >= 1 and reviewAVG.avgReviewYangPoint < 2}">
										<span class="full">★☆☆☆☆</span>
									</c:if> 
									<c:if test="${reviewAVG.avgReviewYangPoint >= 2 and reviewAVG.avgReviewYangPoint < 3}">
										<span class="full">★★☆☆☆</span>
									</c:if>
									<c:if test="${reviewAVG.avgReviewYangPoint >= 3 and reviewAVG.avgReviewYangPoint < 4}">
										<span class="full">★★★☆☆</span>
									</c:if>
									<c:if test="${reviewAVG.avgReviewYangPoint >= 4 and reviewAVG.avgReviewYangPoint < 5}">
										<span class="full">★★★★☆</span>
									</c:if> 
									<c:if test="${reviewAVG.avgReviewYangPoint == 5}">
										<span class="full">★★★★★</span>
									</c:if>
									
									<c:if test="${reviewAVG.avgReviewYangPoint == null}">
										<span class="points">0.0</span>
									</c:if>
									<span class="points">${reviewAVG.avgReviewYangPoint}</span>
								</span>
										
								</li>
									
								<li>
									<span class="category-tit">배달</span>
										
									 <span class="star-point">
									 	<c:if test="${reviewAVG.avgReviewBaedalPoint < 1 or reviewAVG.avgReviewBaedalPoint == null}">
											<span class="full">☆☆☆☆☆</span>
										</c:if> 
										<c:if test="${reviewAVG.avgReviewBaedalPoint >= 1 and reviewAVG.avgReviewBaedalPoint < 2}">
											<span class="full">★☆☆☆☆</span>
										</c:if> 
										<c:if test="${reviewAVG.avgReviewBaedalPoint >= 2 and reviewAVG.avgReviewBaedalPoint < 3}">
											<span class="full">★★☆☆☆</span>
										</c:if>
										<c:if test="${reviewAVG.avgReviewBaedalPoint >= 3 and reviewAVG.avgReviewBaedalPoint < 4}">
											<span class="full">★★★☆☆</span>
										</c:if>
										<c:if test="${reviewAVG.avgReviewBaedalPoint >= 4 and reviewAVG.avgReviewBaedalPoint < 5}">
											<span class="full">★★★★☆</span>
										</c:if> 
										<c:if test="${reviewAVG.avgReviewBaedalPoint == 5}">
											<span class="full">★★★★★</span>
										</c:if>
										
										<c:if test="${reviewAVG.avgReviewBaedalPoint == null}">
											<span class="points">0.0</span>
										</c:if>
										<span class="points">${reviewAVG.avgReviewBaedalPoint}</span>
									</span>
								</li>	
							</ul>
						</div>
					</div>
				
					<!-- 리뷰 개수출력, 사장님 댓글 출력 section -->
					<div class="review-count">
						<!-- 반복문 시작 -->
						<c:forEach items="${getStoreDetail}" var="store">
						<div>
							리뷰 <strong class="ng-binding">${store.storeReviewCnt}</strong>개·사장님댓글
							<strong class="ng-binding">${store.storeReplyCnt}</strong>개
				
							<div class="opt-btn">
								<span>사진리뷰만 </span>
								<div class="switch">
									<input id="cmn-toggle" class="cmn-toggle cmn-toggle-round"type="checkbox"> 
									<label for="cmn-toggle"></label>
								</div>
							</div>
						</div>
						</c:forEach>
						<!-- 반복문 종료 -->
					</div>
				
					<!-- 리뷰 리스트 --------------------------------------------------------------------------------------------------->
					<jsp:include page="/WEB-INF/views/store/listReview.jsp"></jsp:include>
				</div>
				<!-- 가게 정보 - ----------------------------------------------------------------------->
				<jsp:include page="/WEB-INF/views/store/storeInfo.jsp"></jsp:include>
			</div>
			<!-- 주문표 -->
			<jsp:include page="/WEB-INF/views/store/cartOrder.jsp"></jsp:include>
			<!-- //주문표 -->
		</div>

		<div class="up-arrow">
			배달시간 준수, 배달 친절도 등<br> 배달 서비스에 대한 만족도를<br> 평가하는 항목입니다.
		</div>
	
	</div>
<!-- script----------------------------------------------------------------------------------------------------------->
	<script type="text/javascript">
	
		var header = "${_csrf.headerName}"
	    var token = "${_csrf.token}"
		var param= {}
	    
		$(document).ready(function(){
			// 메뉴 카테고리 버튼 클릭시 해당 카테고리 메뉴 보이도록
			$(".pull-right").click(function(){
				
				// $(this).parent().parent().parent().parent().children('.panel-collapse').toggleClass('ng-hide').toggleClass('in')
				// $(this).parent().parent().parent().parent().children('.panel-collapse').slideToggle()
				$(this).closest('.panel').find('.panel-collapse').slideToggle()
				// $(this).closest('.panel').children('.panel-collapse').toggle()
				
				// $("#menu_in").toggleClass('ng-hide'); 			
				$(this).toggleClass('icon-arr-up'); 			
				$(this).toggleClass('icon-arr-down'); 			
			});
			
			$('#menu_tab').click(function(e){ // 메뉴 탭 클릭시 active, 다른탭들은 안보이게
				e.preventDefault();
				$('.nav-tabs>li:first-child').attr('class', 'active');
				$('.nav-tabs>li:nth-child(2)').attr('class', '');
				$('.nav-tabs>li:nth-child(3)').attr('class', '');
				$('#menu').css('display', 'block');
				$('#review').css('display', 'none');
				$('#info').css('display', 'none');
			});
			
			$('#review_tab').click(function(e){ //리뷰 탭 클릭시 active, 다른탭들은 안보이게
				e.preventDefault();
				$('.nav-tabs>li:nth-child(2)').attr('class', 'active');
				$('.nav-tabs>li:first-child').attr('class', '');
				$('.nav-tabs>li:nth-child(3)').attr('class', '');
				$('#review').css('display', 'block');
				$('#menu').css('display', 'none');
				$('#info').css('display', 'none');
			});
			
			$('#info_tab').click(function(e){ //정보 탭 클릭시 active, 다른탭들은 안보이게
				e.preventDefault();
				$('.nav-tabs>li:nth-child(3)').attr('class', 'active');
				$('.nav-tabs>li:first-child').attr('class', '');
				$('.nav-tabs>li:nth-child(2)').attr('class', '');
				$('#info').css('display', 'block');
				$('#menu').css('display', 'none');
				$('#review').css('display', 'none');
			});
			
		});
	  
		// 리뷰 더 보기
		var page = 2
		
		function reviewMore() {
			
			param = {
				'storeNo' : '${storeNo}',
				'memberId' : '${session.memberId}',
				'page' : page
			}
			console.log('page: ' + page)		
			$.ajax({
				type: "get",
				url: "/store/reviewAjax",
				data : param,
				beforeSend: function(xhr) {/*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
					xhr.setRequestHeader(header, token);
				},
				success:function(data) {
					console.log(data)
					if( data.includes("EMPTY") ) {
						alert("마지막 페이지입니다.")
						return
					}
					
					$('#review-list').append(data)
					page++
					
				}, error: function() {
				
				}
			});
		}
		
		
		function goInfo() {
			$('#info_tab').trigger('click')
			location.href='#info'
		}
			
	</script>

</body>
</html>