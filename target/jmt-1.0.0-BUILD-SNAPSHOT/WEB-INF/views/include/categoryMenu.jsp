<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="restaurant-category-menu">
	<div>
		<div class="sms">
			<button type="button" id="category-menu"
				class="btn btn-block visiblexs category-btn clearfix">
	
				<span class="pullleft"> 
					<span class="category-name">음식점 전체보기</span>
				</span> 
				<i class="pullright arrdown"></i>
			</button>
	
			<div id="category" class="category-menu clearfix collapse"
				aria-expanded="true" style="height: 0px;">
				
				<ul>
					<li class="hidden-xs menu-search">
						<a class="btn btn-default ico-search1" id="btn-default">검색</a></li>
					
					<li class="active">
						<i class="category-icon ico-ct01"></i> 
						<span class="category-name" onclick="location.href='/category/all'">전체보기</span>
					</li>
	
					<li class="">
						<i class="category-icon ico-ct12"></i> 
						<span class="category-name" onclick="location.href='/category/oneOrder'">1인분 주문</span>
					</li>
	
					<li class="">
						<i class="category-icon ico-ct10"></i> 
						<span class="category-name" onclick="location.href='/category/franchise'">프랜차이즈</span>
					</li>
	
					<li class="">
						<i class="category-icon ico-ct02"></i> 
						<span class="category-name" onclick="location.href='/category/chicken'">치킨</span>
					</li>
	
					<li class=""><i class="category-icon ico-ct03"></i> <span
						class="category-name" onclick="location.href='/category/yangsik'">피자/양식</span></li>
	
					<li class="">
						<i class="category-icon ico-ct04"></i> 
						<span class="category-name" onclick="location.href='/category/china'">중국집</span>
					</li>
	
					<li class="">
						<i class="category-icon ico-ct05"></i> 
						<span class="category-name" onclick="location.href='/category/korea'">한식</span>
					</li>
	
					<li class="">
						<i class="category-icon ico-ct06"></i> 
						<span class="category-name" onclick="location.href='/category/japan'">일식/돈까스</span>
					</li>
	
					<li class="">
						<i class="category-icon ico-ct07"></i> 
						<span class="category-name" onclick="location.href='/category/jokbal'">족발/보쌈</span>
					</li>
	
					<li class="">
						<i class="category-icon ico-ct08"></i> 
						<span class="category-name" onclick="location.href='/category/yasik'">야식</span>
					</li>
	
					<li class="">
						<i class="category-icon ico-ct09"></i> 
						<span class="category-name" onclick="location.href='/category/boonsik'">분식</span>
					</li>
	
					<li class="">
						<i class="category-icon ico-ct11"></i> 
						<span class="category-name" onclick="location.href='/category/desert'">카페/디저트</span>
					</li>
	
					<li class="">
						<i class="category-icon ico-ct13"></i> 
						<span class="category-name" onclick="location.href='/category/mart'">편의점/마트</span>
					</li>
						
					<li class="main-search hide">
						<form action="/store/listSearch" method="get" class="search-form">
							<div class="input-group">
								<input type="search" id="keyword" name="keyword" value="${pageMaker.cri.keyword}" class="form-control"
									   placeholder="음식점이나 메뉴를 검색해보세요."/> 
								<span class="input-group-btn">
									<button class="btn-search-category-cancel btn btn-default hide" type="button">
									</button>
									<button class="btn btn-default ico-search" 
										    type="button"
											id="category_search_button">&nbsp;
									</button>
									<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
								</span>
							</div>
						</form>
					</li>
				</ul>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
	$(document).ready(function(e){
		
		$(".ico-ct01").click(function(){
			$(".ico-ct01").attr("class","active");
		})
		$(".ico-ct12").click(function(){
			$(".ico-ct12").attr("class","active");
		})
		$(".ico-ct10").click(function(){
			$(".ico-ct10").attr("class","active");
		})
		$(".ico-ct02").click(function(){
			$(this).parent().addClass("active");
		})
		$(".ico-ct03").click(function(){
			$(this).parent().addClass("active");
		})
		$(".ico-ct04").click(function(){
			$(this).parent().addClass("active");
		})
		$(".ico-ct05").click(function(){
			$(this).parent().addClass("active");
		})
		$(".ico-ct06").click(function(){
			$(this).parent().addClass("active");
		})
		$(".ico-ct07").click(function(){
			$(this).parent().addClass("active");
		})
		$(".ico-ct08").click(function(){
			$(this).parent().addClass("active");
		})
		$(".ico-ct09").click(function(){
			$(this).parent().addClass("active");
		})
		$(".ico-ct11").click(function(){
			$(this).parent().addClass("active");
		})
		$(".ico-ct13").click(function(){
			$(this).parent().addClass("active");
		})
		
		// 음식점 전체보기 클릭시 카테고리 토글
		$(".category-btn").click(function(){
			$("#category").toggleClass('in') 
		});
		// 돋보기 클릭시 검색창 toggle
		$(".ico-search1").on("click", function() {
			$(".main-search").toggleClass("hide");
		});
		// cancle 버튼 클릭시 검색어 지우기
		$(".btn-search-category-cancel").on("click", function() {
			$("#keyword").val("");
		});
		// 입력창 클릭시 cancle 버튼 나타남
		$("#keyword").on("mousedown", function(e){
			$(".btn-search-category-cancel").removeClass("hide");
		});
		
		var form = $(".search-form");
		
		//페이지 이동 버튼
		$("#category_search_button").on("click", function(){
			alert("검색버튼 클릭");
			if( $("#keyword").val().length == 0){ // 검색어가 공백이면 arlert
				alert("검색할 가게 이름을 입력해주세요.");
				return false;
			}
			form.submit();
		});
	});

	


 
</script>