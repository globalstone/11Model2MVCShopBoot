<%@ page language="java" contentType="text/html; charset=EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%-- 
<%@page import="java.util.*"%>
<%@page import="com.model2.mvc.common.Page"%>
<%@page import="com.model2.mvc.service.domain.Product"%>
<%@page import="com.model2.mvc.service.purchase.vo.PurchaseVO"%>
<%@page import="com.model2.mvc.common.Search"%>
<%@page import="com.model2.mvc.common.util.CommonUtil"%>

<%
	List<Product> list =(List<Product>)request.getAttribute("list");
	Search search=(Search)request.getAttribute("search");
	Page resultPage = (Page)request.getAttribute("resultPage");
	//Purchase pur = new Purchase();
	String menu = (String)request.getAttribute("menu");
	String searchCondition = CommonUtil.null2str(search.getSearchCondition());
	String searchKeyword = CommonUtil.null2str(search.getSearchKeyword());
	
%>
--%>

<html>
<head>
<title>상품 목록조회</title>
<%--	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>--%>
<%--	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>--%>
<%--	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>--%>
<%--	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>--%>
<%--	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootswatch@4.5.2/dist/sketchy/bootstrap.min.css" integrity="sha384-RxqHG2ilm4r6aFRpGmBbGTjsqwfqHOKy1ArsMhHusnRO47jcGqpIQqlQK/kmGy9R" crossorigin="anonymous">--%>
<%--	<link rel="stylesheet" href="https://code.jquery.com/ui/1.13.2/themes/smoothness/jquery-ui.css">--%>
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

	<title>Carousel Template for Bootstrap</title>
