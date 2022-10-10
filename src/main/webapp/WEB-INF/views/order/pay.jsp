<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>결제 페이지</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
	  <script src="http://dmaps.daum.net/map_js_init/postcode.v2.js?autoload=false"></script>
	  <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
</head>

<script type="text/javascript">

	var orderRequest = '${order.orderRequest}'; // 주문자 요청사항
 	var orderAddress = '${order.orderAddress}'; // 주문자 주소
	var orderTotalPrice = '${order.orderTotalPrice}'; // 주문 합계 가격
	var orderMenu = '${order.orderMenu}'; // 주문메뉴
	var orderAmount = '${order.orderAmount}'; // 주문수량
	var orderTel = '${memberInfo.memberPhoneNo}'; // 주문자 연락처
	var storeNo = '${order.storeNo}'; // 주문한 가게번호
	var memberId = '${order.memberId}'; // 주문자 아이디
	var orderPaymentMethod  = '${order.orderPaymentMethod}'; // 결제방식
	var orderStoreName = '${order.orderStoreName}'; //주문한 가게이름
	var token = "${_csrf.token}";
	var header = "${_csrf.headerName}";

	if(orderPaymentMethod == 1){
		IMP.init('imp15128745');
	    IMP.request_pay({
	        pg : 'kakaopay.TC0ONETIME',
	        pay_method : 'card',
	        merchant_uid : 'merchant_' + new Date().getTime(),
	        name : '테스트',
	        amount : orderTotalPrice,
	        buyer_email : 'iamport@siot.do',
	        buyer_name : '${order.memberId}',
	        buyer_tel : '010-1234-5678',
	        buyer_addr : '서울특별시 강남구 삼성동',
	        buyer_postcode : '123-456'
	    }, function(rsp) { //callback
	        if ( rsp.success ) {
	        	$.ajax({
	    			url: '/order/insertOrderList',
	    			type: 'get',
	    			data: {
	    				'orderRequest' : orderRequest,
	    				'orderAddress' : orderAddress, 
	    			 	'orderTotalPrice' : orderTotalPrice, 
	    			 	'orderMenu' : orderMenu, 
	    			 	'orderAmount' : orderAmount, 
	    			 	'orderTel' : orderTel, 
	    			 	'storeNo' : storeNo, 
	    			 	'memberId' : memberId, 
	    			 	'orderPaymentMethod' : orderPaymentMethod,
	    			 	'orderStoreName' : orderStoreName
	    			},
	  
	    			beforeSend: function(xhr) { /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
	    				xhr.setRequestHeader(header, token);
	    			},
	    			success: function(e){				
	    				console.log(data);
	    			},error:function(xhr){
	                    console.log(xhr.status);
	                }
	    		})				 
		    	var msg = '결제가 완료되었습니다.';
			        msg += '고유ID : ' + rsp.imp_uid;
			        msg += '상점 거래ID : ' + rsp.merchant_uid;
			        msg += '결제 금액 : ' + rsp.paid_amount;
			        msg += '카드 승인번호 : ' + rsp.apply_num;
			        location.href="/member/memberOrderList"// 결제 정보창으로 이동			

	        } else {
	            var msg = '결제에 실패하였습니다.';
	            msg += '에러내용 : ' + rsp.error_msg;
	        }
	
	        alert(msg);
	    });
		
	}else{
	
		$.ajax({
			url: '/order/insertOrderList',
			type: 'get',
			data: {
				  'orderRequest' : orderRequest,
			 	  'orderAddress' : orderAddress, 
			 	  'orderTotalPrice' : orderTotalPrice, 
				  'orderMenu' : orderMenu, 
			 	  'orderAmount' : orderAmount, 
			 	  'orderTel' : orderTel, 
			 	  'storeNo' : storeNo, 
			      'memberId' : memberId, 
			 	  'orderPaymentMethod' : orderPaymentMethod,
			 	  'orderStoreName' : orderStoreName
			}, 	  
			beforeSend: function(xhr) { /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
				xhr.setRequestHeader(header, token);
			},
			success: function(e){				
				console.log(data);
			}
		});
		var msg = '주문이 완료되었습니다.';
			alert(msg);
			location.href="/member/memberOrderList" // 결제 정보창으로 이동
    
	   }

</script>
<body>
		
</body>
</html>