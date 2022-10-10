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
	<div class="container" id="loginBtn">
   <form action="/jmt/path/pathLogin">
      <button type="button" class="btn btn-member-login" onclick="window.location.href='../member/login'">유저 로그인</button>
      <button type="button" class="btn btn-owner-login" onclick="window.location.href='../owner/login'">사장님  로그인</button>
   </form>
   </div>
</body>
</html>