</head>
<script type="text/javascript">

	function fncGetUserList(currentPage,menu) {
		// document.getElementById("currentPage").value = currentPage;
		// document.detailForm.submit();
		$("#currentPage").val(currentPage);

		if (menu === 'search') {
			$('form[name="searchList"]').attr("method", "POST").attr("action", "/product/listProduct/search").submit();
		} else if (menu === 'manage') {
			$('form[name="manageList"]').attr("method", "POST").attr("action", "/product/listProduct/manage").submit();
		}
	}

	function loadImage(src, callback) {
		var img = new Image();
		img.onload = function() {
			img.style.width = '100%';
			img.style.height = '200px';
			callback(img);
		};
		img.src = src;
	}

	$(function () {
		$("#button-addon2").on("click", function () {
			//Debug..
			//alert(  $( "td.ct_btn01:contains('검색')" ).html() );
			var menu = '${menu}';
			$("#currentPage").val(1); // 검색 시 첫 페이지로 설정
			fncGetUserList(1,menu);
		});
	});

		$(document).ready(function () {

			var isLoading = false;
			var isEndOfData = false;
			var currentPage = 2;  // 현재 페이지를 2로 설정
			var pageSize = 8;
			let dallor = 36;

			function loadProduct(i, product) {
				var time = product.regDate;
				var productDate = new Date(time);
				var todays = new Date();
				var times = Math.abs(todays.getTime() - productDate.getTime());
				var days = Math.ceil(times / (1000 * 3600 * 24) - 1);

				if (days === 0) {
					days = "today";
				} else {
					days += 'days ago';
				}

				loadImage('/images/uploadFiles/' + product.fileName, function (img) {
				var row = '<div class = "col-md-4">' +
						'<div class = "card mb-3">' +
						'<h3 class = "card-header">' + (((currentPage - 1) * pageSize + i + 1) - 8) +
						'<c:if test = "${menu == 'search'}">' +
						'<c:if test="${ !empty prod.proTranCode }">' +
						'<c:if test="${ fn:trim(prod.proTranCode)==3 }">' +
						'<div style = "float: right;">sold out</div>' +
						'</c:if>' +
						'<c:if test="${ fn:trim(prod.proTranCode) !=3 }">' +
						'<div style = "float: right;">sold out</div>' +
						'</c:if>' +
						'</c:if>' +
						'<c:if test="${ empty prod.proTranCode }">' +
						'<div style = "float: right;">On Sale</div>' +
						'</c:if></c:if>' +
						'<c:if test = "${menu == 'manage'}">' +
						'<a href="/product/updateProduct/${ prod.prodNo }/${ menu }" style="float: right;" id = "Edit">Edit</a>' +
						'</c:if>' +
						'</h3>' +
						'<div class = "card-body">' +
						'<h5 class ="card-title">' + product.prodName + '</h5>' +
						'</div>' +
						img.outerHTML +
						'<div class = "card-body">' +
						'<p class = "card-text">' + product.prodDetail + '</p>' +
						'</div>' +
						'<ul class = "input-group-text">' +
						'<span class ="input-group-text">' + String.fromCharCode(dallor) + '</span>' +
						'<input class = "form-control" id = "readOnlyInput" type="text" placeholder="' + product.price + '" readonly="">' +
						'</ul>' +
						'<div class = "card-body">' +
						'<c:if test = "${menu == 'search'}">' +
						'<c:if test="${ empty prod.proTranCode }">' +
						'<a href = "/purchase/addPurchase/' + product.prodNo + '" class = "card-link"> Buy </a>' +
						'</c:if>' +
						'<a href = "#" class = "card-link"> Wish </a>' +
						'</c:if>' +
						'</div>' +
						'<div class = "card-footer text-muted">' +
						days +
						'</div>' +
						'</div>' +
						'</div>';
				$('.row').append(row);
			});
		}

			function loadMoreProducts() {
				if (!isLoading && !isEndOfData) {
					isLoading = true;

					$.ajax({
						url: "/product/json/listProduct/search",
						method: "GET",
						data: {
							currentPage: currentPage,
							pageSize: pageSize
						},
						dataType: "json",
						success: function (data) {
							var prod = data.productList;
							if (prod.length === 0) {
								isEndOfData = true;
								return;
							}
							for (var i = 0; i < prod.length; i++) {
								loadProduct(i, prod[i]);  // 각 상품을 로드하는 함수를 호출합니다.
							}
							isLoading = false;
							currentPage++;
						},
						error: function () {
							isLoading = false;
						}
					});
				}
			}
			// loadMoreProducts();  // 초기에 한 번 데이터 로드
			var $window = $(window);
			var $document = $(document);

			$window.scroll(function() {
				var scrollTop = $window.scrollTop(); // 스크롤바 위치
				var viewportHeight = window.innerHeight; // 브라우저 창의 뷰포트 높이
				var documentHeight = $document.height(); // 전체 문서의 높이

				console.log("Scroll Top: ", scrollTop);
				console.log("Viewport Height: ", viewportHeight);
				console.log("Document Height: ", documentHeight);

				if (scrollTop + viewportHeight >= documentHeight * 0.7) {
					console.log("Reached the bottom of the page");
					// 데이터 로드 로직을 여기에 추가
					loadMoreProducts();
				}
			});
		});


			$(document).ready(function () {
				$('.card-footer').each(function () {
					var timestamp = $(this).text(); // prod.regDate 값을 가져옵니다.
					var date = new Date(timestamp); // Unix timestamp를 Date 객체로 변환합니다.
					var formattedDate = date.getFullYear() + '-' + (date.getMonth() + 1).toString().padStart(2, '0') + '-' + date.getDate().toString().padStart(2, '0');
					$(this).text(formattedDate); // 'yyyy-mm-dd' 형식의 날짜로 변환한 값을 설정합니다.
				});
			});

			$(document).ready(function() {
				// 전체 상품 데이터를 저장할 배열
				var allProducts = [];

				// 서버에서 전체 상품 데이터를 가져옵니다.
				$.ajax({
					url: "/product/json/listProduct/all",
					method: "GET",
					dataType: "json",
					success: function (data) {
						if (Array.isArray(data)) {
							allProducts = data;

							// 자동완성 기능을 적용합니다.
							$("#productInput").autocomplete({
								source: allProducts,
								minLength: 1
							});
						} else {
							console.error("데이터 형식확인용 :", data);
						}
					},
					error: function () {
						console.error("못불러왔음 ");
					}
				});
			});
</script>
<style>
	body {
		padding-top: 90px;
	}
</style>
</head>

