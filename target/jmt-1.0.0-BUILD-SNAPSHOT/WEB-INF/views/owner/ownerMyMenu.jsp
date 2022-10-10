<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <link href="../resources/css/common/mainCss.css" rel="stylesheet" type="text/css" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<title>myMenu</title>
</head>
<body>
	<div class="container" id="joinBtn">
			<button type="button" class="btn btn-member-join" onclick="window.location.href='/menu/createMenu?storeNo=${menu.storeNo}'">메뉴등록</button>
		    <button type="button" class="btn btn-owner-join" onclick="window.location.href='/menu/deleteMenu?storeNo=${menu.storeNo}'">메뉴삭제</button>
	</div>
</body>
</html>