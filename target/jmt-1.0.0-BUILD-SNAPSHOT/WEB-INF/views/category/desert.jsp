<%@ page language="java" contentType="text/html; charset=UTF8" pageEncoding="UTF8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<!DOCTYPE html>

<html>
<head>
	<meta charset="UTF8">
	<title>요기냐?</title>
	<link rel="appletouchiconprecomposed" href="https://www.yogiyo.co.kr/mobile/image/app_128x128.p" />
	<link rel="appletouchiconprecomposed" sizes="144x144" href="https://www.yogiyo.co.kr/mobile/image/app_144x144.p" />
	<link rel="icon" type="image/xicon"  href="https://www.yogiyo.co.kr/mobile/image/favicon.ico" />
	<link href="../resources/css/common/mainCss.css" rel="stylesheet" type="text/css" />
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	
	<style>
		.no_review{display: none;}
		.page_container{
			display: flex;
			justify-content: center;
			align-items: center;
		}
		.paging {
			float: left;
			font-size: 16px;
			padding: 6px;
			margin-bottom: 30px;
		}
		.btn-paging{
			color: white;
		}
		.btn-paging:link, .btn-paging:visited {
		    background-color: #FFA500;
		    padding: 5px 15px;
		    text-align: center;
		    text-decoration: none;
		    display: inline-block;
		}
 		.btn-paging:hover, .btn-paging:active {
    		background-color: #fa0050;
		}
	</style>
</head>
<body>
<!-- listAll----------------------------------------------------------------------------------------------------------->
	<div id="content" class="container-fluid">
		<div class="content">
		
			<div class="row restaurant-list-info">
				<!-- category-menu--------------------------------------------------------------------------------------------------------------->
				<c:import url="/include/categoryMenu"></c:import>
					
				<div class="list-option">
					<div class="list-option-inner">
						<select class="form-control" onchange="if(this.value) location.href=(this.value);">
							<option value="/category/desert" selected>기본 정렬순</option>
							<option value="/category/desertStarSort">별점순</option>
							<option value="/category/desertReviewSort">리뷰 많은순</option>
						</select> <i class="arr-down"></i>
					</div>
				</div>
			</div>

			<div>
				<div>
					<div class="ranking-guide">
						<p>우리동네 플러스
							<button type="button" class="btn-tooltip ad"
									data-toggle="tooltip" data-html="true" id="adtooltip"
									data-placement="bottom" title=""
									data-original-title="요기요와 계약된 우리동네 플러스 음식점 광고 영역입니다.
		        			<br>음식점 이름은 사업자등록증 상호와 다를 수 있습니다.">&nbsp;
							</button>
						</p>
					</div>
					
					
					<div class="restaurant-list">
						<c:forEach items="${listDesert}" var="store">
						<div class="col-sm-6">
							<div class="item clearfix" style="cursor: pointer;">
								<table>
									<tbody>
										<tr onclick="location.href='/store/storeDetail?storeNo=${store.storeNo}'">
											<td>
												<img class="logo" alt="가게로고" src="${store.storeLogoUrl}">
											</td>
											<td>
												<div class="restaurants-info" >
													<div class="restaurant-name" title="${store.storeName}">${store.storeName}</div>
													<div class="stars">
														<span> 
															<span class="ico-star1">★  ${store.storeStarPoint}</span>
														</span> 
														<span class="review_num"> 리뷰  ${store.storeReviewCnt}</span> 
														<span class="review_num"> 사장님댓글  ${store.storeReplyCnt}</span> 
														<span class="no_review"> 첫번째 리뷰를 남겨주세요! </span>
													</div>
													
													<ul>
														<li class="payment-methods yogiseo-payment">${store.storePaymentMethod}</li>
														<li class="min-price">${store.storeMinPrice}원 이상 배달</li>
														<li class="full-w">
															<span class="coupon-base">${store.storeCuponBase}원 할인</span> 
															<span class="coupon-base coupon-style1">추가할인 0%</span>															
														</li>
														
														<li class="delivery-time">${store.storeDeliveryTime}분 예상</li>
													</ul>
												</div>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
						</c:forEach>
					</div>
				</div>
			</div>

			<!-- <div class="clearfix empty-restaurant ng-hide" ng-show="isFirstQuery">레스토랑 리스트를 불러오는 중입니다.</div> -->
			<c:if test="${empty listDesert}">
				<div class="clearfix empty-restaurant">
					아직 등록된 음식점이 없습니다.<br>빠른 시일 내에 서비스를<br>제공할 수 있도록 하겠습니다.
				</div>
			</c:if>
		</div>
		<div class="page_container">
		  <ul>
		    <c:if test="${pageMaker.prev}">
		    	<li class="paging"><a class="btn-paging" href="/category/desert${pageMaker.makeQuery(pageMaker.startPage - 1)}">이전</a></li>
		    </c:if> 
		
		    <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
		    	<li class="paging"><a class="btn-paging" href="/category/desert${pageMaker.makeQuery(idx)}">${idx}</a></li>
		    </c:forEach>
		
		    <c:if test="${pageMaker.next && pageMaker.endPage > 0}">
		    	<li class="paging"><a class="btn-paging" href="/category/desert${pageMaker.makeQuery(pageMaker.endPage + 1)}">다음</a></li>
		    </c:if> 
		  </ul>
		</div>
	</div>
	
<!-- script----------------------------------------------------------------------------------------------------------->
	<script type="text/javascript">

	</script>
	
</body>
</html>

