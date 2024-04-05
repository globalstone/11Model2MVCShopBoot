<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- jQuery -->
<%--<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>--%>
<%--<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>--%>
<%--<link rel="stylesheet" href="https://code.jquery.com/ui/1.13.2/themes/smoothness/jquery-ui.css">--%>
<!-- Bootstrap CSS -->
<%--<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>--%>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<%--<link href="https://maxcdn.bootstrapcdn.com/bootswatch/4.5.2/sketchy/bootstrap.min.css" rel="stylesheet">--%>

<!-- Bootstrap 4 CSS -->
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<!-- Bootstrap 4 CSS -->
<link href="https://stackpath.bootstrapcdn.com/bootswatch/4.5.2/sketchy/bootstrap.min.css" rel="stylesheet">

<!-- Bootstrap 4 JS bundle (includes Popper.js) -->
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<!-- Datepicker CSS -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.min.css" rel="stylesheet">

<!-- Datepicker JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js"></script>

<!-- Datepicker Locale -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/locales/bootstrap-datepicker.ko.min.js"></script>


<!-- Bootstrap 5 JS bundle (includes Popper.js) -->
<%--<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>--%>

<%--<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>--%>
<%--<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>--%>
<%--<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>--%>
<%--<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootswatch@4.5.2/dist/sketchy/bootstrap.min.css" integrity="sha384-RxqHG2ilm4r6aFRpGmBbGTjsqwfqHOKy1ArsMhHusnRO47jcGqpIQqlQK/kmGy9R" crossorigin="anonymous">--%>
<%--<link rel="stylesheet" href="https://code.jquery.com/ui/1.13.2/themes/smoothness/jquery-ui.css">--%>


<nav class="navbar navbar-expand-lg bg-primary navbar-inverse fixed-top" data-bs-theme="dark">
	<div class = "container-fluid">
	<a class="navbar-brand" href="#" style="color: whitesmoke" id="brandLink">Model2 MVC Shop</a>
	<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarColor01" aria-controls="navbarColor01" aria-expanded="false" aria-label="Toggle navigation">
		<span class="navbar-toggler-icon"></span>
	</button>
	<div class="navbar-collapse collapse show" id="navbarColor01" style="">
		<ul class="navbar-nav me-auto mb-2 mb-lg-0">
			<li class="nav-item dropdown">
				<a class="nav-link dropdown-toggle show" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="true">
					회원관리</a>
				<div class="dropdown-menu">
					<a class="dropdown-item" href="javascript:void(0);" id="getUserLink">개인정보조회</a>
					<c:if test="${user.role == 'admin'}">
						<a class="dropdown-item" href="javascript:void(0);">회원정보조회</a>
					</c:if>
					<div class="dropdown-divider"></div>
					<a class="dropdown-item" href="#">etc...</a>
				</div>
			</li>
			<c:if test="${user.role == 'admin'}">
				<li class="nav-item dropdown">
					<a class="nav-link dropdown-toggle show" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="true">상품관리</a>
					<div class="dropdown-menu">
						<a class="dropdown-item" href="javascript:void(0);">판매상품등록</a>
						<a class="dropdown-item" href="javascript:void(0);">판매상품관리</a>
						<a class="dropdown-item" href="#">배송관리</a>
						<div class="dropdown-divider"></div>
						<a class="dropdown-item" href="#">etc...</a>
					</div>
				</li>
			</c:if>
			<li class="nav-item dropdown">
				<a class="nav-link dropdown-toggle show" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="true">상품구매</a>
				<div class="dropdown-menu">
					<a class="dropdown-item" href="javascript:void(0);">상품검색</a>
					<a class="dropdown-item" href="javascript:void(0);">구매이력조회</a>
					<a class="dropdown-item" href="javascript:void(0);">찜 목록</a>
					<div class="dropdown-divider"></div>
					<a class="dropdown-item" href="#">etc...</a>
				</div>
			</li>
		</ul>
		<form class="d-flex ml-auto">
			<h4>${user.userName}님 환영합니다.</h4>
			<button class="btn btn-secondary me-2" type="submit" id="Logout">Log out</button>
		</form>
	</div>
	</div>
</nav>

<script type="text/javascript">

	$(document).ready(function() {
		$("#brandLink").on("click", function(event) {
			self.location.href = "/main.jsp";
		});

		$("#getUserLink").on("click", function(event) {
			event.preventDefault();
			var userId = "${sessionScope.user.userId}";
			self.location.href = "/user/getUser?userId=" + userId;
		});

		$("#Logout").on("click", function(event) {
			event.preventDefault();
			$(self.location).attr("href", "/user/logout");
		});

		$(document).ready(function() {
			$(".dropdown-item").on("click", function (event) {
				event.preventDefault();
				var href = $(this).attr("href");

				if (href === "#") {
					// Handle dropdown toggle
					$(this).dropdown("toggle");
				} else {
					// Redirect to the specified link
					self.location.href = href;
				}
			});
		});

		$(function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$("a:contains('회원정보조회')").on("click" , function() {
				//$(self.location).attr("href","/user/logout");
				self.location = "/user/listUser"
			});
		});

		$(function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$("a:contains('판매상품등록')").on("click" , function() {
				//$(self.location).attr("href","/user/logout");
				self.location = "/product/addProductView.jsp"
			});
		});

		$(function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$("a:contains('판매상품관리')").on("click" , function() {
				//$(self.location).attr("href","/user/logout");
				self.location = "/product/listProduct/manage"
			});
		});

		$(function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$("a:contains('상품검색')").on("click" , function() {
				//$(self.location).attr("href","/user/logout");
				self.location = "/product/listProduct/search"
			});
		});

		$(function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$("a:contains('구매이력조회')").on("click" , function() {
				//$(self.location).attr("href","/user/logout");
				self.location = "/purchase/listPurchase"
			});
		});

		$(function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$("a:contains('최근본상품')").on("click" , function() {
				//$(self.location).attr("href","/user/logout");
				window.open("/history.jsp", "_blank");
			});
		});
	});
</script>
<style>

	.nav-link {
		color: whitesmoke;
	}
	h4 {
		color: whitesmoke;
	}
	.navbar-nav .nav-link {
		font-size: 16px;
	}

	.navbar-brand {
		font-size: 18px;
	}
</style>