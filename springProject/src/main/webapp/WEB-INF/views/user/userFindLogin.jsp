<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.security.SecureRandom"%>
<%@ page import="java.math.BigInteger"%>
<!doctype html>
<html lang="ko">
<head>
<title>강남 주차장 알리미</title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
<!-- VENDOR CSS -->
<link rel="stylesheet"
	href="resources/assets/vendor/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet"
	href="resources/assets/vendor/font-awesome/css/font-awesome.min.css">
<link rel="stylesheet"
	href="resources/assets/vendor/linearicons/style.css">
<link rel="stylesheet"
	href="resources/assets/vendor/chartist/css/chartist-custom.css">
<!-- MAIN CSS -->
<link rel="stylesheet" href="resources/assets/css/main.css">
<!-- FOR DEMO PURPOSES ONLY. You should remove this in your project -->
<link rel="stylesheet" href="resources/assets/css/demo.css">
<!-- GOOGLE FONTS -->
<link
	href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700"
	rel="stylesheet">
<!-- ICONS -->
<link rel="apple-touch-icon" sizes="76x76"
	href="resources/assets/img/apple-icon.png">
<link rel="icon" type="image/png" sizes="96x96"
	href="resources/assets/img/favicon.png">

<script type="text/javascript"
	src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js"
	charset="utf-8"></script>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<script src="https://kit.fontawesome.com/d9e2783f4c.js"
	crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js"
	integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
	crossorigin="anonymous">
</script>
<!-- alert 커스텀 -->
<script src="resources/assets/js/wow-alert.js"></script>
<!-- alert 커스텀 -->
<link rel="stylesheet" href="resources/assets/css/wow-alert.css">

</head>

<body>
	<!-- WRAPPER -->
	<div id="wrapper">
		<!-- NAVBAR -->
		<nav class="navbar navbar-default navbar-fixed-top">
			<div class="brand" style="padding: 15px 40px;">
				<a href="index.html"><img
					src="resources/assets/img/parkingIcon.png" alt="Klorofil Logo"
					class="img-responsive logo"></a>

			</div>
			<div class="container-fluid" style="position: relative;">
				<div class="navbar-btn">
					<button type="button" class="btn-toggle-fullwidth">
						<i class="lnr lnr-arrow-left-circle"></i>
					</button>
				</div>

				<div class="navbar-form navbar-left"
					style="position: absolute; margin: 0 0 0 300px;">
					<img src="resources/assets/img/banners.png" style="width: 90%;">
				</div>

				<div class="navbar-btn navbar-btn-right" style="margin-right: 10px;">
					<img src="resources/assets/img/parkingMap.png" alt="map Logo">
				</div>
			</div>
		</nav>
		<!-- END NAVBAR -->
		<!-- LEFT SIDEBAR -->
		<div id="sidebar-nav" class="sidebar">
			<div class="sidebar-scroll">
				<ul class="nav">
					<div style="text-align: center; font-size: 30px;">
						<li><img src="resources/assets/img/mainIcon.png"
							class="img-circle" alt="Avatar"
							style="width: 90%; margin-top: 30px;"><br><span style="font-size:15pt;">강남 주차장 알리미</span></li>
					</div>
					<li><a href="parking" class=""><i class="lnr lnr-home"></i>
							<span>메인화면</span></a></li>
					<li><a href="notice" class=""><i
							class="lnr lnr-alarm"></i> <span>공지사항</span></a></li>
					<li><a href="favorites" class=""><i
							class="fa-solid fa-square-parking"></i> <span>즐겨찾는 주차장</span></a></li>
					<li><a href="#subPages" data-toggle="collapse"
						class="collapsed"><i class="fa-solid fa-chalkboard-user"></i>
							<span>커뮤니티</span> <i class="icon-submenu lnr lnr-chevron-left"></i></a>
						<div id="subPages" class="collapse ">
							<ul class="nav">
								<li><a href="list" class="">후기 게시판</a></li>
								<li><a href="b_list" class="">자유 게시판</a></li>
							</ul>
						</div></li>
					<li><a href='userSignUp' class=""><i
							class="fa-solid fa-car-on"></i> <span>회원가입</span></a></li>
					<li><a href="userLogin" class="active"><i
							class="fa-solid fa-car"></i> <span>로그인</span></a></li>
					<li><a href="userLogin" onclick="alert('로그인 후 이용해주세요',{label:'확인',});"
						class=""><i class="fa-solid fa-car-rear"></i> <span>회원정보
								조회</span></a></li>
					<li><a href="userLogin" onclick="alert('로그인 후 이용해주세요',{label:'확인',});"
						class=""><i class="fa-solid fa-car-burst"></i> <span>회원
								탈퇴</span></a></li>
				</ul>
				</nav>
			</div>
		</div>
		<!-- END LEFT SIDEBAR -->
		<!-- MAIN -->
		<div class="main">
			<!-- MAIN CONTENT -->
			<div class="main-content">

				<div align="center">
					<h1>아이디 / 비밀번호 찾기</h1>
					<div class="submit">
						<input type="button" class="findBtn" id="findIdBtn" value="아이디 찾기"
							onclick="showFindId();" style="float: left;"> <input
							type="button" class="findBtn" id="findPwdBtn" value="비밀번호 찾기"
							onclick="showFindPwd();" style="float: right;">
					</div>
					<div class="userInfo" id="findIdBox"
						style="display: none; margin-top: 80px;">
						<form>
							<h4>이름</h4>
							<input type="text" name="userName">
							<div class="userInfo_number">
								<h4>전화번호</h4>
								<input type="text" name="userPhone1"> <input type="text"
									name="userPhone2"> <input type="text" name="userPhone3">
							</div>
							<h4>이메일 주소</h4>
							<input type="text" name="userEmailId"><br> <span
								id="findId"></span><br> <input type="button"
								class="findBtn" name="sendFindId" value="아이디 찾기"
								onclick="sendCheckId(this.form)">
						</form>
					</div>

					<div class="userInfo" id="findPwdBox"
						style="display: none; margin-top: 60px;">
						<form>
							<h4>아이디</h4>
							<input type="text" name="userId">
							<h4>이메일 주소</h4>
							<input type="text" name="userEmailPwd"><br> <span
								id="sendPwd"></span><br> <input type="button"
								class="findBtn" value="임시 비밀번호 전송"
								onclick="sendPwdEmail(this.form)">
						</form>
					</div>

					<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	font-family: "Noto Sans KR", sans-serif;
}

