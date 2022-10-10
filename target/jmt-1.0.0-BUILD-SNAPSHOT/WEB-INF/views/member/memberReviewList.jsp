<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>리뷰관리</title>
	<link href="/resources/css/common/mainCss.css" rel="stylesheet" type="text/css" />
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/js/toastr.min.js"></script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/css/toastr.min.css">
	<style>
		.page_container {
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
		
		.btn-paging {
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
		
		
		.review-box {
			display: flex;
			justify-content: space-between;
			align-items: center;
		}
		
		.review-box.start {
			justify-content: flex-start;
		}
		
		.review-box .review-item {
			display: flex;
			justify-content: center;
			align-items: flex-start;
			flex-direction: column;
		}
		.review-box .review-item .review-img {
			display: flex;
			justify-content: center;
			align-items: center;
		}
		.review-box .review-item .review-content {
			display: flex;
			justify-content: flex-start;
			align-items: center;
		}
		.review-box .review-item .review-content .restaurant-name {
			font-size: 20px;
		}
		.review-box .review-item .review-content .order-date {
			font-size: 16px;
		}
		.review-box .review-item .review-content .stars {
			font-size: 20px;
		}
		.review-box .review-item .review-content .star-point {
			font-size: 20px;
		}
		.review-box .review-item .review-content .star-point span {
			font-size: 18px !important;
		}
		
		.review-box .review-item .item-between {
			display: flex;
			justify-content: space-between;
			align-items: center;
			width: 100%;
		}
		
		.logo-item {
			width: 20%;
	    	align-items: center !important;
		}
		
		.content-item {
			width: 80%;
		}
	
		.review-img-box {
			padding: 12px;
		}	
		.review-img-box img {
			max-height: 100px !important;
			max-width: 100%;
		}
		
		.review-content-box {
			padding: 10px 12px;
		}
		
		
		.review-box .review-button-box {
			justify-content: center !important;
			align-items: center !important;
			height: 100%;
		}
		.review-box .review-button-box .review-content {
			margin: 20px 0;
		}
		.review-menu{
			font-size: 12px;
			color: #f0ad4e;
		}
		.management-header{
			display: flex;
			justify-content: space-between;
			align-items: center;
			width: 100%;
		}
		.review-header{
			display: block;
			padding: 15px 30px;
			margin : 0px 0px;
			background-color: #FA0050;
			font-size: 20px;
			letter-spacing: -1px;
			color: #ffffff;
			font-weight: normal;
			width: 97%;
		}
		.btn-cancle{
			width: 3%;
			margin-right: 3px;
		}
	</style>
</head>

<body>

	<div>
		<div class="management-header" style="margin: 0px; width: 100%">
			<h1 class="review-header">리뷰관리</h1>
			<button class="btn btn-cancle" onclick="location.href='/member/memberMyPage'">
				<img src="https://www.yogiyo.co.kr/mobile/image/ic_list_d_arrow.png?v=103bbdfa8d07ae1afa6c12bd84990fec7622a2f8" alt="뒤로가기"/>
			</button>
		</div>
		
		<div>

			<div class="restaurant-list2 container">	
				<div class="row">
					<!-- 주문한 메뉴중 이미 리뷰를 작성한 항목 -->
					<div class="ranking-guide">
						<p>작성한 리뷰</p>
					</div>
					<div class="col-sm-12">
					
						<c:if test="${empty getMemberReview}">
							<div class="clearfix empty-restaurant">
								등록된 리뷰가 없습니다.<br>리뷰를 작성해보세요.
							</div>
						</c:if>
							
						<!-- 반복시작 -->
						<c:forEach items="${getMemberReview}" var="memberReview">
						<div class="item clearfix">
							<div class="review-box">
								<div class="review-item logo-item">
									<div class="review-img-box">
										<img class="logo" alt="가게로고" src="${memberReview.reviewImg}" height="500px" width="400px"/>
									</div>
								</div>
								
								<div class="review-item content-item">
									<div class="review-content item-between">
										<div class="restaurant-name" 
											 onclick="location.href='/store/storeDetail?storeNo=${memberReview.storeNo}'"
											 style="cursor: pointer;">
											${memberReview.order.orderStoreName}
											<span class="ico-arrow"></span>
										</div>
										
										<input type="hidden" id="reviewNo" name="reviewNo" value="${memberReview.reviewNo}"/>
										<input type="hidden" id="storeNo" name="storeNo" value="${memberReview.storeNo}"/>
										<a id="del_${memberReview.reviewNo}_btn" class="btn btn-delete" data-reviewNo="${memberReview.reviewNo}">삭제</a>
									</div>
									
									<div class="review-content">
										<span class="order-date">${memberReview.order.orderDate}</span> 
									</div>
									<div class="review-content">
										
										<div class="star-point">
											<span class="category"> 
												<span class="category-tit">맛</span>
												<span class="full">★</span> 
												<span class="points">${memberReview.reviewMatPoint}</span>
														
												<span class="category-tit">양</span> 
												<span class="full">★</span> 
												<span class="points">${memberReview.reviewYangPoint}</span> 
														
												<span class="category-tit">배달</span> 
												<span class="full">★</span> 
												<span class="points">${memberReview.reviewBaedalPoint}</span> 
												<span class="btn-tooltip" id="review-tooltip"></span>
											</span>
										</div>
									</div>
									
								</div>
	
							</div>
							<div class="review-content-box">
								<div class="review-content">
									<p class="review-content">${memberReview.reviewContent}</p>
								</div>
								
								<div class="review-content">
									<p class="review-menu">${memberReview.reviewMenuName}</p>
								</div>
							</div>		
						</div>
						</c:forEach>
						<!-- 반복종료 -->	
					</div>
				</div>
			</div>
		</div>
		<div class="page_container">
		  <ul>
		    <c:if test="${pageMaker.prev}">
		    	<li class="paging"><a class="btn-paging" href="/member/memberReviewList${pageMaker.makeQuery(pageMaker.startPage - 1)}">이전</a></li>
		    </c:if> 
		
		    <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
		    	<li class="paging"><a class="btn-paging" href="/member/memberReviewList${pageMaker.makeQuery(idx)}">${idx}</a></li>
		    </c:forEach>
		
		    <c:if test="${pageMaker.next && pageMaker.endPage > 0}">
		    	<li class="paging"><a class="btn-paging" href="/member/memberReviewList${pageMaker.makeQuery(pageMaker.endPage + 1)}">다음</a></li>
		    </c:if> 
		  </ul>
		</div>
		
	</div>


	<script>
										
		// 리뷰 삭제
		$(".btn-delete").click(function() {

			var reviewNo = $(this).attr('data-reviewNo')

			var ok = confirm("리뷰를 삭제하시면 다시 작성할 수 없습니다. 그래도 삭제하시겠습니까?")
			var target = $(this).closest(".clearfix");
			console.log(reviewNo)

			if (ok) {
	
				var token = "${_csrf.token}"
				var header = "${_csrf.headerName}"

				$.ajax({
					url : "/review/deleteReview",
					type : "post",
					data : {
						'reviewNo' : reviewNo
					},
					beforeSend : function(xhr) { /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
						xhr.setRequestHeader(header, token);
					},
					success : function(data) {
						console.log(data)
						toastr.success("선택한 리뷰가 삭제되었습니다.", "서버 메시지");
						target.remove()
					}
				});
			}
		});
	</script>
</body>
</html>