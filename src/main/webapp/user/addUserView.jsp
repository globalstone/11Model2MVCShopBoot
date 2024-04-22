<%@ taglib prefix="th" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">

<head>
	<meta charset="UTF-8">

	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />

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
	<!-- Kakao Map -->
	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

	<!-- CSS -->
	<style>

		body > div.container{
			border: 3px solid #606060;
			margin-top: 10px;
		}
	</style>

	<!-- JavaScript -->
	<script type="text/javascript">

		var checkNum; // 전역 변수로 선언

		$(document).ready(function() {
			$('#memberPhoneCheck').click(function () {

				var phone1 = $('#phone1').val();
				var phone2 = $('#phone2').val();
				var phone3 = $('#phone3').val();
				var memberPhone = phone1 + phone2 + phone3;


				var to = $('input[name="memberPhone"]').val();
				$.ajax({
					url: "/user/memberPhoneCheck",
					type: "POST",
					data: "to=" + memberPhone,
					dataType: "json",
					success: function (data) {
						checkNum = data;
						alert('checkNum:' + checkNum);

						//인증하기 버튼 클릭 이벤트
						$('#certifyCheck').click(function () {
							const userNum = $('input[name="memberPhoneCertify"]').val();
							if (checkNum == userNum) {
								alert('인증 성공하였습니다.');
							} else {
								alert('인증 실패하였습니다. 다시 입력해주세요.');
							}
						});

					},
					error: function () {
						alert("에러")
					}
				});
			});
		});


		// "가입" 이벤트 연결
		$(function () {
			$("#Join").on("click", function () {
				fncAddUser();
			});
		});

		// "취소" 이벤트 처리 및 연결
		$(function () {
			$("a[href='#']").on("click", function () {
				$("form")[0].reset();
			});
		});

		function fncAddUser() {
			var id = $("input[name='userId']").val();
			var pw = $("input[name='password']").val();
			var pw_confirm = $("input[name='password2']").val();
			var name = $("input[name='userName']").val();
			var auth = $("input[name='authCode']").val();
			var phone = $("input[name='memberPhoneCertify']").val();

			if (id == null || id.length < 1) {
				alert("아이디는 반드시 입력하셔야 합니다.");
				return;
			}
			if (pw == null || pw.length < 1) {
				alert("패스워드는 반드시 입력하셔야 합니다.");
				return;
			}
			if (phone == null || phone.length < 1 || phone != checkNum) {  // 인증 번호 검사 추가
				alert("인증번호가 일치하지 않습니다.");
				return;
			}
			if (pw_confirm == null || pw_confirm.length < 1) {
				alert("패스워드 확인은 반드시 입력하셔야 합니다.");
				return;
			}
			if (name == null || name.length < 1) {
				alert("이름은 반드시 입력하셔야 합니다.");
				return;
			}

			if (pw != pw_confirm) {
				alert("비밀번호 확인이 일치하지 않습니다.");
				$("input:text[name='password2']").focus();
				return;
			}
			if (auth == null || auth.length < 1) {
				alert("인증번호는 반드시 입력하셔야 합니다.");
				return;
			}

			var value = "";
			if ($("input:text[name='phone2']").val() != "" && $("input:text[name='phone3']").val() != "") {
				var value = $("option:selected").val() + "-"
						+ $("input[name='phone2']").val() + "-"
						+ $("input[name='phone3']").val();
			}

			$("input:hidden[name='phone']").val(value);
			$("form").attr("method", "POST").attr("action", "/user/addUser").submit();
		}

		// "이메일" 유효성 검사 이벤트 처리 및 연결
		$(function () {
			$("input[name='email']").on("change", function () {
				var email = $("input[name='email']").val();
				if (email != "" && (email.indexOf('@') < 1 || email.indexOf('.') == -1)) {
					alert("이메일 형식이 아닙니다.");
				}
			});
		});

		// 주민번호 유효성 검사
		function checkSsn() {
			var ssn = document.detailForm.ssn.value;
			if (!PortalJuminCheck(ssn)) {
				alert("잘못된 주민번호입니다.");
				return false;
			}
		}

		function PortalJuminCheck(fieldValue) {
			var pattern = /^([0-9]{6})-?([0-9]{7})$/;
			var num = fieldValue;
			if (!pattern.test(num)) return false;
			num = RegExp.$1 + RegExp.$2;

			var sum = 0;
			var last = num.charCodeAt(12) - 0x30;
			var bases = "234567892345";
			for (var i = 0; i < 12; i++) {
				if (isNaN(num.substring(i, i + 1))) return false;
				sum += (num.charCodeAt(i) - 0x30) * (bases.charCodeAt(i) - 0x30);
			}
			var mod = sum % 11;
			return ((11 - mod) % 10 == last) ? true : false;
		}

		// "ID중복확인" 이벤트 처리 및 연결
		$(function () {
			$("#btn-info").on("click", function () {
				popWin = window.open("/user/checkDuplication.jsp",
						"popWin",
						"left=300,top=200,width=780,height=130,marginwidth=0,marginheight=0," +
						"scrollbars=no,scrolling=no,menubar=no,resizable=no");
			});
			//인증하기 버튼을 눌렀을 때 동작
			$("#emailAuth").click(function () {
				const email = $("#email").val(); //사용자가 입력한 이메일 값 얻어오기

				//Ajax로 전송
				$.ajax({
					url : '/user/EmailAuth',
					data : {
						email : email
					},
					type : 'POST',
					dataType : 'json',
					success : function(result) {
						console.log("result : " + result);
						$("#authCode").attr("disabled", false);
						code = result;
						alert("인증 코드가 입력하신 이메일로 전송 되었습니다.");
					}
				}); //End Ajax
			})
			;

			$("#authCode").on("focusout", function() {
				const inputCode = $("#authCode").val(); //인증번호 입력 칸에 작성한 내용 가져오기

				console.log("입력코드 : " + inputCode);
				console.log("인증코드 : " + code);

				if(Number(inputCode) === code){
					$("#emailAuthWarn").html('인증번호가 일치합니다.');
					$("#emailAuthWarn").css('color', 'green');
					$('#emailAuth').attr('disabled', true);
					$('#email').attr('readonly', true);
					$("#Join").attr("disabled", false);
				}else{
					$("#emailAuthWarn").html('인증번호가 불일치 합니다. 다시 확인해주세요!');
					$("#emailAuthWarn").css('color', 'red');
					$("#Join").attr("disabled", true);
				}
			});
		});

		function execDaumPostcode() {

			new daum.Postcode({
				oncomplete: function(data) {

					// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

					// 각 주소의 노출 규칙에 따라 주소를 조합한다.
					// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
					var fullAddr = ''; // 최종 주소 변수
					var extraAddr = ''; // 조합형 주소 변수

					// 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
					if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
						fullAddr = data.roadAddress;

					} else { // 사용자가 지번 주소를 선택했을 경우(J)
						fullAddr = data.jibunAddress;
					}

					// 사용자가 선택한 주소가 도로명 타입일때 조합한다.
					if(data.userSelectedType === 'R'){
						//법정동명이 있을 경우 추가한다.
						if(data.bname !== ''){
							extraAddr += data.bname;
						}
						// 건물명이 있을 경우 추가한다.
						if(data.buildingName !== ''){
							extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
						}
						// 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
						fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
					}

					// 우편번호와 주소 정보를 해당 필드에 넣는다.
					document.getElementById('postcode').value = data.zonecode; //5자리 새우편번호 사용
					document.getElementById('address').value = fullAddr;

					// 커서를 상세주소 필드로 이동한다.
					document.getElementById('address_detail').focus();
				},

				theme: {
					bgColor: "#ECECEC", //바탕 배경색
					searchBgColor: "#0B65C8", //검색창 배경색
					contentBgColor: "#FFFFFF", //본문 배경색(검색결과,결l과없음,첫화면,검색서제스트)
					pageBgColor: "#FAFAFA", //페이지 배경색
					textColor: "#333333", //기본 글자색
					queryTextColor: "#FFFFFF", //검색창 글자색
					postcodeTextColor: "#FA4256", //우편번호 글자색
					emphTextColor: "#008BD3", //강조 글자색
					outlineColor: "#E0E0E0" //테두리
				}

			}).open();
		}

	</script>

