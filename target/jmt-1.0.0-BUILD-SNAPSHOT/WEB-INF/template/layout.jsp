<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>여기냐?</title>
</head>
<body>
	<!-- header -->
	<tiles:insertAttribute name="header"/>
	<!-- search -->
	<tiles:insertAttribute name="search"/>
	<!-- content -->
	<tiles:insertAttribute name="content"/>
	<!-- footer -->
	<tiles:insertAttribute name="footer"/>
</body>
</html>