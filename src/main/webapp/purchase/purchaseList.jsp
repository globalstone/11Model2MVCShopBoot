<%-- 
<%@page import="java.util.List"%>
<%@page import="com.model2.mvc.common.Search"%>
<%@page import="com.model2.mvc.service.domain.*"%>
<%@page import="com.model2.mvc.common.Page"%>
--%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%-- 
<%
	List<Purchase> list = (List<Purchase>)request.getAttribute("list");
	Search searchVO=(Search)request.getAttribute("searchVO");
	Page resultPage = (Page)request.getAttribute("resultPage");
%>
--%>
<html>
<head>
<title>구매 목록조회</title>

	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script type="text/javascript">
	function fncGetUserList(currentPage) {
		document.getElementById("currentPage").value = currentPage;
		document.detailForm.submit();
	}
</script>
	<style>
		body {
			padding-top: 90px;
		}
	</style>
</head>

<body bgcolor="#ffffff" text="#000000">
<jsp:include page="/layout/toolbar.jsp" />
<div style="width: 98%; margin-left: 10px;">

<form name="detailForm" action="/purchase/listPurchase" method="post">
	<div class="container">
		<div class = "bs-docs-section">
			<div class="row">
				<div class = "col-lg-12">
					<div class = "page-header">
						<h1 id = "navs">구매이력</h1>

<table class="table table-hover">
	<thead>
	<tr class="table-dark">
		<th scope="row">No</th>
		<td>회원ID</td>
		<td>회원명</td>
		<td>전화번호</td>
		<td>상품정보</td>
		<td>배송현황</td>
		<td>정보수정</td>
	</tr>
	</thead>
	<c:set var="i" value="0" />
	<c:forEach var="vo" items="${list}">
		<c:set var="i" value="${ i + 1 }" />
	<tbody>
	<tr class="table-active">
		<th scope="row"><a href="/purchase/getPurchase?tranNo=${ vo.tranNo }">${ i }</a></th>
		<td><a href="/user/getUser?userId=${ vo.buyer.userId }">${ vo.buyer.userId }</a></td>
		<td>${ vo.receiverName }</td>
		<td>${ vo.receiverPhone }</td>
		<td><a href="/product/getProduct/${vo.purchaseProd.prodNo }/search">상품정보</a></td>
		<td><c:if test="${ ! empty vo.tranCode }">
			<c:if test="${ fn:trim(vo.tranCode) == 1 }">
				현재구매완료상태 입니다.
			</c:if>
			<c:if test="${ fn:trim(vo.tranCode) == 2 }" >
				현재배송중상태 입니다.
			</c:if>
			<c:if test="${ fn:trim(vo.tranCode) == 3 }" >
				현재배송완료상태 입니다.
			</c:if>
		</c:if></td>
		<td><c:if test="${ !empty vo.tranCode }" >
			<c:if test="${ fn:trim(vo.tranCode) == 2 }" >
				<a href="/purchase/updateTranCode?prodNo=${ vo.purchaseProd.prodNo }&tranCode=3">물건도착</a>
			</c:if>
		</c:if>
		</td>
	</tr>
	</c:forEach>
	</tbody>
<!--  페이지 Navigator 끝 -->
					</div>
				</div>
			</div>
		</div>
	</div>
</form>
</div>
</body>
</div>

</body>
</html>