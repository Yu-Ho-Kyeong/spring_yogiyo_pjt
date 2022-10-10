<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>   

<!DOCTYPE html>
<html>
<head>
	<link href="../resources/css/common/mainCss.css" rel="stylesheet" type="text/css" />
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<title>댓글 등록</title>
	<style>
		.form-inline{
			martgin: 50px;
			padding: 50px;
		}
		table{
			margin:0 auto;

		}
		#mainbtn{
			width:49%;
			text-align:center;
			
		}
		#create{
			position:relative;
			background-color: #fa0050;
			width: 49%;
		}
		#ownerReplyContent{
			width: 400px;
			height: 200px;
			resize: none;
		}
	</style>
</head>
<body>
	<form class="form-inline" action="/ownerReply/createReply" method="post">
		<table>
		
			<tr>
				<td><b>댓글 등록</b><br><br></td>
			</tr>

			<tr>
				<td><b>댓글 내용</b><br>
				<textarea name="ownerReplyContent" id="ownerReplyContent"></textarea><br><br>
				<span id="msg_content"></span>
				</td>
			</tr>
			<tr>
				<td>
				<input type="hidden" name="reviewNo" id="reviewNo" value="${reply.reviewNo}" />
				</td>
				<td>
				<input type="hidden" name="storeNo" id="storeNo" value="${reply.storeNo}" />
				</td>
				<td>
				<input type="hidden" id="ownerId" value="${reply.ownerId}" />
				</td>
			</tr>
		
			<tr>
				<td>
				<button type="button" id="create" class="btn btn-success">댓글등록</button>
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				<a href="/store/storeDetail?storeNo=${reply.storeNo}" class="btn btn-primary" id="mainbtn">취소</a>
				</td>
			</tr>
		</table>
	</form>
	<script type="text/javascript">
	
		$(function(){

			// 댓글 등록
			$("#create").on("click", function() {
				var rivewNo = $("#rivewNo").val();
				var storeNo = $("#storeNo").val();
				var ownerId = $("#ownerId").val();
				var form = $(".form-inline");
				
				console.log("rivewNo :" + rivewNo);
				console.log("storeNo :" + storeNo);
				console.log("ownerId :" + ownerId);
				
				form.submit();
// 				location.href="/store/storeDetail?storeNo=" + storeNo;
			});
		});

	</script>
</body>
</html>