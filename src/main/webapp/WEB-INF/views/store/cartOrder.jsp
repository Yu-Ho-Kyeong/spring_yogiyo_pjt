<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<div class="col-sm-4 hidden-xs restaurant-cart" style=" position: relative;" >

	<div class="sub-title">
		<span>주문표</span>
		<a class="allDelete">
		   <span class="ico-clear">전체삭제</span>
		</a>
	</div>
		
	<c:if test="${empty cartList}">
		<ul class="list-group" id="cartOrderList">
			<c:set var="cart" value="false"/>
			<div class="cart-empty">주문표에 담긴 메뉴가 없습니다.</div>
		</ul>
	</c:if>
		
	<c:if test=" ${not empty cartList}"> 
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
							<!-- <script>
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
					                        	if($('#cartOrderList').find('li').length == 0){
				                                	$(".cart-total-order-price").addClass('ng-hide');
				                                }
					                        	console.log(data);
					                        }
					                    });
	                                }
                                });
							</script>
								 -->
							<div class="col-xs-6 text-right">
								<a class="btn btn-minus">-</a> 
								<span class="order-num">${cart.cartAmount}</span>
								<a class="btn btn-plus">+</a>
								<input type="hidden" id="cartNo" class="cartNo" name="cartNo" value="${cart.cartNo}">
								<input type="hidden" id="menuNo" class="menuNo" name="menuNo" value="${cart.menuNo}">
								<input type="hidden" id="storeNo" class="storeNo" name="storeNo" value="${cart.storeNo}">
							</div>
						</div>
						
					</div>
				</li>
			</c:forEach>
		</ul>
	</c:if>

	<button type="submit" class="btn btn-lg btn-ygy1 btn-block" id="btn-order" disabled="disabled" 
	   	    onclick="location.href='/order/checkout/${sessionScope.memberId}'">주문하기</button>
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		
</div>

<script>
$(document).ready(function(){
	
	$(".allDelete").on("click", function(){
		var memberId = '${sessionScope.memberId}'
		var storeNo = "${param.storeNo}"
		var data =  {
			memberId : memberId,
			storeNo : storeNo
		}
	    $.ajax({
             url: "/cart/deleteAll",
             type: "POST",
             data: data,
             beforeSend: function (xhr) {   /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다 (spring boot security 설정부분)*/
                 xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
             },
             success: function (data) {
            	console.log(data);
                cartList()	
                if($('#cartOrderList').find('li').length == 0){
                	$(".cart-total-order-price").addClass('ng-hide');
                }
            }
         });
	});
	
	// 장바구니 목록 조회
	cartList()
	
	// 장바구니 추가 버튼
	var memberId
	var menuNo	
	var storeNo 
	var token = "${_csrf.token}"
	var header = "${_csrf.headerName}"
	$(".btn-add-cart").on("click", function(e){
		
		memberId = '${sessionScope.memberId}'
		menuNo = $(this).attr('data-menuNo');	
		storeNo = $(this).attr('data-storeNo');
		addCart()
		
	});
		
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
				
				console.log("length:----------:     " + $('#cartOrderList').find('li').length);
				
				if($('#cartOrderList').find('li').length > 0){
					totalPrice()
					$("#btn-order").attr('disabled', false)
                }else if ($('#cartOrderList').find('li').length == 0){
                	$("#btn-order").attr('disabled', true)
                }

			}
		})
	}
	
	function cartAlert(result){
		if(result == '0'){
			alert("주문표에 추가하지 못했습니다.");
		} else if(result == '1'){
			alert("주문표에 담았습니다.");
		} else if(result == '2'){
			var ok = confirm("다른 음식점에서 이미 담은 메뉴가 있습니다. 담긴 메뉴를 취소하고 새로운 음식점에서 메뉴를 담을까요?")
			if( ok ) {
				// 해당 memberId 의 장바구니 데이터 모두 삭제
				// 요청한 메뉴 카트에 추가
				cartDeleteAllAndAddCart()
			}
			
		} else if(result == '5'){
			alert("로그인이 필요합니다.");
			location.href="/member/login";
		}
	}
	
	function addCart() {
		
		// 서버로 전송할 데이터
		var data = {
			memberId : memberId,
			menuNo : menuNo,
			storeNo : storeNo,
			cartAmount : 1
		};
			
		console.log(data);
		
		// alert("카트 추가 버튼 ");
		// data.cartAmount = $(".order-num").val();
		
		
		$.ajax({
			url: '/cart/add',
			type: 'POST',
			data: data,
			beforeSend: function(xhr) { /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
				xhr.setRequestHeader(header, token);
			},
			success: function(result){			
				cartAlert(result);	
				if( result == 1 ) {
					cartList()	
				}
			}
		})
	}
	
	function cartDeleteAll() {
		
		var data = {
				memberId : memberId
		};
		$.ajax({
			url: '/cart/deleteAll',
			type: 'GET',
			data: data,
			beforeSend: function(xhr) { /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
				xhr.setRequestHeader(header, token);
			},
			success: function(result){
				console.log(result)
				alert('모두 삭제 완료')	
			}
		})
	
	}
		
	function cartDeleteAllAndAddCart() {
		
		var data = {
				memberId : memberId
		};
		$.ajax({
			url: '/cart/deleteAll',
			type: 'GET',
			data: data,
			beforeSend: function(xhr) { /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
				xhr.setRequestHeader(header, token);
			},
			success: function(result){			
				addCart()
			}
		})
	
	}
	
});

//주문표에 담긴 메뉴 합계 금액 출력
function totalPrice(){
	var total = 0;
	$("#cartOrderList li").each(function(idx,itm){ // 주문표에 입력된 메뉴 db 반복문
		console.log(itm)
		var price = $(itm).find('.order-price').text().replace(',','');// 11,000 -> 11000 변환;
		total = parseInt(total) + parseInt(price); // 
	});
	var result = '합계: ' + total + '원';		
	$(".cart-total-order-price").removeClass('ng-hide').empty().append(result);
}
</script>