<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<!DOCTYPE html>
<html>
      
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>여기냐?</title>
	<link href="../resources/css/common/mainCss.css" rel="stylesheet" type="text/css" />
	<link rel="apple-touch-icon-precomposed" href="https://www.yogiyo.co.kr/mobile/image/app_128x128.png" />
	<link rel="apple-touch-icon-precomposed" sizes="144x144" href="https://www.yogiyo.co.kr/mobile/image/app_144x144.png" />
	<link rel="icon" type="image/x-icon"  href="https://www.yogiyo.co.kr/mobile/image/favicon.ico" />
	<script src="https://code.jquery.com/jquery-3.4.1.js"
			integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
			crossorigin="anonymous">
	</script>
</head>

<body style="margin-top: 0px;">
	<div class="category-list">
	<div class="row">
		<h1 class="d-none">카테고리박스</h1>
		<c:forEach items="${category }" var="list">
			<div class="col-xs-6 col-sm-4 col-md-3 col-lg-3"> 
				<a class="thumbnail" href="${list.categoryClickUrl }"> 
					<span class="category-title"> ${list.categoryName } </span>
					<img src="${list.categoryImgUrl}" alt="${list.categoryAlt}" />
 				</a> 
 			</div> 
 		</c:forEach>
	</div>
</div>
</body>

</html>

