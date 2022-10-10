<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<div id="info" class="info-list ng-hide">
	<c:forEach items="${getStoreDetail}" var="store">
		<div class="info-item">
			<div class="info-item-title info-icon">사장님알림</div>
			<table class="info-images half">
				<tbody>
					<tr>
						<td>
							<!-- ngRepeat: img in restaurant_info.introduction_by_owner.images -->
							<div class="ng-scope">
								<img data-index="0" data-url="" class="info-img" src="">
							</div> <!-- end ngRepeat: img in restaurant_info.introduction_by_owner.images -->
						</td>
					</tr>
				</tbody>
			</table>
			<!-- end ngIf: restaurant_info.introduction_by_owner.images.length == 4 -->
			<div class="info-text">${store.ownerInfo}</div>
		</div>
		<!-- 업체정보 ------------------------------------------------------------------------>
		<div class="info-item">
			<div class="info-item-title info-icon1">업체정보</div>
			<p>
				<i>영업시간</i> 
				<span class="tc">${store.storeOpenTime}~${store.storeCloseTime}</span>
			</p>
			<p class="">
				<i>전화번호</i> 
				<span class="tc">${store.storeTel}</span>
			</p>
			<p class="">
				<i>주소</i> 
				<span class="tc">${store.storeAddress}</span>
			</p>
			<p class="">
				<i>부가정보</i> 
				<span class="cesco info-icon5 tc">세스코멤버스 사업장</span>
			</p>
		</div>

		<div class="info-item">
			<div class="info-item-title info-icon2">결제정보</div>
			<p>
				<i>최소주문금액</i> 
				<span class="tc">
					<fmt:formatNumber value="${store.storeMinPrice}" pattern="#,###,###"/>원
				</span>
			</p>
			<p>
				<i>결제수단</i> <span class="tc">
					<span class="ico-payment-yogiyo yogiseo-payment">${store.storePaymentMethod}</span>
				</span>
			</p>
		</div>

		<div class="info-item">
			<div class="info-item-title info-icon3">사업자정보</div>
			<p>
				<i>상호명</i> <span class="tc">${store.storeName}</span>
			</p>
		</div>
	</c:forEach>
</div>
