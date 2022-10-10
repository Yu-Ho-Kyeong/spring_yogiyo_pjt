<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>   
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<link href="../resources/css/common/mainCss.css" rel="stylesheet" type="text/css" />
	<title>리뷰 등록</title>
<style>

	.review-header{
		display: block;
	    padding: 15px 30px;
	    margin : 0px 0px;
	    background-color: #FA0050;
	    font-size: 20px;
	    letter-spacing: -1px;
	    color: #ffffff;
	    font-weight: normal;
	}
	
	.insertText{
		width: 100%;
	    height: 110px;
	    border: 0;
	    font-size: 13px;
	    line-height: 20px;
	    color: #222222;
	    resize: none;
	}
	.btn-dark{
		background-color: #FA0050;
		color: white;
		width:49.5%;
	}
	.btn-cancle{
		background-color: #D9D9D9;
		color: white;
		width:49.5%;
	}
	.starR{
	  background: url('http://miuu227.godohosting.com/images/icon/ico_review.png') no-repeat right 0;
	  background-size: auto 100%;
	  width: 20px;
	  height: 20px;
	  display: inline-block;
	  text-indent: -9999px;
	  cursor: pointer;
	}
	.starR.on{background-position:0 0;}
	.review-point-desc{color: #808080;}
	.review-store-name{font-size: 18px;}
</style>

</head>
<body>
	<div style="margin: 0px; width: 100%">
		<h1 class="review-header">리뷰 작성하기</h1>
	</div>
	<form action="/review/createReview" id="review-form" method="post" enctype="multipart/form-data">
		<c:forEach items="${map.info}" var="order">
			<div style="margin: 20px; width: 100%">
				<span class="review-store-name">
					<strong>${order.orderStoreName}</strong>
				</span>
			</div>
			
			<hr style="border: solid 0.1px #D9D9D9;">
			
			<div style="margin: 20px; width: 100%">
				<input type="hidden" name="reviewMenuName" value="${order.orderMenu}" />
				<span class="review-menu-name">${order.orderMenu}</span>
			</div>
		</c:forEach>
		
		<hr style="border: solid 5px #D9D9D9;">
			
		<c:forEach items="${map.info}" var="order">
			<input type="hidden" name="orderNo" value="${order.orderNo}">
			<input type="hidden" name="storeNo" value="${order.storeNo}">
			<input type="hidden" name="memberId" value="${order.memberId}">
		</c:forEach>
		
		<div class="form-inline" style="padding: 30px 30px;">
			<ul>
			
				<li>
					<span class="review-point-desc">
						이 가게에 대한 상세한 평가를 해주세요.
					</span>
				
				</li>
				<li class="starRev1">
					<br/>
					<b>맛 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b>
					<span class="starR">1</span>
				 	<span class="starR">2</span>
					<span class="starR">3</span>
					<span class="starR">4</span>
					<span class="starR">5</span>
					<input type="hidden" id="reviewMatPoint" name="reviewMatPoint"/>
					<span id="msg_matPoint"></span>
					<br/>
					<br/>
				</li>
	
				<li class="starRev2">
					<b>양 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b>
					<span class="starR">1</span>
				 	<span class="starR">2</span>
					<span class="starR">3</span>
					<span class="starR">4</span>
					<span class="starR">5</span>
					<input type="hidden" id="reviewYangPoint" name="reviewYangPoint"/>
					<span id="msg_yangPoint"></span>
					<br/>
					<br/>
				</li>
	
				<li class="starRev3">
					<b>배달 &nbsp;&nbsp;</b>
					<span class="starR">1</span>
				 	<span class="starR">2</span>
					<span class="starR">3</span>
					<span class="starR">4</span>
					<span class="starR">5</span>
					<input type="hidden" id="reviewBaedalPoint" name="reviewBaedalPoint"/>
					<span id="msg_baedalPoint"></span>
					<br/>
				</li>
			</ul>
			
			<br>
			<div style="padding: 18px 18px; margin-bottom: 30px; border: 1px solid #cfcfcf">
				<textarea name="reviewContent" class="insertText" placeholder="음식에 대한 솔직한 리뷰를 남겨주세요!(10자 이상)" maxlength="1000"></textarea>
			</div>
			
			<div style="margin-bottom: 30px;">
				<input type="file" name="file">
			</div>
			<button class="btn btn-dark">등록</button>	
			<button type="button" class="btn btn-cancle" onclick="location.href='/member/memberOrderList'">취소</button>
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />	
		</div>
	</form>
	
	<script>
	
		$(function(){	
			// 별점 입력 체크
			function checkStar() {
				
				var matPoint = $("#reviewMatPoint").val();
				var yangPoint = $("#reviewYangPoint").val();
				var baedalPoint = $("#reviewBaedalPoint").val();
				
				if(matPoint.length==0) {
					$("#msg_matPoint").text("별점은 필수 입력입니다.").css("color", "red").css("font-size", "0.75em");
					return false;
				} else {
					return true;
				}	
				if(yangPoint.length==0) {
					$("#msg_yangPoint").text("별점은 필수 입력입니다.").css("color", "red").css("font-size", "0.75em");
					return false;
				} else {
					return true;
				}	
				if(baedalPoint.length==0) {
					$("#msg_baedalPoint").text("별점은 필수 입력입니다.").css("color", "red").css("font-size", "0.75em");
					return false;
				} else {
					return true;
				}	
			}
			
			
			function checkContent(){
				var content = $("#reviewContent").val();
				if(content.length==0){
					$("#msg_content").text("소감을 말씀해주세요").css("color","red").css("font-size", "0.75em");
					return false;
				}
				else {
					$("#msg_content").text("감사합니다.").css("color","green").css("font-size", "0.75em");
					return true;
				}
			}
		
			// 맛별점 주기
			$('.starRev1 span').click(function(){
				  $(this).parent().children('span').removeClass('on');
				  $(this).addClass('on').prevAll('span').addClass('on');
				  var matPoint = $(this).html();
	
				  $('#reviewMatPoint').val(matPoint);
				  console.log("matPoint : " + matPoint);
				  $("#msg_matPoint").text("");
				  return false;
			});
			// 양별점 주기
			$('.starRev2 span').click(function(){
				  $(this).parent().children('span').removeClass('on');
				  $(this).addClass('on').prevAll('span').addClass('on');
				  
				  var yangPoint = $(this).html();
				  $('#reviewYangPoint').val(yangPoint);
				  console.log("yangPoint : " + yangPoint);
				  $("#msg_yangPoint").text("");
				  return false;
			});
			// 배달 별점 주기
			$('.starRev3 span').click(function(){
				  $(this).parent().children('span').removeClass('on');
				  $(this).addClass('on').prevAll('span').addClass('on');
				 
				  var baedalPoint = $(this).html();
				  $('#reviewBaedalPoint').val(baedalPoint); 
				  console.log("baedalPoint : " + baedalPoint);
				  $("#msg_baedalPoint").text("");
				  return false;
			});
		
			$("#reviewMatPoint").on("blur", function() {
				checkStar();
			})
			$("#reviewYangPoint").on("blur", function() {
				checkStar();
			})
			$("#reviewBaedalPoint").on("blur", function() {
				checkStar();
			})
			$("#reviewContent").on("blur", function() {
				checkContent();
			})
			
			$("#create").on("click", function() {
				var token = "${_csrf.token}"
				var header = "${_csrf.headerName}"
				var reviewMenuName = $('#reviewMenuName').val();
				var form = $('#review-form')[0]
				var formData = new FormData(form) 
				
				for(var key of formData.keys()) {
					console.log(key + ' : ' + formData.get(key) )
				
				}
				
				formData.append('reviewMenuName', reviewMenuName);
				
				$.ajax({
					url: "/review/createReview",
					method: "post",
					data: formData,
					processData: false,
					contentType: false,
					success: function(result) { 
						location.href="/member/memberOrderList";
						
					},error: function(xhr, status, error) {
						console.log("status : " + xhr.status)
						console.log("response : " + xhr.responseText)
						console.log("status : " + status)
						console.log("error : " + error)
					}
					
					});
				});
			});
		

</script>
</body>
</html>