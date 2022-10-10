<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!-- 클린리뷰 -------------------------------------------------------------------->
<c:if test="${empty getReviewList}">
	EMPTY
</c:if>
<c:forEach items="${getReviewList}" var="review">
	<li class="list-group-item star-point"
		on-finish-render="scrollCartArea()">
		<div>
			<span class="review-id">${review.memberId}</span> 
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
						<!-- Repeat: img in review.review_images -->
						<div class="info" style="width: 628px; height: 313px; margin-right: 1px;">
<!-- 								 style="visibility: visible; width: 628.016px; height: 380px; top: 0px;"> -->
							<img class="logo" alt="리뷰이미지" src="${review.reviewImg}" 
								 style="visibility: visible; width: 628.016px; height: 380px; top: 0px;">
						</div> 
						<!-- end Repeat: img in review.review_images -->
					</td>
				</tr>
			</tbody>
		</table> 
		
		<!-- 주문한 메뉴 -->
		<div class="order-items default">${review.reviewMenuName}</div> 
		<!-- 리뷰 콘텐트 -->
		<p class="review-content ng-binding">${review.reviewContent}</p>
	</li>
	<!-- OWNER회원일 경우 답글달기 버튼 출력 -->
	<sec:authorize access="hasRole('ROLE_OWNER')">
		<td><a href="/ownerReply/createReply?reviewNo=${review.reviewNo}&storeNo=${review.storeNo}&ownerId=${sessionScope.ownerId}"
			   class="btn btn-primary" id="btn btn_reply">댓글등록</a></td>
			   
	</sec:authorize>
	<!-- 사장 댓글 출력하는 반복문 -->
	<c:forEach items="${getownerReply}" var="reply">
		<tr id="replyDeco">
			<c:if test="${reply.ownerReplyNo != null}">
				<c:if test="${reply.reviewNo == review.reviewNo}">
					<th>
						<sec:authorize access="hasAnyRole('ROLE_MEMBER', 'ANONYMOUS')">
							사장님 <br>
						</sec:authorize> 
						<sec:authorize access="hasAnyRole('ROLE_OWNER', 'ROLE_ADMIN')">
							${reply.ownerId}<br>
						</sec:authorize> 
						${reply.ownerReplyDate} <br><br> 
						${reply.ownerReplyContent}
					</th>
					<th></th>
					<th></th>
				</c:if>
			</c:if>
		</tr>
	</c:forEach>
</c:forEach>
