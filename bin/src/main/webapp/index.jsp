<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8"%>


<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- ///////////////////////////// 로그인시 Forward  /////////////////////////////////////// -->
<c:if test="${ ! empty user }">
	<jsp:forward page="main.jsp"/>
</c:if>
 <!-- //////////////////////////////////////////////////////////////////////////////////////////////////// -->


<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="UTF-8">
	
	<!-- 참조 : http://getbootstrap.com/css/   -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

	<!-- Bootstrap 4 CSS -->
	<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
	<!-- Bootstrap 4 CSS -->
	<link href="https://stackpath.bootstrapcdn.com/bootswatch/4.5.2/sketchy/bootstrap.min.css" rel="stylesheet">

	<!-- Bootstrap 4 JS bundle (includes Popper.js) -->
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
	<!-- 카카오톡 로그인 JS -->
	<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>





	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style></style>
   	
   	<!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
		//<![CDATA[
		// 사용할 앱의 JavaScript 키를 설정해 주세요.
		$(document).ready(function() {
			Kakao.init('bde4d0b1dd558fcdac6b04e0ba243c20');
			// 카카오 로그인 버튼을 생성합니다.
			Kakao.Auth.createLoginButton({
				container: '#kakao-login-btn',
				success: function (authObj) {
					debugger;
					// alert(JSON.stringify(authObj));
					console.log(authObj);
					// window.location.href = "http://192.168.0.17:8080/main.jsp";
				},
				fail: function (err) {
					alert(JSON.stringify(err));
				}
			});
		});
		//]]>
		$(function () {
			// DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$("#userId").focus();

			// 로그인 처리 함수
			function processLogin() {
				var id = $("input:text").val();
				var pw = $("input:password").val();

				if (id == null || id.length < 1) {
					alert('ID 를 입력하지 않으셨습니다.');
					$("input:text").focus();
					return;
				}

				if (pw == null || pw.length < 1) {
					alert('패스워드를 입력하지 않으셨습니다.');
					$("input:password").focus();
					return;
				}

				////////////////////////////////////////////////// 추가 , 변경된 부분 ////////////////////////////////////////////////////////////
				//$("form").attr("method","POST").attr("action","/user/login").attr("target","_parent").submit();
				////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

				$.ajax(
						{
							url: "/user/json/login",
							method: "POST",
							dataType: "json",
							headers: {
								"Accept": "application/json",
								"Content-Type": "application/json"
							},
							data: JSON.stringify({
								userId: id,
								password: pw
							}),
							success: function (JSONData, status) {
								if (JSONData != null) {
									//[방법1]
									$(window.parent.document.location).attr("href","/index.jsp");

								} else {
									alert("아이디 , 패스워드를 확인하시고 다시 로그인...");
								}
							}
						});
			}

			$("input").on("keypress", function (event) {
				if (event.which == 13) { // 13 == 엔터키
					event.preventDefault();
					processLogin();
				}
			});

			// "Login"  Event 연결
			$("#signIn").on("click", function (event) {
				event.preventDefault();
				processLogin();
			});
		});
		//============= 회원원가입 화면이동 =============
		$( function() {
			//==> 추가된부분 : "addUser"  Event 연결
			$("#signUp").on("click", function(event) {
				event.preventDefault();
				self.location = "/user/addUser";
			});

		});
	</script>	
	
</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<nav class="navbar navbar-expand-lg bg-primary" data-bs-theme="dark">
		<div class="container-fluid">
			<a class="navbar-brand" href="#" style="color: whitesmoke">Model2 MVC Shop</a>
			<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarColor01" aria-controls="navbarColor01" aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="navbar-collapse collapse show" id="navbarColor01" style="">
				<ul class="navbar-nav me-auto">
					<li class="nav-item">
					</li>
				</ul>
				<form class="d-flex ml-auto">
					<input class="form-control me-sm-2" type="text" placeholder="ID">
					<input class="form-control me-sm-2" type="password" placeholder="password">
					<button class="btn btn-secondary my-2 my-sm-0" type="submit"style="width: 200px;" id = "signIn">Sign in</button>
					<button class="btn btn-secondary my-2 my-sm-0" type="submit"style="width: 200px;" id = "signUp">Sign Up</button>
				</form>
			</div>
		</div>
	</nav>
   	<!-- ToolBar End /////////////////////////////////////-->
   	
	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container mt-5">
		
		<!-- 다단레이아웃  Start /////////////////////////////////////-->
		<div class="row">
	
			<!--  Menu 구성 Start /////////////////////////////////////-->     	
			<div class="col-md-3">

				<div class="list-group mb-5">
					<a href="#" class="list-group-item list-group-item-action active disabled">회원 관리</a>
					<a href="#" class="list-group-item list-group-item-action">개인정보 조회</a>
					<a href="#" class="list-group-item list-group-item-action">회원정보 조회</a>
				</div>

				<div class="list-group mb-5">
					<a href="#" class="list-group-item list-group-item-action active disabled">판매상품 관리</a>
					<a href="#" class="list-group-item list-group-item-action">판매상품등록</a>
					<a href="#" class="list-group-item list-group-item-action">판매상품관리</a>
				</div>

				<div class="list-group mb-5">
					<a href="#" class="list-group-item list-group-item-action active disabled">상품구매</a>
					<a href="#" class="list-group-item list-group-item-action">상품검색</a>
					<a href="#" class="list-group-item list-group-item-action">구매이력조회</a>
					<a href="#" class="list-group-item list-group-item-action">최근 본 상품</a>
				</div>
			</div>
			<!--  Menu 구성 end /////////////////////////////////////-->   

	 	 	<!--  Main start /////////////////////////////////////-->   		
	 	 	<div class="col-md-9">
				<div class="jumbotron">
			  		<h1>Model2 MVC Shop</h1>
			  		<p>로그인 후 사용가능...</p>
			  		<p>로그인 전 검색만 가능합니다.</p>
					<!-- 카카오 -->
				</div>
				<div id="kakao"></div>
				<a class="p-2" id = "kakao-login-btn" href="https://kauth.kakao.com/oauth/authorize?client_id=cec50764919801119a69066d40036533&redirect_uri=http://192.168.0.17:8080/kakao/login&response_type=code">
				</a>
			  		<p>회원가입 하세요.</p>
			  	</div>
	        </div>
	   	 	<!--  Main end /////////////////////////////////////-->   		
	 	 	
		</div>
		<!-- 다단레이아웃  end /////////////////////////////////////-->
		
	</div>
	<!--  화면구성 div end /////////////////////////////////////-->
</body>

</html>