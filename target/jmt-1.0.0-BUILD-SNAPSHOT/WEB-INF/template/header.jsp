<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<div class="yogiyo-header">
	<div id="header" class="header">
		<div role="navigation" class="nav-bar">
			<div class="navigation ver-pc">
				<div class="nav-top clearfix">
					
					<h1 class="logo pull-left" onclick="window.location.href='/'">요기요</h1>
					<div id="cart" class="pull-right">
						<span class="gps-status">효성동</span> 
						<a class="visible-xs"> 
							<span class="ico-set-pic"></span>
						</a> 
						<a id="button-cart" href="" class="visible-xs"> 
							<span class="ico-cart"></span> 
							<span class="badge">0</span>
						</a>
							
						<!-- 로그인 이전  -->
						<sec:authorize access="isAnonymous()">	
							<button type="button" class="btn btn-login" onclick="window.location.href='../member/login.noSearchLayout'">로그인</button>
							<button type="button" class="btn btn-join" onclick="window.location.href='../path/pathJoin.noSearchLayout'">회원가입</button>
						</sec:authorize>
								
						<!-- 로그인 이후 -->
						<%-- <sec:authorize access="isAuthenticated()"> --%>
						<sec:authorize access="hasAnyRole('ROLE_MEMBER')"> <!-- MEMBER 회원으로 로그인시 -->
							<button type="button" class="btn btn-myPage" onclick="window.location.href='../member/memberMyPage.noSearchLayout'">my</button>
							<button type="button" class="btn btn-logout" onclick="window.location.href='../member/logout.noSearchLayout'">로그아웃</button>
							<button type="button" class="btn btn-warning" onclick="window.location.href='/store/storeDetail/${sessionScope.memberId}'">주문표</button>
						</sec:authorize>
							
						<sec:authorize access="hasAnyRole('ROLE_OWNER')"> <!-- OWNER 회원으로 로그인시 -->
							<button type="button" class="btn btn-myPage" onclick="window.location.href='../owner/ownerMyPage.noSearchLayout'">my</button>
							<button type="button" class="btn btn-logout" onclick="window.location.href='../owner/ownerLogout.noSearchLayout'">로그아웃</button>
						</sec:authorize>					
						
						<sec:authorize access="hasAnyRole('ROLE_ADMIN')"> <!-- ADMIN 회원으로 로그인시 -->
							<button type="button" class="btn btn-myPage" onclick="window.location.href=''">menu</button>
							<button type="button" class="btn btn-logout" onclick="window.location.href='../owner/ownerLogout.noSearchLayout'">로그아웃</button>
						</sec:authorize>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
	function printCart(cart) {
		console.log(cart);
		$("button[class='btn-warning']").val(주문표 +(cart.cartAmount));
	}
</script>

