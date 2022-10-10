<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>

<c:if test="${empty cartList}">
	<ul class="list-group" id="cartOrderList">
		<c:set var="cart" value="false"/>
		<div class="cart-empty">주문표에 담긴 메뉴가 없습니다.</div>
	</ul>
</c:if>
 
<ul class="list-group" id="cartOrderList">
	<c:forEach items="${cartList}" var="cart">
		<li class="list-group-item clearfix">
			<div class="row">
			
				<div class="menu-name">${cart.menuName}</div>
				
				<div>
					
					<div class="col-xs-6 pull-left">
						<a class="btn btn-del-menu" id="del_${cart.cartNo}_btn" data-cartNo="${cart.cartNo}">삭제</a> 
						<span class="order-price">
							<fmt:formatNumber value="${cart.menuPrice * cart.cartAmount}" pattern="#,###,###" />원
						</span>
					</div>
					<script>
						$("#del_${cart.cartNo}_btn").click(function () {
	                         var confirm_val = confirm("선택한 메뉴를 삭제하시겠습니까?");
	
	                         if (confirm_val) {
								var cartNo = $(this).attr("data-cartNo")
	
	                             $.ajax({
	                                 url: "/cart/delete",
	                                 type: "post",
	                                 data: { cartNo: cartNo },
	                                 beforeSend: function (xhr) {   /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다 (spring boot security 설정부분)*/
	                                     xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	                                 },
	                                 success: function (data) {
	                                   console.log(data);
	                                   cartList()
	                                 }
	                             });
	                         }
	                    });
					</script>
						
					<div class="col-xs-6 text-right">
						<a class="btn btn-minus"></a> 
						<span class="order-num">${cart.cartAmount}</span>
						<a class="btn btn-plus"></a>
						<input type="hidden" id="cartNo" class="cartNo" name="cartNo" value="${cart.cartNo}">
						<input type="hidden" id="menuNo" class="menuNo" name="menuNo" value="${cart.menuNo}">
						<input type="hidden" id="storeNo" class="storeNo" name="storeNo" value="${cart.storeNo}">
					</div>
				</div>
				
			</div>
		</li>
	</c:forEach>
</ul>

<span class="list-group-item cart-total-order-price ng-hide">
	<fmt:formatNumber value="" pattern="#,###,###" />	
</span> 

<script>

	$(function() {
		
		// + 버튼
		$(".btn-plus").on("click", function(e){
			var cartNo = $(this).parent().children('.cartNo').val()
			 plusCart(cartNo)
	
		})
				
		// - 버튼
		$(".btn-minus").on("click", function(e){
			var cartNo = $(this).parent().children('.cartNo').val()
			 minusCart(cartNo)	
			
		})
		
	})
	
	function plusCart(cartNo) {
		var data = {
			cartNo : cartNo,
		};
		
		$.ajax({
			url: '/cart/plus',
			type: 'POST',
			data: data,
			beforeSend: function(xhr) { /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
				xhr.setRequestHeader(header, token);
			},
			success: function(result){
				cartList()
			}
		})
	} 
	
	function minusCart(cartNo) {
		var data = {
			cartNo : cartNo,
		};
		
		$.ajax({
			url: '/cart/minus',
			type: 'POST',
			data: data,
			beforeSend: function(xhr) { /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
				xhr.setRequestHeader(header, token);
			},
			success: function(result){
				cartList()
			}
		})
	} 
	
	function cartList() {
		var token = "${_csrf.token}"
		var header = "${_csrf.headerName}"
		var memberId = '${sessionScope.memberId}'
		var storeNo = "${param.storeNo}"
		var data = {
			memberId : memberId,
			storeNo : storeNo,
		};
		$.ajax({
			url: '/cart/list',
			type: 'GET',
			data: data,
			beforeSend: function(xhr) { /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
				xhr.setRequestHeader(header, token);
			},
			success: function(result){			
				console.log(result)
				$('#cartOrderList').empty()
				$('#cartOrderList').append(result)
				/* 카트에 메뉴가 추가되었을 때만 합계 금액 출력 */
				if($('#cartOrderList').find('li').length > 0){ 
					totalPrice()
					
                }
				
			}
		})
	}
	
	
	// 주문표에 담긴 메뉴 합계 금액 출력
	function totalPrice(){
		var total = 0;
		$("#cartOrderList li").each(function(idx,itm){ // 주문표에 입력된 메뉴 db 반복문
			console.log(itm)
			var price = $(itm).find('.order-price').text().replace(',','');// 11,000 -> 11000 변환
			total = parseInt(total) + parseInt(price); // 
		});
		var result = '합계: ' + total + '원';	
		var fmt = $(".cart-total-order-price").find('fmt:formatNumber');
		$(".cart-total-order-price").removeClass('ng-hide').empty().append(result);
	}
	
</script>














