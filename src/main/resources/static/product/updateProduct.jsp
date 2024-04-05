<%-- <%@page import="com.model2.mvc.service.domain.Product"%> --%>
<%@ page language="java" contentType="text/html; charset=EUC-KR" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--<% Product vo = (Product)request.getAttribute("ProdVO"); --%>

<html>
<head>
<title>상품정보수정</title>

</script>

<script type="text/javascript">
<!--
function fncAddProduct(){
	//Form 유효성 검증
 	var name = document.detailForm.prodName.value;
	var detail = document.detailForm.prodDetail.value;
	var manuDate = document.detailForm.manuDate.value;
	var price = document.detailForm.price.value;

	if(name == null || name.length<1){
		alert("상품명은 반드시 입력하여야 합니다.");
		return;
	}
	if(detail == null || detail.length<1){
		alert("상품상세정보는 반드시 입력하여야 합니다.");
		return;
	}
	if(manuDate == null || manuDate.length<1){
		alert("제조일자는 반드시 입력하셔야 합니다.");
		return;
	}
	if(price == null || price.length<1){
		alert("가격은 반드시 입력하셔야 합니다.");
		return;
	}
		
	document.detailForm.action='/product/updateProduct';
	document.detailForm.submit();
}
-->
</script>
	<style>

		.fa-calendar {
			position: absolute;
			top: 13px;
			font-size: 20px;
			color: #1976D2;
			z-index: 1000;
		}

		#fa-1 {
			left: calc(50% - 40px);
		}

		button:focus {
			-moz-box-shadow: none !important;
			-webkit-box-shadow: none !important;
			box-shadow: none !important;
			outline-width: 0;
		}

		.datepicker {
			background-color: #fff;
			border-radius: 0 !important;
			align-content: center !important;
			padding: 0 !important;
		}

		.datepicker-dropdown {
			top: 180px !important;
			left: calc(50% - 173.5px) !important;
			border-right: #1976D2;
			border-left: #1976D2;
		}

		.datepicker-dropdown.datepicker-orient-left:before {
			left: calc(50% - 6px) !important;
		}

		.datepicker-dropdown.datepicker-orient-left:after {
			left: calc(50% - 5px) !important;
			border-bottom-color: #1976D2;
		}

		.datepicker-dropdown.datepicker-orient-right:after {
			border-bottom-color: #1976D2;
		}

		.datepicker table tr td.today, span.focused {
			border-radius: 50% !important;
			background-image: linear-gradient(#FFF3E0, #FFE0B2);
		}

		thead tr:nth-child(2) {
			background-color: #1976D2 !important;
		}

		/*Weekday title*/
		thead tr:nth-child(3) th {
			font-weight: bold !important;
			padding: 20px 10px !important;
			color: #BDBDBD !important;
		}

		tbody tr td {
			padding: 10px !important;
		}

		tfoot tr:nth-child(2) th {
			padding: 10px !important;
			border-top: 1px solid #CFD8DC !important;
		}

		.cw {
			font-size: 14px !important;
			background-color: #E8EAF6 !important;
			border-radius: 0px !important;
			padding: 0px 20px !important;
			margin-right: 10px solid #fff !important;
		}

		.old, .day, .new {
			width: 40px !important;
			height: 40px !important;
			border-radius: 0px !important;
		}

		.day.old, .day.new {
			color: #E0E0E0 !important;
		}

		.day.old:hover, .day.new:hover {
			border-radius: 50% !important;
		}

		.old-day:hover, .day:hover, .new-day:hover, .month:hover, .year:hover, .decade:hover, .century:hover {
			border-radius: 50% !important;
			background-color: #eee;
		}

		.active {
			border-radius: 50% !important;
			background-image: linear-gradient(#1976D2, #1976D2) !important;
			color: #fff !important;
		}

		.range-start, .range-end {
			border-radius: 50% !important;
			background-image: linear-gradient(#1976D2, #1976D2) !important;
		}

		.range {
			background-color: #E3F2FD !important;
		}

		.prev, .next, .datepicker-switch {
			border-radius: 0 !important;
			padding: 10px 10px 10px 10px !important;
			font-size: 18px;
			opacity: 0.7;
			color: #fff;
		}

		.prev:hover, .next:hover, .datepicker-switch:hover {
			background-color: inherit !important;
			opacity: 1;
		}

		@media screen and (max-width: 726px) {
			.datepicker-dropdown.datepicker-orient-right:before {
				right: calc(50% - 6px);
			}

			.datepicker-dropdown.datepicker-orient-right:after {
				right: calc(50% - 5px);
			}
		}
		body {
			padding-top: 90px;
		}

		#center-test{
			text-align: center;
		}
		.form-group{
			text-align: center;
		}
		button{
			text-align: center;
		}
	</style>
	</script>
</head>

<body bgcolor="#ffffff" text="#000000">
<jsp:include page="/layout/toolbar.jsp" />
<form name="detailForm" method="post" enctype="multipart/form-data">
	<div class="container" id = "center-test">

		<div class="page-header text-center">
			<h3 class=" text-info">상품정보 수정</h3>
			<h5 class="text-muted">상품 정보를 <strong class="text-danger">최신정보로 수정</strong>해 주세요.</h5>
		</div>

		<!-- form Start /////////////////////////////////////-->
		<form class="form-horizontal">
			<input type="hidden" name="prodNo" value="${ UpdateProdVO.prodNo }"/>
			<div class="form-group text-center">
				<label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">상품명</label>
				<div class="col-sm-4" style="display: block; margin-left: auto; margin-right: auto;">
					<input type="text" id = "prodName" name = "prodName" class="form-control" placeholder="${ UpdateProdVO.prodName }">
				</div>
			</div>

			<div class="form-group">
				<label for="prodDetail" class="col-sm-offset-1 col-sm-3 control-label">상품 상세정보</label>
				<div class="col-sm-4" style="display: block; margin-left: auto; margin-right: auto;">
					<input type="text" class="form-control" id="prodDetail" name="prodDetail" placeholder="${UpdateProdVO.prodDetail}">
				</div>
			</div>
			<%--			<div class="form-group">--%>
			<%--				<label for="manuDate" class="col-sm-offset-1 col-sm-3 control-label">제조일자</label>--%>
			<%--				<div class="col-sm-4" style="display: block; margin-left: auto; margin-right: auto;">--%>
			<%--					<input type="text" class="form-control input-daterange" id="manuDate" name="manuDate" placeholder="제조 일자"  readonly>--%>
			<%--				</div>--%>
			<%--			</div>--%>
			<div class="container px-1 px-sm-5 mx-auto">
				<form autocomplete="off">
					<div class="flex-row d-flex justify-content-center">
						<div class="col-lg-6 col-11 px-1">
							<div class="form-group input-daterange">
								<label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">제조일자</label>
								<div class="col-sm-4" style="display: block; margin-left: auto; margin-right: auto;">
									<input type="text" id="start" name = "manuDate" class="form-control" placeholder="${ UpdateProdVO.manuDate }" readonly>
								</div>
								<span class="fa fa-calendar" id="fa-1"></span>
							</div>
						</div>
					</div>
				</form>
			</div>
			<div class="form-group">
				<label for="price" class="col-sm-offset-1 col-sm-3 control-label">가격</label>
				<div class="col-sm-4" style="display: block; margin-left: auto; margin-right: auto;">
					<input type="text" class="form-control" id="price" name="price" placeholder="${UpdateProdVO.price}">
				</div>
			</div>

			<div class="form-group">
				상품 이미지
				<div class="col-sm-4" style="display: block; margin-left: auto; margin-right: auto;">
					<input type = "file" name = "uploadFile" id = "uploadFile" class ="form-control" style = "width:300px; height: 30px" maxlength="13"/>
				</div>
				<div class="form-group">
					<div class="col-sm-4" style="display: block; margin-left: auto; margin-right: auto;">
						<a href="javascript:fncAddProduct();" class="btn btn-primary" id = "add">수 &nbsp;정</a>
						<a href="javascript:resetData();" class = "btn btn-primary">취 &nbsp;소</a>
					</div>
				</div>
			</div>
		</form>
	</div>
	<!-- form Start /////////////////////////////////////-->

</form>
</body>
</html>
<!--  화면구성 div Start /////////////////////////////////////-->