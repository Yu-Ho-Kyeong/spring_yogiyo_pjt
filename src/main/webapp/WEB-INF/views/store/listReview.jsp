<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>	

<ul id="review-box" class="list-group review-list">
	<c:if test="${empty getReviewList}">
		<li class="list-group-item ng-hide">
			<p class="review-empty clearfix">주문후 첫번째 리뷰를 남겨보세요.</p>
		</li>
	</c:if>
	<div id="review-list">
	 	<!-- 반복문 시작 -->
		<c:forEach items="${getReviewList}" var="review">
			<li class="list-group-item star-point" on-finish-render="scrollCartArea()">
				<div>
					<span class="review-id">${review.memberId}님</span> 
					<span class="review-time">${review.reviewDate}</span> 
					<a href="" class="btn-report">신고</a>
				</div>

				<div>
					<div class="star-point">
						<span class="category"> 
							<span class="category-tit">맛</span>
							<span class="full">★</span> 
							<span class="points">${review.reviewMatPoint}</span>
							
							<span class="category-tit">양</span> 
							<span class="full">★</span> 
							<span class="points">${review.reviewYangPoint}</span> 
							
							<span class="category-tit">배달</span> 
							<span class="full">★</span> 
							<span class="points">${review.reviewBaedalPoint}</span> 
							<span class="btn-tooltip" id="review-tooltip"></span>
						</span>
					</div>
				</div>

				<table class="info-images half" style="width: 628px;">
					<tbody>
						<tr>
							<td>					
								<c:if test="${not empty review.reviewImg}">
									<div class="info" style="width: 628px; height: 313px; margin-right: 1px;">
										<img class="logo" alt="리뷰이미지" src="${review.reviewImg}" 
											 style="visibility: visible; width: 628.016px; height: 380px; top: 0px;">
									</div> 
								</c:if>
							</td>
						</tr>
					</tbody>
				</table> 
				
				<!-- 주문한 메뉴 -->
				<div class="order-items default">${review.reviewMenuName}</div> 
				<!-- 리뷰 콘텐트 -->
				<p class="review-content">${review.reviewContent}</p>
				
				<!-- OWNER회원일 경우 답글달기 버튼 출력 -->
				<sec:authorize access="hasRole('ROLE_OWNER')">
					<c:if test="${ownerReplyNo == 0}">
						<td>
							<a href="/ownerReply/createReply?reviewNo=${review.reviewNo}&storeNo=${review.storeNo}&ownerId=${sessionScope.ownerId}"
							   class="btn btn-primary" id="btn btn_reply">댓글등록</a>
						</td>
						<input type="hidden" name="storeNo" value="${review.storeNo}" />
						<input type="hidden" name="reviewNo" value="${review.reviewNo}" />
					</c:if>
				</sec:authorize>
				
				<!-- 사장님 댓글 -->
				<c:forEach items="${getOwnerReply}" var="reply">		
					<c:if test="${reply.ownerReplyNo != null}">
						<c:if test="${reply.reviewNo == review.reviewNo}">
		 					<div class="review-answer">
								<div>
									<sec:authorize access="hasAnyRole('ROLE_OWNER')">
										<span class="owner-review-id">${reply.ownerId}</span>
									</sec:authorize>
									
									<sec:authorize access="hasAnyRole('ROLE_MEMBER', 'ANONYMOUS')">
										<span class="owner-review-id">사장님</span>
									</sec:authorize>
												
									<span class="review-time">${reply.ownerReplyDate} </span>
									<a href="" class="btn-report">신고</a>
								</div>
								<p class="owner-reply-content">
									${reply.ownerReplyContent}
								</p>
							</div>
						</c:if>
 	 				</c:if> 
				</c:forEach>
				<!-- 반복 종료 : getOwnerReply -->
			</li>
	
		</c:forEach>

	</div>
	<!-- 리뷰 더보기 ---------------------------------------------------------------------->
	<li class="list-group-item btn-more">
		<a href="javascript:;" onclick="reviewMore()"> 
			<span>더 보기<i class="arr-down"></i></span>
		</a>
	</li>
</ul>

		




	
