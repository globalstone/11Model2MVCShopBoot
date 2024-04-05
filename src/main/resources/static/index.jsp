<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>


<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- ///////////////////////////// �α��ν� Forward  /////////////////////////////////////// -->
<c:if test="${ ! empty user }">
	<jsp:forward page="main.jsp"/>
</c:if>
 <!-- //////////////////////////////////////////////////////////////////////////////////////////////////// -->


<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="EUC-KR">
	
	<!-- ���� : http://getbootstrap.com/css/   -->
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
	<!-- īī���� �α��� JS -->
	<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>





	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style></style>
   	
   	<!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
		//<![CDATA[
		// ����� ���� JavaScript Ű�� ������ �ּ���.
		$(document).ready(function() {
			Kakao.init('156ad557ed4df3d2e6fa9905dae81a56');
			// īī�� �α��� ��ư�� �����մϴ�.
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
			// DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$("#userId").focus();

			// �α��� ó�� �Լ�
			function processLogin() {
				var id = $("input:text").val();
				var pw = $("input:password").val();

				if (id == null || id.length < 1) {
					alert('ID �� �Է����� �����̽��ϴ�.');
					$("input:text").focus();
					return;
				}

				if (pw == null || pw.length < 1) {
					alert('�н����带 �Է����� �����̽��ϴ�.');
					$("input:password").focus();
					return;
				}

				////////////////////////////////////////////////// �߰� , ����� �κ� ////////////////////////////////////////////////////////////
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
									//[���1]
									$(window.parent.document.location).attr("href","/index.jsp");

									//[���2]
									// window.parent.document.location.reload();

									//[���3]
									// $(window.parent.frames["topFrame"].document.location).attr("href", "/layout/top.jsp");
									// $(window.parent.frames["leftFrame"].document.location).attr("href", "/layout/left.jsp");
									// $(window.parent.frames["rightFrame"].document.location).attr("href", "/user/getUser?userId=" + JSONData.userId);

									//==> ��� 1 , 2 , 3 ��� ����
								} else {
									alert("���̵� , �н����带 Ȯ���Ͻð� �ٽ� �α���...");
								}
							}
						});
			}

			$("input").on("keypress", function (event) {
				if (event.which == 13) { // 13 == ����Ű
					event.preventDefault();
					processLogin();
				}
			});

			// "Login"  Event ����
			$("#signIn").on("click", function (event) {
				event.preventDefault();
				processLogin();
			});
		});
		//============= ȸ�������� ȭ���̵� =============
		$( function() {
			//==> �߰��Ⱥκ� : "addUser"  Event ����
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
   	
	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
	<div class="container mt-5">
		
		<!-- �ٴܷ��̾ƿ�  Start /////////////////////////////////////-->
		<div class="row">
	
			<!--  Menu ���� Start /////////////////////////////////////-->     	
			<div class="col-md-3">
		        
		       	<!--  ȸ������ ��Ͽ� ���� -->
<%--				<div class="panel panel-primary">--%>
<%--					<div class="panel-heading">--%>
<%--						<i class="glyphicon glyphicon-heart"></i> ȸ������--%>
<%--         			</div>--%>
<%--         			<!--  ȸ������ ������ -->--%>
<%--					<ul class="list-group">--%>
<%--						 <li class="list-group-item">--%>
<%--						 	<a class="disabled" href="#" tabindex="-1" aria-disabled="true">����������ȸ</a> <span class="glyphicon glyphicon-ban-circle"></span>--%>
<%--						 </li>--%>
<%--						 <li class="list-group-item">--%>
<%--						 	<a href="#">ȸ��������ȸ</a> <span class="glyphicon glyphicon-ban-circle"></span>--%>
<%--						 </li>--%>
<%--					</ul>--%>
<%--		        </div>--%>
				<div class="list-group mb-5">
					<a href="#" class="list-group-item list-group-item-action active disabled">ȸ�� ����</a>
					<a href="#" class="list-group-item list-group-item-action">�������� ��ȸ</a>
					<a href="#" class="list-group-item list-group-item-action">ȸ������ ��ȸ</a>
				</div>
               
               
<%--				<div class="panel panel-primary">--%>
<%--					<div class="panel-heading">--%>
<%--							<i class="glyphicon glyphicon-briefcase"></i> �ǸŻ�ǰ����--%>
<%--         			</div>--%>
<%--					<ul class="list-group">--%>
<%--						 <li class="list-group-item">--%>
<%--						 	<a href="#">�ǸŻ�ǰ���</a> <i class="glyphicon glyphicon-ban-circle"></i>--%>
<%--						 </li>--%>
<%--						 <li class="list-group-item">--%>
<%--						 	<a href="#">�ǸŻ�ǰ����</a> <i class="glyphicon glyphicon-ban-circle"></i>--%>
<%--						 </li>--%>
<%--					</ul>--%>
<%--		        </div>--%>
				<div class="list-group mb-5">
					<a href="#" class="list-group-item list-group-item-action active disabled">�ǸŻ�ǰ ����</a>
					<a href="#" class="list-group-item list-group-item-action">�ǸŻ�ǰ���</a>
					<a href="#" class="list-group-item list-group-item-action">�ǸŻ�ǰ����</a>
				</div>
               
               
<%--				<div class="panel panel-primary">--%>
<%--					<div class="panel-heading">--%>
<%--							<i class="glyphicon glyphicon-shopping-cart"></i> ��ǰ����--%>
<%--	    			</div>--%>
<%--					<ul class="list-group">--%>
<%--						 <li class="list-group-item"><a href="#">��ǰ�˻�</a></li>--%>
<%--						  <li class="list-group-item">--%>
<%--						  	<a href="#">�����̷���ȸ</a> <i class="glyphicon glyphicon-ban-circle"></i>--%>
<%--						  </li>--%>
<%--						 <li class="list-group-item">--%>
<%--						 	<a href="#">�ֱٺ���ǰ</a> <i class="glyphicon glyphicon-ban-circle"></i>--%>
<%--						 </li>--%>
<%--					</ul>--%>
<%--				</div>--%>
				<div class="list-group mb-5">
					<a href="#" class="list-group-item list-group-item-action active disabled">��ǰ����</a>
					<a href="#" class="list-group-item list-group-item-action">��ǰ�˻�</a>
					<a href="#" class="list-group-item list-group-item-action">�����̷���ȸ</a>
					<a href="#" class="list-group-item list-group-item-action">�ֱ� �� ��ǰ</a>
				</div>
			</div>
			<!--  Menu ���� end /////////////////////////////////////-->   

	 	 	<!--  Main start /////////////////////////////////////-->   		
	 	 	<div class="col-md-9">
				<div class="jumbotron">
			  		<h1>Model2 MVC Shop</h1>
			  		<p>�α��� �� ��밡��...</p>
			  		<p>�α��� �� �˻��� �����մϴ�.</p>
					<!-- īī�� -->
				</div>
				<div id="kakao"></div>
				<a class="p-2" id = "kakao-login-btn" href="https://kauth.kakao.com/oauth/authorize?client_id=8df753a4b334db7b6d9d4824b176caf5&redirect_uri=http://192.168.0.17:8080/kakao/login&response_type=code">
				</a>
			  		<p>ȸ������ �ϼ���.</p>
			  	</div>
	        </div>
	   	 	<!--  Main end /////////////////////////////////////-->   		
	 	 	
		</div>
		<!-- �ٴܷ��̾ƿ�  end /////////////////////////////////////-->
		
	</div>
	<!--  ȭ�鱸�� div end /////////////////////////////////////-->

</body>

</html>