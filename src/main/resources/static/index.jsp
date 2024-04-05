<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>


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
	<meta charset="EUC-KR">
	
	<!-- 참조 : http://getbootstrap.com/css/   -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
<%--	<!-- Bootstrap CSS -->--%>
<%--	<link href="https://cdn.jsdelivr.net/npm/bootswatch@5.3.0/dist/sketchy/bootstrap.min.css" rel="stylesheet">--%>

<%--	<!-- Bootstrap 5 JS bundle (includes Popper.js) -->--%>
<%--	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>--%>

<%--	<!-- jQuery -->--%>
<%--	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>--%>
	<!-- Bootstrap Datepicker CSS -->
<%--	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.css">--%>

<%--	<!-- Twitter Bootstrap CSS -->--%>
<%--	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.4.1/css/bootstrap.css">--%>
<%--	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/2.3.2/css/bootstrap-responsive.css">--%>

<%--	<!-- jQuery -->--%>
<%--	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>--%>

<%--	<!-- Bootstrap Datepicker JS -->--%>
<%--	<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.js"></script>--%>

<%--	<!-- Twitter Bootstrap JS -->--%>
<%--	<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.4.1/js/bootstrap.js"></script>--%>

<%--	<!-- Bootswatch Sketchy CSS -->--%>
<%--	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootswatch@4.5.2/dist/sketchy/bootstrap.min.css" integrity="sha384-RxqHG2ilm4r6aFRpGmBbGTjsqwfqHOKy1ArsMhHusnRO47jcGqpIQqlQK/kmGy9R" crossorigin="anonymous">--%>
	<!-- jQuery -->
<%--	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>--%>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<%--<link href="https://maxcdn.bootstrapcdn.com/bootswatch/4.5.2/sketchy/bootstrap.min.css" rel="stylesheet">--%>

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
			Kakao.init('156ad557ed4df3d2e6fa9905dae81a56');
			// 카카오 로그인 버튼을 생성합니다.
			Kakao.Auth.createLoginButton({
				container: '#kakao-login-btn',
				success: function (authObj) {
					debugger;
					alert(JSON.stringify(authObj));
					console.log(authObj);
					window.location.href = "http://192.168.0.17:8080/main.jsp";
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
								//Debug...
								//alert(status);
								//alert("JSONData : \n"+JSONData);
								//alert( "JSON.stringify(JSONData) : \n"+JSON.stringify(JSONData) );
								//alert( JSONData != null );

								if (JSONData != null) {
									//[방법1]
									$(window.parent.document.location).attr("href","/index.jsp");

									//[방법2]
									// window.parent.document.location.reload();

									//[방법3]
									// $(window.parent.frames["topFrame"].document.location).attr("href", "/layout/top.jsp");
									// $(window.parent.frames["leftFrame"].document.location).attr("href", "/layout/left.jsp");
									// $(window.parent.frames["rightFrame"].document.location).attr("href", "/user/getUser?userId=" + JSONData.userId);

									//==> 방법 1 , 2 , 3 결과 학인
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
		        
		       	<!--  회원관리 목록에 제목 -->
<%--				<div class="panel panel-primary">--%>
<%--					<div class="panel-heading">--%>
<%--						<i class="glyphicon glyphicon-heart"></i> 회원관리--%>
<%--         			</div>--%>
<%--         			<!--  회원관리 아이템 -->--%>
<%--					<ul class="list-group">--%>
<%--						 <li class="list-group-item">--%>
<%--						 	<a class="disabled" href="#" tabindex="-1" aria-disabled="true">개인정보조회</a> <span class="glyphicon glyphicon-ban-circle"></span>--%>
<%--						 </li>--%>
<%--						 <li class="list-group-item">--%>
<%--						 	<a href="#">회원정보조회</a> <span class="glyphicon glyphicon-ban-circle"></span>--%>
<%--						 </li>--%>
<%--					</ul>--%>
<%--		        </div>--%>
				<div class="list-group mb-5">
					<a href="#" class="list-group-item list-group-item-action active disabled">회원 관리</a>
					<a href="#" class="list-group-item list-group-item-action">개인정보 조회</a>
					<a href="#" class="list-group-item list-group-item-action">회원정보 조회</a>
				</div>
               
               
<%--				<div class="panel panel-primary">--%>
<%--					<div class="panel-heading">--%>
<%--							<i class="glyphicon glyphicon-briefcase"></i> 판매상품관리--%>
<%--         			</div>--%>
<%--					<ul class="list-group">--%>
<%--						 <li class="list-group-item">--%>
<%--						 	<a href="#">판매상품등록</a> <i class="glyphicon glyphicon-ban-circle"></i>--%>
<%--						 </li>--%>
<%--						 <li class="list-group-item">--%>
<%--						 	<a href="#">판매상품관리</a> <i class="glyphicon glyphicon-ban-circle"></i>--%>
<%--						 </li>--%>
<%--					</ul>--%>
<%--		        </div>--%>
				<div class="list-group mb-5">
					<a href="#" class="list-group-item list-group-item-action active disabled">판매상품 관리</a>
					<a href="#" class="list-group-item list-group-item-action">판매상품등록</a>
					<a href="#" class="list-group-item list-group-item-action">판매상품관리</a>
				</div>
               
               
<%--				<div class="panel panel-primary">--%>
<%--					<div class="panel-heading">--%>
<%--							<i class="glyphicon glyphicon-shopping-cart"></i> 상품구매--%>
<%--	    			</div>--%>
<%--					<ul class="list-group">--%>
<%--						 <li class="list-group-item"><a href="#">상품검색</a></li>--%>
<%--						  <li class="list-group-item">--%>
<%--						  	<a href="#">구매이력조회</a> <i class="glyphicon glyphicon-ban-circle"></i>--%>
<%--						  </li>--%>
<%--						 <li class="list-group-item">--%>
<%--						 	<a href="#">최근본상품</a> <i class="glyphicon glyphicon-ban-circle"></i>--%>
<%--						 </li>--%>
<%--					</ul>--%>
<%--				</div>--%>
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
				<a class="p-2" id = "kakao-login-btn" href="https://kauth.kakao.com/oauth/authorize?client_id=8df753a4b334db7b6d9d4824b176caf5&redirect_uri=http://192.168.0.17:8080/kakao/login&response_type=code">
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