a {
	text-decoration: none;
	color: black;
}

.userInfo {
	margin-top: 20px;
	width: 80%;
}

.userInfo_number {
	margin-top: 20px;
	width: 80%;
}

.userInfo input {
	width: 30%;
	height: 50px;
	border-radius: 10px;
	margin-top: 10px;
	padding: 0px 20px;
	border: 1px solid lightgray;
	outline: none;
	text-align: center;
}

.userInfo_number input {
	width: 15%;
	height: 50px;
	border-radius: 10px;
	margin-top: 10px;
	padding: 0px 20px;
	border: 1px solid lightgray;
	outline: none;
	text-align: center;
}

.submit {
	margin: 20px;
	padding: 10px;
	width: 50%;
}

.submit input {
	width: 50%;
	height: 50px;
	border: 0;
	outline: none;
	border-radius: 10px;
	background: rgb(100, 100, 100);
	color: white;
	font-size: 1.2em;
	letter-spacing: 2px;
}

.findBtn {
	width: 25%;
	height: 50px;
	border: 0;
	outline: none;
	border-radius: 40px;
	background: rgb(150, 150, 150);
	color: white;
	font-size: 1.2em;
	letter-spacing: 2px;
}
</style>

				</div>

			</div>

		</div>
		<!-- END MAIN CONTENT -->
	</div>
	<!-- END MAIN -->

	<footer>
		<div class="container-fluid">
			<p class="copyright">
				Shared by <i class="fa fa-love"></i><a
					href="https://bootstrapthemes.co">BootstrapThemes</a>
			</p>
		</div>
	</footer>
	</div>
	<!-- END WRAPPER -->
	<!-- Javascript -->
	<script src="resources/assets/vendor/jquery/jquery.min.js"></script>
	<script src="resources/assets/vendor/bootstrap/js/bootstrap.min.js"></script>
	<script
		src="resources/assets/vendor/jquery-slimscroll/jquery.slimscroll.min.js"></script>
	<script
		src="resources/assets/vendor/jquery.easy-pie-chart/jquery.easypiechart.min.js"></script>
	<script src="resources/assets/vendor/chartist/js/chartist.min.js"></script>
	<script src="resources/assets/scripts/klorofil-common.js"></script>

	<script>
		function showFindId() {
			var div = document.getElementById("findIdBox");
			if (div.style.display === 'none') {
				div.style.display = 'block';
			} else {
				div.style.display = 'none';
			}
		}
		function showFindPwd() {
			var div = document.getElementById("findPwdBox");
			if (div.style.display === 'none') {
				div.style.display = 'block';
			} else {
				div.style.display = 'none';
			}
		}
		
		
	var idCheck=false;
		function sendCheckId(f) {
			idCheck=false;
			var userName = f.userName.value;
			var userPhone1 = f.userPhone1.value;
			var userPhone2 = f.userPhone2.value;
			var userPhone3 = f.userPhone3.value;
			var userEmailId = f.userEmailId.value;
			
			//유효성 검사
			if(!f.userName.value){
				alert("회원님의 이름을 입력해주세요.",{
					
					label:"확인",
				});
				return;
			}
			
			if(!(f.userPhone1.value&&f.userPhone2.value&&f.userPhone3)){
				alert("핸드폰 번호를 입력해주세요.",{
					
					label:"확인",
				});
				return;
			}
					
			var userPhone = f.userPhone1.value+'-'+f.userPhone2.value+'-'+f.userPhone3.value;
			var phoneRegex = /^\d{3}-\d{4}-\d{4}/;
			if(phoneRegex.test(userPhone)==false){
				alert("회원님의 핸드폰 번호를 세자리-네자리-네자리 순으로 입력해주세요.",{
					
					label:"확인",
				});
				return;
			}
			
			var emailRegex = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
			
			if(!f.userEmailId.value){
				alert("가입할 때 작성하신 이메일 주소를 입력해주세요.",{
					
					label:"확인",
				});
			} else	if(emailRegex.test(userEmailId)==false){
				alert("회원님이 입력하신 이메일의 형식이 올바르지 않습니다.다시한 번 확인해 주세요.",{
					
					label:"확인",
				});
				return;
			}						
			

			$.ajax({
				url : "userFindLoginId?userName=" + userName + "&userPhone1="
						+ userPhone1 + "&userPhone2=" + userPhone2
						+ "&userPhone3=" + userPhone3 + "&userEmail="
						+ userEmailId,
				type : "post",
				dataType : "json",
				success : function(result) {
					console.log("들어옴")
					if (result.status == 'ok') {
						$("#findId").text("아이디 : " + result.userId);
						$("#findId").css("color", "blue");
						idCheck = true;
					} else {
						$("#findId").text("일치하는 아이디가 없습니다.");
						$("#findId").css("color", "red");
						idCheck=false;
					}
				},
				error : function() {
					console.log("오류");
				}
			});
		}

		function sendPwdEmail(f) {
			var userId = f.userId.value;
			var userEmailPwd = f.userEmailPwd.value;
			
			if(!f.userId.value){
				alert("회원님의 아이디를 입력해주세요.\n아이디가 기억나지 않으신다면 아이디찾기를 먼저 진행해주세요.",{
					
					label:"확인",
				});
				return;
			}
			
			var emailRegex = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
			
			if(!f.userEmailPwd.value){
				alert("가입할 때 작성하신 이메일 주소를 입력해주세요.",{
					
					label:"확인",
				});
				return;
			} else if(emailRegex.test(userEmailPwd)==false){
				alert("회원님이 입력하신 이메일의 형식이 올바르지 않습니다.\n다시한 번 확인해 주세요.",{
					
					label:"확인",
				});
				return;
			}
			
			
			
			

			$.ajax({
				url : "userSendPwdEmail?userId=" + userId + "&userEmail="
						+ userEmailPwd,
				type : "post",
				dataType : "json",
				success : function(result) {
					console.log("들어옴")
					if (result.status == 'ok') {
						$("#sendPwd").text("임시 비밀번호가 이메일로 전송되었습니다.");
						$("#sendPwd").css("color", "blue");
						idcheck = true;
					} else {
						$("#sendPwd").text("이메일을 보내지 못했습니다..");
						$("#sendPwd").css("color", "red");
					}
				},
				error : function() {
					console.log("오류");
				}
			});

		}
	</script>

</body>

</html>