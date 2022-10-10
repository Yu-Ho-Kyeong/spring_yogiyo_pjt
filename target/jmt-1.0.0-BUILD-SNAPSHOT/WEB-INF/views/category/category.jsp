<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

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