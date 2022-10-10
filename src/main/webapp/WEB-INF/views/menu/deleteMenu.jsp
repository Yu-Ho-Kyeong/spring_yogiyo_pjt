<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<link href="../resources/css/common/mainCss.css" rel="stylesheet" type="text/css" />
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/js/toastr.min.js"></script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/css/toastr.min.css">
	<title>메뉴 등록</title>
	<style>
		.btn-delete{
			background-color: #fa0050;
			width: 75px;
			color: white; 
			font-size: 20px;
			margin: 10px;
		}
		.menu-name{font-size: 25px!important; margin: 15px;}
		.menu-desc{font-size: 15px!important; margin: 15px;}
		.menu-price{font-size: 15px!important; margin: 15px;}
		.menu-delete{width:10%;}
	</style>
</head>

<body>
	<div id="menu" class="menu-list">
		<ul class="sub-list" id="sub-list">
		
		<c:if test="${empty getMenuList}">
				<div class="clearfix empty-restaurant">
					아직 등록된 메뉴가 없습니다.<br>메뉴를 등록해주세요.
				</div>
		</c:if>
			<!-- 반복시작 -->
			<c:forEach items="${getMenuList}" var="menu">
				<li class="photo-menu">
					<table>
						<tbody>						
							<tr>
								<td class="photo-area ">
									<img class="logo" alt="메뉴url" src="${menu.menuUrl}" style="width:400px; height:400px;">
								</td>
								
								<td class="menu-text">
									<div class="menu-name">${menu.menuName}</div>
									<div class="menu-desc">${menu.menuInfo}</div>
									<div class="menu-price">
										<span class="ng-binding">
											<fmt:formatNumber value="${menu.menuPrice}" pattern="#,###,###" />원 
										</span> 
									</div>	
								</td>
								
								<td class="menu-delete">
									<div>
										<a id="del_${menu.menuNo}_btn" data-menuNo="${menu.menuNo}" class="btn btn-delete">삭제</a>
										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
										<input type="hidden" id="storeNo" name="storeNo" value="${menu.storeNo}"/>
									</div>
									
								</td>					
							</tr>
						</tbody>
					</table>
				</li>
			</c:forEach>
			<!-- 반복종료  -->
		</ul>
<!-- 		<button class="btn btn-delete">삭제</button> -->
<!-- 		<button class="btn btn-cancle">취소</button> -->
	</div>
	<script>
		//메뉴삭제 버튼 클릭
		$(".btn-delete").click(function () { 
			var ok = confirm("선택한 메뉴를 삭제하시겠습니까?");
			var target = $(this).closest(".photo-menu");
			
			if( ok ) {
												
				var token = "${_csrf.token}"
				var header = "${_csrf.headerName}"
				var menuNo = $(this).attr("data-menuNo")
				var storeNo = $("#storeNo").val();
				console.log("menuNo : " + menuNo)
				console.log("storeNo :" + storeNo)
												
				$.ajax({
					type: 'POST',
					url: '/menu/deleteMenu',
					data: { 
						'menuNo' : menuNo,
						'storeNo' : storeNo
					},
					beforeSend: function (xhr) {   /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다 (spring security 설정부분)*/
						xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
					},
					success: function( data ) {
						console.log(data);
						target.remove();
						toastr.success("선택한 메뉴가 삭제되었습니다.", "서버 메시지");
					},
					error: function(xhr, status, error) {
						console.log("status : " + xhr.status);
						console.log("response : " + xhr.responseText);
						console.log("status : " + status);
						console.log("error : " + error);
					}
				});
			}
		});
	</script>
	
</body>
</html>