<body bgcolor="#ffffff" text="#000000">
<jsp:include page="/layout/toolbar.jsp" />
<form name = "searchList">
 <c:if test = "${menu == 'search'}">
	<div class="container">
		<div class="row1">
			<div class="col-md-12">
				<div class="input-group mb-3">
					<select name="searchCondition"
							class="ct_input_g" style="width: 80px">
						<option value="1" ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" } >상품명</option>
						<input type="text" id = "productInput" name="searchKeyword" value="${ search.searchKeyword }" class="form-control" placeholder="상품명을 입력해주세요" aria-label="Recipient's username" aria-describedby="button-addon2">
						<button class="btn btn-primary" type="button" id="button-addon2">Search</button>
						<input type= "hidden" id = "currentPage" name="currentPage" value = ""/>
					</select>
				</div>
			</div>
		</div>
		<div class="row">
			<c:set var="i" value="0"/>
			<c:forEach var="prod" items="${list}">
				<c:set var='i' value="${i+1}"/>
				<div class="col-md-4">
					<div class="card mb-3">
						<h3 class="card-header">${i}
							<c:if test="${ !empty prod.proTranCode }">
								<c:if test="${ fn:trim(prod.proTranCode)==3 }">
									<div style = "float: right;">sold out</div>
								</c:if>
								<c:if test="${ fn:trim(prod.proTranCode) !=3 }">
									<div style = "float: right;">sold out</div>
								</c:if>
							</c:if>
							<c:if test="${ empty prod.proTranCode }">
								<div style = "float: right;">On Sale</div>
							</c:if></h3>
						<div class="card-body">
							<h5 class="card-title">${prod.prodName}</h5>
						</div>
						<img src="/images/uploadFiles/${prod.fileName}" alt="Product Image" width="100%" height="200">
						<div class="card-body">
							<p class="card-text">${prod.prodDetail}</p>
						</div>
						<ul class="input-group-text">
							<span class="input-group-text">$</span>
							<input class="form-control" id="readOnlyInput" type="text" placeholder=${prod.price} readonly="">
						</ul>
						<div class="card-body">
							<c:if test="${ empty prod.proTranCode }">
							<a href="/purchase/addPurchase/${ prod.prodNo }">Buy</a>
							</c:if>
							<a href="/product/wishlist/${prod.prodNo}" class="card-link">Whish</a>
						</div>
						<div class="card-footer text-muted">
								${prod.regDate}
						</div>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>
 </c:if>
</form>

<form name = "manageList">
<c:if test = "${menu == 'manage'}">
	<div class="container">
		<div class="row1">
			<div class="col-md-12">
				<div class="input-group mb-3">
					<select name="searchCondition"
							class="ct_input_g" style="width: 80px">
						<option value="1" ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" } >상품명</option>
						<input type="text" id = "productInput" name="searchKeyword" value="${ search.searchKeyword }" class="form-control" placeholder="상품명을 입력해주세요" aria-label="Recipient's username" aria-describedby="button-addon2">
						<button class="btn btn-primary" type="button" id="button-addon2">Search</button>
						<input type= "hidden" id = "currentPage" name="currentPage" value = ""/>
					</select>
				</div>
			</div>
		</div>
	<div class="container">
		<div class="row">
			<c:set var="i" value="0"/>
			<c:forEach var="prod" items="${list}">
				<c:set var='i' value="${i+1}"/>
				<div class="col-md-4">
					<div class="card mb-3">
						<h3 class="card-header">
								${i}
							<a href="/product/updateProduct/${ prod.prodNo }/${ menu }" style="float: right;" id = "Edit">Edit</a>
						</h3>
						<div class="card-body">
							<h5 class="card-title">${prod.prodName}</h5>
						</div>
						<img src="/images/uploadFiles/${prod.fileName}" alt="Product Image" width="100%" height="200">
						<div class="card-body">
							<p class="card-text">${prod.prodDetail}</p>
						</div>
						<ul class="input-group-text">
							<span class="input-group-text">$</span>
							<input class="form-control" id="readOnlyInput" type="text" placeholder=${prod.price} readonly="">
						</ul>
						<div class="card-body">
							<c:if test = "${menu == 'search'}">
							<a href="/product/buy/${prod.prodNo}" class="card-link">Buy</a>
							<a href="/product/wishlist/${prod.prodNo}" class="card-link">Whish</a>
							</c:if>
							<c:if test="${ ! empty prod.proTranCode }">
								<c:if test="${ fn:trim(prod.proTranCode)==1}">
									구매완료 <a href="/purchase/updateTranCode?prodNo=${ prod.prodNo }&tranCode=2">배송하기</a>
								</c:if>
								<c:if test="${ fn:trim(prod.proTranCode)==2}">
									배송중
								</c:if>
								<c:if test="${ fn:trim(prod.proTranCode)==3}">
									배송완료
								</c:if>
							</c:if>
							<c:if test="${ empty prod.proTranCode }">
								판매중
							</c:if>
						</div>
						<div class="card-footer text-muted">
								${prod.regDate}
						</div>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>
</c:if>
</form>
</body>
</html>
