<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <link href="../resources/css/common/mainCss.css" rel="stylesheet" type="text/css" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<title>myStoreList</title>
	<style>
		th{
			background-color: #fa0050;
			color: white;
		}
		strong a{
			margnin-top: 5px;
			padding: 10px;
			color: #ff8a00;
		}
		.btn-back{
			font-size: 10px;
			color: grey;
		}
/* 		.store-menu{ */
/* 			margin-left: -50px; */
			
/* 		} */
	
	</style>
</head>
<body>
	<div>
		<table class="table table-hover">
			
			<tr>
				<h5>
					<strong>
						<a href="/owner/ownerMyPage">
							<sec:authentication property= "principal.username" />
						</a>
					</strong>님의 가게목록입니다.
				</h5>
				
				<th></th>
				<th><span class="bar">ㅣ</span>로고<span class="bar">ㅣ</span></th>
				<th><span class="bar">ㅣ</span>가게명 <span class="bar">ㅣ</span></th>
				<th><span class="bar">ㅣ</span>평점<span class="bar">ㅣ</span></th>
				<th><span class="bar">ㅣ</span>리뷰<span class="bar">ㅣ</span></th>
				<th><span class="bar">ㅣ</span>사장님댓글<span class="bar">ㅣ</span></th>
				<th></th>
				<th><span class="bar">ㅣ</span>가게관리<span class="bar">ㅣ</span></th>
				<th></th>
			</tr>
			
			<c:if test="${empty map.list}">
				<tr>
					<td></td>
					<td></td>
					
					<td></td>
					<td></td>
					<td>
						<span class="empty-myStore">
							등록된 가게가 존재하지 않습니다.<br>myPage에서 가게를 등록해주세요.
						</span>
					</td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
				</tr>
			</c:if>
			
			<c:forEach items="${map.list}" var="store">
				<tr>
					<td></td>
<%-- 					<td><img class="logo" alt="가게로고" src="/store/img?fileName=${store.storeLogoUrl}" height="20px" width="30px"/></td> --%>
					<td><img class="logo" alt="가게로고" src="${store.storeLogoUrl}" height="20px" width="30px"/></td>
					
					<td onclick="location.href='/store/storeDetail?storeNo=${store.storeNo}'" style="cursor:pointer;">
						${store.storeName}
					</td>
					<td>
						<span>
							<c:if test="${store.storeStarPoint == 1}">
								<span style="color: #fa0050; font-size: 120%;">★☆☆☆☆</span>
							</c:if>
							<c:if test="${store.storeStarPoint == 2}">
								<span style="color: #fa0050; font-size: 120%;">★★☆☆☆</span>
							</c:if>
							<c:if test="${store.storeStarPoint == 3}">
								<span style="color: #fa0050; font-size: 120%;">★★★☆☆</span>
							</c:if>
							<c:if test="${store.storeStarPoint == 4}">
								<span style="color: #fa0050; font-size: 120%;">★★★★☆</span>
							</c:if>
							<c:if test="${store.storeStarPoint == 5}">
								<span style="color: #fa0050; font-size: 120%;">★★★★★</span>
							</c:if>
							${store.storeStarPoint}점
						</span>
					</td>
					<td>${store.storeReviewCnt}</td>
					<td>${store.storeReplyCnt}</td>
					<td><a class="store-menu" href="/store/deleteStore?storeNo=${store.storeNo}">가게삭제</a></td>
					<td><a class="store-menu" href="/owner/ownerMyStore?storeNo=${store.storeNo}">가게정보 </a></td>
					<td><a class="store-menu" href="/owner/ownerMyMenu?storeNo=${store.storeNo}">메뉴관리</a></td>
				</tr>	
			</c:forEach>
		</table>
	</div>
</body>

<script>

</script>
</html>