</head>

<body>

<!-- ToolBar -->
<div class="navbar navbar-default">
	<div class="container">
		<a class="navbar-brand" href="/index.jsp">Model2 MVC Shop</a>
	</div>
</div>
<%--<input type="text" class="form-control" placeholder="Recipient's username" aria-label="Recipient's username" aria-describedby="button-addon2">--%>
<%--<button class="btn btn-primary" type="button" id="button-addon2">Button</button>--%>
<%--</div>--%>
<!-- 화면 구성 -->
<div class="container">
	<h1 class="bg-primary text-center" style="color: whitesmoke">회원 가입</h1>

	<!-- Form -->
	<form class="form-horizontal">

	<div class="form-group">
		<label for="userId" class="col-sm-offset-1 col-sm-3 control-label">아이디</label>
		<div class="col-sm-4">
			<div class="input-group">
				<input class="form-control" id="userId" name = "userId" type="text" placeholder="중복 확인하세요" aria-describedby="btn-info" readonly>
				<button class="btn btn-primary" type="button" id="btn-info">중복 확인</button>
<%--				<input type="text" class="form-control" id="userId" name="userId" placeholder="중복 확인하세요" readonly>--%>
<%--				<span class="input-group-btn">--%>
<%--                    <button type="button" class="btn btn-info">중복 확인</button>--%>
<%--                </span>--%>
			</div>
			<span class="help-block">
                <strong class="text-danger">입력 전 중복 확인하세요.</strong>
            </span>
		</div>
	</div>

	<div class="form-group">
		<label for="password" class="col-sm-offset-1 col-sm-3 control-label">비밀번호</label>
		<div class="col-sm-4">
			<input type="password" class="form-control" id="password" name="password" placeholder="비밀번호">
		</div>
	</div>

	<div class="form-group">
		<label for="password2" class="col-sm-offset-1 col-sm-3 control-label">비밀번호 확인</label>
		<div class="col-sm-4">
			<input type="password" class="form-control" id="password2" name="password2" placeholder="비밀번호 확인">
		</div>
	</div>

	<div class="form-group">
		<label for="userName" class="col-sm-offset-1 col-sm-3 control-label">이름</label>
		<div class="col-sm-4">
			<input type="text" class="form-control" id="userName" name="userName" placeholder="회원 이름">
		</div>
	</div>

	<div class="form-group">
		<label for="ssn" class="col-sm-offset-1 col-sm-3 control-label">주민번호</label>
		<div class="col-sm-4">
			<input type="text" class="form-control" id="ssn" name="ssn" placeholder="주민번호">
			<span id="helpBlock" class="help-block">
                <strong class="text-danger">"- 제외 13자리 입력하세요</strong>
            </span>
		</div>
	</div>

	<div class="form-group">
		<label for="postcode" class="col-sm-offset-1 col-sm-3 control-label">주소</label>
		<div class = "row">
			<div class="col-sm-2">
				<input type="text" class="form-control" id="postcode" name="addr" placeholder="우편번호" readonly>
			</div>
			<div class ="col-sm-5">
				<input type="text" class="form-control" id="address" name = "addr" placeholder="주소" readonly>
			</div>
			<div class = "col-sm-2">
				<input type="button" class="form-control" onclick="execDaumPostcode()" value="우편번호 찾기" readonly="readonly" ><br>
			</div>
			<div class = "col-sm-5">
				<input type="text" class="form-control" id="address_detail" name = "addr" placeholder="상세주소">
			</div>
		</div>
	</div>

		<div class="form-group">
			<label for="phone1" class="col-sm-offset-1 col-sm-3 control-label">휴대전화번호</label>
			<div class ="row">
			<div class="col-sm-2">
				<select class="form-control" name="phone1" id="phone1">
					<option value="010" >010</option>
					<option value="011" >011</option>
					<option value="016" >016</option>
					<option value="018" >018</option>
					<option value="019" >019</option>
				</select>
			</div>
			<div class="col-sm-2">
				<input type="text" class="form-control" id="phone2" name="phone2" placeholder="번호">
			</div>
			<div class="col-sm-2">
				<input type="text" class="form-control" id="phone3" name="phone3" placeholder="번호">
				<input type="button" id="memberPhoneCheck" class="btn memberPhoneBtn active" value="인증번호 전송">
			</div>
				<input type="text" name="memberPhoneCertify" class="phoneNum">
				<input type="button" id="certifyCheck" class="btn memberPhoneBtn" value="인증하기">
			</div>
			<input type="hidden" name="phone"  />
		</div>

	<div class="form-group">
		<label for="email" class="col-sm-offset-1 col-sm-3 control-label">이메일</label>
		<div class="col-sm-4">
			<input type="text" class="form-control" id="email" name="email" placeholder="이메일">
			<button type="button" class="btn btn-primary" id="emailAuth">인증하기</button>
			<input type="text" class="form-control" id="authCode" name="authCode" placeholder="인증 코드 6자리를 입력해주세요.">
			<span id="emailAuthWarn"></span>
		</div>
	</div>

	<div class="form-group">
		<div class="col-sm-offset-4 col-sm-4 d-flex justify-content-end">
			<button type="button" class="btn btn-primary" id="Join">가 &nbsp;입</button>
			<a class="btn btn-primary btn" href="#" role="button">취&nbsp;소</a>
		</div>
	</div>
	</form>
</div>

</body>

</html>

