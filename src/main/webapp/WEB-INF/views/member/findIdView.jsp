<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../resources/css/common/mainCss.css" rel="stylesheet"
	type="text/css" />
</head>

<body id="asp_check" style="margin-top: 0px;">

	<div id="content" class="container fluid">
		<div class="join-wrap">
			<div id="id_inquiry_result" class="join-form">
				<div class="id_inquiry_result">
					<strong>아이디 검색 내역</strong>
					<p>
						고객님의 정보와 일치하는 아이디입니다.<br>로그인 또는 비밀번호 찾기 버튼을 눌러주세요.
					</p>
				
						<span class="findId"> 
							가입정보: ${result}
						</span>
	
					<div>
						<button type="submit" class="btn btn_login"
							onclick="location.href='/member/login'">로그인</button>
						<button type="submit" class="btn btn_join1"
							onclick="location.href='/member/findPwd'">비밀번호 찾기</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	
</body>
</html>