<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>

<html>
<head>
	<meta charset="UTF-8">
	<title>여기냐? 사장님 사이트</title>
	<link href="../resources/css/common/mainCss.css" rel="stylesheet" type="text/css" />
	<link rel="icon" type="image/x-icon"
		  href="https://ceo.yogiyo.co.kr/favicon.ico" />
</head>

	<body>
		<div class="container" id="joinBtn">
			<form action="/jmt/path/pathJoin">
				<button type="button" class="btn btn-member-join" onclick="window.location.href='../member/join'">일반유저 회원가입</button>
	      		<button type="button" class="btn btn-owner-join" onclick="window.location.href='../owner/ownerJoin'">사장님  회원가입</button>
			</form>
		</div>
	</body>

</html>