<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link href="/resources/css/common/mainCss.css" rel="stylesheet" type="text/css" />
	<style>
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
	<div id="list">
		<table class="table table-hover">
			<tr>
				<th>주문날짜</th>
				<th>가게명</th>
				<th>주문메뉴</th>
				<th>가격</th>
				<th>리뷰</th>
			</tr>

			<!-- 반복시작 -->
			<c:forEach items="${memberOrderList}" var="memberOrder">
				<tr>
					<td>${memberOrder.orderDate}</td>
					<td onclick="location.href='/store/storeDetail?storeNo=${memberOrder.storeNo}'"
						style="cursor:pointer;">
						${memberOrder.orderStoreName}
					</td>
					<td>${memberOrder.orderMenu}</td>
					<td><fmt:formatNumber value="${memberOrder.orderTotalPrice}" pattern="#,###,###" />원</td>
					
					<td>
						<c:if test="${memberOrder.orderEnabled == 0}">
							<a href="/review/createReview?storeNo=${memberOrder.storeNo}&orderNo=${memberOrder.orderNo}">리뷰 등록</a>
						</c:if>
						<c:if test="${memberOrder.orderEnabled != 0}">
							<a href="/member/memberReviewList">리뷰 삭제하기</a>
						</c:if>
					</td>
				</tr>
			</c:forEach>
			<!-- 반복종료 -->
			
			<tr>
				<td></td>
				<td></td>
				<td>
					<c:if test="${empty memberOrderList}">
						<div class="clearfix empty-restaurant">
							주문내역이 존재하지 않습니다.<br>여기냐를 이용해서 음식을 주문해보세요.
						</div>
					</c:if>
				</td>
				<td></td>
				<td></td>
			</tr>
			
		</table>
		
		<div class="page_container">
		  <ul>
		    <c:if test="${pageMaker.prev}">
		    	<li class="paging"><a class="btn-paging" href="/member/memberOrderList${pageMaker.makeQuery(pageMaker.startPage - 1)}">이전</a></li>
		    </c:if> 
		
		    <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
		    	<li class="paging"><a class="btn-paging" href="/member/memberOrderList${pageMaker.makeQuery(idx)}">${idx}</a></li>
		    </c:forEach>
		
		    <c:if test="${pageMaker.next && pageMaker.endPage > 0}">
		    	<li class="paging"><a class="btn-paging" href="/member/memberOrderList${pageMaker.makeQuery(pageMaker.endPage + 1)}">다음</a></li>
		    </c:if> 
		  </ul>
		</div>
		
	</div>


<script>
	
</script>
</body>
</html>