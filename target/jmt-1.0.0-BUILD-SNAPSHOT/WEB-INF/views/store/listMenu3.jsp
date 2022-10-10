<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<div id="menu" class="menu-list">
	<div class="panel-group" data-allow-multiple="true" bs-collapse="">
		<!-- ngRepeat: category in restaurant.menu -->
		<div class="panel panel-default">
			<div class="panel-heading">
				<h4 class="panel-title ng-hide">
					<a class="clearfix"> 
						<span class="menu-name pull-left">Photo Menu Items</span> 
						<i class="pull-right"></i>
					</a>
				</h4>
			</div>

			<div class="panel-collapse collapse in btn-scroll-container">
				<div class="panel-body photo-menu-container">
					<div class="category-desc ng-hide"></div>

					<div>
						<a class="btn-scroll left"></a> <a class="btn-scroll right"></a>
						<!-- 메인 메뉴 -->
						<div class="photo-slide" style="width: 896px;">
							<!-- 반복시작 : 메뉴리스트 : 메인메뉴 -->
							<c:forEach items="${getMenuList}" var="menu">
								<c:if test="${menu.menuMain == 'y'}">
									<div class="photo-menu">
										<!-- if menu.soldout -->
										<div class="photo" style="background-image: url(&quot;/img/${menu.menuUrl}&quot;),
																		 url(&quot;img/ic_photomenu_default.png&quot;);"></div>
																		 <!-- 썸네일로고 -->
										<%-- <img class="logo" alt="메뉴url" src="/menu/img?fileName=${menu.menuUrl}"> --%>
										<div class="menu-name">${menu.menuName}</div>
										<div class="menu-price">
											<span class="ng-binding">
												<fmt:formatNumber value="${menu.menuPrice}" pattern="#,###,###" />원	
											</span> 
											<span class="color-price ng-hide">
												<fmt:formatNumber value="${menu.menuPrice}" pattern="#,###,###" />원	
											</span>
											
											<div class="menu-discount ng-hide">개당 
												<fmt:formatNumber value="${menu.menuDiscount}" pattern="#,###,###" />원  할인
											</div>
										</div>
									</div>
								</c:if>
							</c:forEach>
							<!-- 반복종료 : 메뉴리스트 : 메인메뉴 -->
						</div>
					</div>
					
					<!-- 메뉴 sub-list -->
					<ul class="sub-list ng-hide">
						<!-- 반복시작 : 메뉴 in 메뉴카테고리 -->
						<c:forEach items="${getMenuList}" var="menu">
							<li class="photo-menu">
								<table>
									<tbody>
										<tr>
											<td class="menu-text">
												<div class="promotion-info">
													<span class="coupon-base">요기서결제시 할인</span>
												</div>
												<div class="menu-name">${menu.menuName}</div>
												<div class="menu-desc">${menu.menuInfo}</div>
												<div class="menu-price">
													<span class="ng-binding">
														<fmt:formatNumber value="${menu.menuPrice}" pattern="#,###,###" />원	
													</span> 
													<span class="color-price ng-hide">
														<fmt:formatNumber value="${menu.menuPrice}" pattern="#,###,###" />원	
													</span>
												</div>
												<div class="menu-discount ng-hide">개당 
													<fmt:formatNumber value="${menu.menuDiscount}" pattern="#,###,###" />원 할인
												</div>
												
												<div class="menu-stock ng-hide">(${menu.menuStock}개 남음)</div>
											</td>
											<td class="photo-area">
												<div class="photo" style="background-image: url(&quot;/img/${menu.menuUrl}&quot;);"></div>
											<%-- <img class="logo" alt="메뉴url" src="/store/img?fileName=${menu.menuUrl}"> --%>
											</td>
										</tr>
									</tbody>
								</table>
							</li>
						</c:forEach>
						<!-- 반복종료 : 메뉴 in 메뉴카테고리 -->
					</ul>
				</div>
			</div>
		</div>

		<!-- 메뉴 카테고리 -->
		<c:forEach items="${getMenuCategory}" var="menuCate">
			<!-- 반복시작 : 메뉴카테고리 -->
			<div class="panel panel-default">
				<div class="panel-heading">
					<h4 class="panel-title">
						<a class="clearfix" id="btn-menu-category"> 
						<span class="menu-name pull-left pop-menu">${menuCate.menuCategoryName}</span>
						<i class="pull-right icon-arr-up"></i>
						</a>
					</h4>
				</div>

				<div class="panel-collapse collapse in btn-scroll-container ng-hide" id="menu_in">
					<div class="panel-body">
						<div class="category-desc ng-hide">${menuCate.menuCategoryInfo}</div>
						<div class="ng-hide">
							<a class="btn-scroll left"></a> 
							<a class="btn-scroll right"></a>

							<div class="photo-slide" style="width: 896px;">
								<!-- 메뉴 리스트 in 메뉴 카테고리 ----------------------------------------------------------------------->
								<!-- 반복시작 : 메뉴 in 메뉴카테고리 -->
								<c:forEach items="${getMenuList}" var="menu">
									<c:if test="${menuCate.menuCategoryNo == menu.menuCategoryNo}">
										<div class="photo-menu">
											<!-- ngIf: item.soldout -->
											<div class="promotion-info">
												<span class="coupon-base coupon-delivery-discount">${menu.menuPromotion} 할인</span>
											</div>
											<div class="photo"
												style="background-image: url(&quot;/img/${menu.menuUrl}&quot;);"></div>
											<div class="menu-name">${menu.menuName}</div>
											<div class="menu-price">
												<span class="ng-binding">
													<fmt:formatNumber value="${menu.menuPrice}" pattern="#,###,###" />원	
												</span> 
												<span class="color-price ng-hide">
													<fmt:formatNumber value="${menu.menuPrice}" pattern="#,###,###" />원	
												</span>
												<div class="menu-discount ng-hide">개당 
													<fmt:formatNumber value="${menu.menuDiscount}" pattern="#,###,###" />원 할인
												</div>
												
											</div>
										</div>
									</c:if>
								</c:forEach>
								<!-- 반복종료 : 메뉴 in 메뉴카테고리 -->
							</div>
						</div>
						<!-- 메뉴 in 메뉴 카테고리  ----------------------------------------------------------------------->
						<ul class="sub-list" id="sub-list">
							<!-- 반복시작 : 메뉴 in 메뉴카테고리 -->
							<c:forEach items="${getMenuList}" var="menu">
								<c:if test="${menuCate.menuCategoryNo == menu.menuCategoryNo}">
									<li class="photo-menu">
										<table>
											<tbody>
												<tr>
													<td class="menu-text">
														<div class="promotion-info">
															<span class="coupon-base">${menu.menuPromotion}</span>
														</div>
														<div class="menu-name">${menu.menuName}</div>
														<div class="menu-desc">${menu.menuInfo}</div>
														<div class="menu-price">
															<span class="ng-binding">
																<fmt:formatNumber value="${menu.menuPrice}" pattern="#,###,###" />원 
															</span> 
															<span class="color-price ng-hide">
																<fmt:formatNumber value="${menu.menuPrice}" pattern="#,###,###" />원
															</span>
														</div>
														<div class="menu-discount ng-hide">개당 
															<fmt:formatNumber value="${menu.menuDiscount}" pattern="#,###,###" />원  할인
														</div>
														<div class="menu-stock ng-hide">(${menu.menuStock}개 남음)</div>
														<div class="add-cart">
															<a class="btn-add-cart" 
															   data-menuName="${menu.menuName}"
															   data-menuPrice="${menu.menuPrice}"
															   data-menuNo="${menu.menuNo}"
															   data-storeNo="${menu.storeNo}">주문표에 담기</a>
														</div>
													</td>
													<td class="photo-area ng-hide">
														<div class="photo" style="background-image: url(&quot;/img/${menu.menuUrl}&quot;);"></div>
													</td>
												</tr>
											</tbody>
										</table>
									</li>
								</c:if>
							</c:forEach>
							<!-- 반복종료 : 메뉴 in 메뉴카테고리 -->
						</ul>
					</div>
				</div>
			</div>
		</c:forEach>
		<!-- 반복종료 : 메뉴카테고리 -->
	</div>
</div>