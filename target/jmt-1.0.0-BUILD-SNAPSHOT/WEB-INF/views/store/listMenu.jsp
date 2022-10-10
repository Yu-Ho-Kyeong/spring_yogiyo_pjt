<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<div id="menu" class="menu-list">
	<div class="panel-group" data-allow-multiple="true">
		<div class="panel panel-default">
			<div class="panel-collapse collapse in btn-scroll-container">
				<div class="panel-body photo-menu-container">
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
													<span class="menu-price">
														<fmt:formatNumber value="${menu.menuPrice}" pattern="#,###,###" />원	
													</span> 
												</div>											
											</td>
											<td class="photo-area">										
												<img class="logo" alt="menuUrl" src="${menu.menuUrl}">
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

		<div class="panel panel-default">
			<div class="panel-collapse collapse in btn-scroll-container ng-hide" id="menu_in">
				<div class="panel-body">
					<ul class="sub-list" id="sub-list">
						<!-- 반복시작 : 메뉴 in 메뉴카테고리 -->
						<c:forEach items="${getMenuList}" var="menu">
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
												</div>
									
												<div class="add-cart">
												<a class="btn-add-cart" 
												   data-menuName="${menu.menuName}"
												   data-menuPrice="${menu.menuPrice}"
												   data-menuNo="${menu.menuNo}"
												   data-storeNo="${menu.storeNo}">주문표에 담기</a>
												</div>
											</td>
											<td class="photo-area ">
												<img class="logo" alt="menuUrl" src="${menu.menuUrl}"
													 style="width:112px; height:80px">
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
	</div>
</div>