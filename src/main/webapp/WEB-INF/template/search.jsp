<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>	
	
	<!-- search -->
	<div id="search" class="search clearfix search-show">
		<!-- ::before -->
		<h1 class="d-none">검색폼</h1>
		<div class="input-group">
			<span class="input-group-btn loc">
				<button class="btn btn-default ico-loc" type="button">&nbsp;</button>
			</span>
			<form action="." onsubmit="return false">
				<input type="search" id="adress_input" class="form-control" name="address_input" autocomplete="off" autocorrect="off"
				 	   autocqpitalize="off" spellcheck="false" placeholder="건물명, 도로명, 지번으로 검색하세요." onclick="execDaumPostcode()" />
			</form>
			<span id="button_search_address" class="input-group-btn always-show-search-buttons">
				<button class="btn-search-location-cancel btn-search-location btn btn-default" type="button">
					<span class="searchfield-cancel-button">&nbsp;</span>
				</button>
				<button class="btn btn-default ico-pick" type="button">검색</button>
			</span>
		</div>
	</div>
	
	<!-- script -->
	<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
	
	    function execDaumPostcode() {
	        new daum.Postcode({
	            oncomplete: function(data) {
	                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
	                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                var addr = ''; // 주소 변수
	                var extraAddr = ''; // 참고항목 변수
	
	                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                    addr = data.roadAddress;
	                } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                    addr = data.jibunAddress;
	                }
	
	                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
	                if(data.userSelectedType === 'R'){
	                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                        extraAddr += data.bname;
	                    }
	                    // 건물명이 있고, 공동주택일 경우 추가한다.
	                    if(data.buildingName !== '' && data.apartment === 'Y'){
	                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                    }
	                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                    if(extraAddr !== ''){
	                        extraAddr = ' (' + extraAddr + ')';
	                    }
	                 	// 주소변수 문자열과 참고항목 문자열 합치기
	                    addr += extraAddr;
	                
	                } else {
	                	addr += ' ';
	                }
	
	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                /* document.getElementById('search_input').value = data.zonecode; */
	                $("#adress_input").val(addr);
	                /* document.getElementById("search_input").value = addr; */
	                // 커서를 상세주소 필드로 이동한다.
	                /* document.getElementById("sample6_detailAddress").focus(); */
	            }
	        }).open();
	    }
	    
	 	// 주소검색창 'x'버튼 클릭스 공백으로 표기
		$(".btn-search-location-cancel").click(function(){
		
			$("#adress_input").val("");
		});
	 
	</script>