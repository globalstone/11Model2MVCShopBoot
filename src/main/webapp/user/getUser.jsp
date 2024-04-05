<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>


<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="EUC-KR">

	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />

	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
<%--	<link href="https://cdn.jsdelivr.net/npm/bootswatch@5.3.0/dist/sketchy/bootstrap.min.css" rel="stylesheet">--%>

	<!-- Bootstrap 5 JS bundle (includes Popper.js) -->

<%--	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>--%>

	<!-- jQuery -->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<!--  ///////////////////////// CSS ////////////////////////// -->

	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
<%--	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >--%>
<%--	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>--%>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>

	<!-- Bootstrap Dropdown Hover CSS -->
	<link href="/css/animate.min.css" rel="stylesheet">
	<link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
	<!-- Bootstrap Dropdown Hover JS -->
	<script src="/javascript/bootstrap-dropdownhover.min.js"></script>


	<!-- jQuery UI toolTip 사용 CSS-->
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<!-- jQuery UI toolTip 사용 JS-->
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<style>
		body {
			padding-top: 70px; /* 툴바의 높이만큼 추가 */
		}
		 .table th, .table td {
			 font-size: 20px; /* 글자 크기를 20px로 설정 */
		 }
		#navs {
			font-size: 50px; /* 'Profile' 텍스트의 글자 크기를 30px로 설정 */
		}

		#edit {
			font-size: 20px; /* 버튼의 글자 크기를 20px로 설정 */
			padding: 7px 14px; /* 버튼의 패딩을 조정하여 버튼의 크기를 늘림 */
		}
	</style>
    
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">

		//============= 회원정보수정 Event  처리 =============	
		$(function () {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$("button").on("click", function () {
				self.location = "/user/updateUser?userId=${user.userId}"
			});
		});

	</script>

</head>
<body>
<jsp:include page="/layout/toolbar.jsp" />
<div class="container">
	<div class = "bs-docs-section">
		<div class="row">
			<div class = "col-lg-12">
				<div class = "page-header">
					<h1 id = "navs">Profile</h1>
	<table class="table table-hover">
		<thead>
		<tr>
			<th scope="col">UserID</th>
			<th scope="col">${user.userId}</th>
		</tr>
		</thead>
		<tbody>
			<tr class="table-active">
				<th scope="row">UserName</th>
				<td>${user.userName}</td>
			</tr>
		</tbody>
			<thead>
			<tr>
				<th scope="col">ADDR</th>
				<th scope="col">${user.addr}</th>
			</tr>
			</thead>
		<tbody>
			<tr class="table-active">
				<th scope="row">Phone</th>
				<td>${ !empty user.phone ? user.phone : ''}</td>
			</tr>
		</tbody>
		<thead>
		<tr>
			<th scope="col">email</th>
			<th scope="col">${user.email}</th>
		</tr>
		</thead>
		<tbody>
		<tr class="table-active">
			<th scope="row">RegDate</th>
			<td>${ user.regDate}</td>
		</tr>
		</tbody>
	</table>
 	<!--  화면구성 div Start /////////////////////////////////////-->
				</div>
			</div>
		</div>
	</div>
</div>
			<div class="row">
		  		<div class="col-md-12 text-center ">
		  			<button type="button" class="btn btn-primary" id = "edit">edit profile</button>
		  		</div>
			</div>
</body>

</html>