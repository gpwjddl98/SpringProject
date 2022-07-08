<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

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

<!-- 내가 쓰는 폼 링크 -->

<script src="https://kit.fontawesome.com/d9e2783f4c.js"
	crossorigin="anonymous"></script>

<!-- 네이버 로그인 script -->
<script type="text/javascript"
	src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js"
	charset="utf-8"></script>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-1.11.3.min.js"></script>

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
				<nav>
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
									<li><a href="boardAlert" class="">후기 게시판</a></li>
									<li><a href="boardAlert" class="">자유 게시판</a></li>
								</ul>
							</div></li>
						<li><a href='userSignUp' class=""><i
								class="fa-solid fa-car-on"></i> <span>회원가입</span></a></li>
						<li><a href="userLogin" class="active"><i
								class="fa-solid fa-car"></i> <span>로그인</span></a></li>
						<li><a href="loginNeedAlert" class=""><i class="fa-solid fa-car-rear"></i> <span>회원정보
									조회</span></a></li>
						<li><a href="loginNeedAlert" class=""><i class="fa-solid fa-car-burst"></i> <span>회원
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

				<div align="center" style="margin-top: 50px;">
					<h3>강남 주차장 알리미 사이트에 방문해 주셔서 감사합니다.</h3>
					<div class="forgot_pw">
						<p>
							아직 강남 주차장 알리미 사이트 회원이 아니신가요? <a href="userSignUp">회원가입 하러가기</a>
						</p>
					</div>

					<form>
						<div class="login_id">
							<h4>아이디</h4>
							<input type="text" id="userId" name="userId" size="20"
								value="${userId}">
						</div>
						<div class="login_pw">
							<h4>비밀번호</h4>
							<input type="password" id="userPwd" name="userPwd" size="20"
								value="${userPwd}">
						</div>
						<div class="forgot_pw">
							<p>
								아이디와 비밀번호가 기억나지 않으신가요? <a href="userFindLogin">아이디/비밀번호 찾기</a>
							</p>
						</div>

						<div class="login_etc">
							<div class="checkbox">
								<input type="checkbox" id="rememberLogin" onClick="check(this)"
									checked> 자동으로 로그인하기
							</div>
						</div>
						<div class="submit">
							<input type="button" value="로그인" onclick="send(this.form);">
						</div>
					</form>

					<div id="naver_id_login" style="display: none;"></div>

					<div class="naverLogin">
						<input type="button" value="네이버 아이디로 로그인"
							onclick="document.getElementById('naver_id_login_anchor').click();">
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

.login {
	width: 30%;
	height: 600px;
	background: white;
	border-radius: 20px;
	display: flex;
	justify-content: center;
	align-items: center;
	flex-direction: column;
}

.login_id {
	margin-top: 20px;
	width: 80%;
}

.login_id input {
	width: 50%;
	height: 50px;
	border-radius: 30px;
	margin-top: 10px;
	padding: 0px 20px;
	border: 1px solid lightgray;
	outline: none;
}

.login_pw {
	margin-top: 20px;
	width: 80%;
}

.login_pw input {
	width: 50%;
	height: 50px;
	border-radius: 30px;
	margin-top: 10px;
	padding: 0px 20px;
	border: 1px solid lightgray;
	outline: none;
}

.login_etc {
	padding: 10px;
	width: 50%;
	font-size: 14px;
	display: flex;
	justify-content: space-between;
	align-items: center;
	font-weight: bold;
}

.forgot_pw {
	margin: 10px;
}

.submit {
	margin-top: 10px;
	width: 80%;
}

.submit input {
	width: 50%;
	height: 50px;
	border: 0;
	outline: none;
	border-radius: 40px;
	/* background: linear-gradient(to left, rgb(68, 68, 68), rgb(191, 191, 191)); */
	background: rgb(68, 68, 68);
	color: white;
	font-size: 1.2em;
	letter-spacing: 2px;
}

.naverLogin {
	margin-top: 10px;
	width: 80%;
}

.naverLogin input {
	width: 50%;
	height: 50px;
	border: 0;
	outline: none;
	border-radius: 40px;
	background: linear-gradient(to left, rgb(3, 199, 90), rgb(0, 204, 102));
	color: white;
	font-size: 1.2em;
	letter-spacing: 2px;
}
</style>



					<script type="text/javascript">
						var naver_id_login = new naver_id_login(
								"TXQEEu2dkgi7CDCThSKM",
								"http://localhost:9090/sample/loginNaverOk");
						// Client ID, CallBack URL 삽입 단 'localhost'가 포함된 CallBack URL
						var state = naver_id_login.getUniqState();

						naver_id_login.setButton("white", 3, 50);
						naver_id_login
								.setDomain("http://localhost:9090/sample/userLogin"); //  URL
						naver_id_login.setState(state);
						naver_id_login.setPopup();
						naver_id_login.init_naver_id_login();

						function getInfo(userNick, userPhotoName) {
							const form = document.createElement('form');

							form.setAttribute("method", "post");
							form.setAttribute("action", "loginNaverMain");
							document.body.appendChild(form);

							var i = document.createElement("input");
							i.setAttribute("type", "hidden");
							i.setAttribute("name", "userNick");
							i.setAttribute("value", userNick);
							form.appendChild(i);

							var j = document.createElement("input");
							j.setAttribute("type", "hidden");
							j.setAttribute("name", "userPhotoName");
							j.setAttribute("value", userPhotoName);
							form.appendChild(j);

							form.submit();

						}
					</script>

				</div>

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
		
		function check(box) {
			if (box.checked == true) {
				$("input[name='userId']").val("${userId}");
				$("input[name='userPwd']").val("${userPwd}");
			} else {
				$("input[name='userId']").val("");
				$("input[name='userPwd']").val("");
			}
		}

		function send(f) {
			//유효성 체크 집어넣기
			if(!f.userId.value){
				alert("아이디를 입력해주세요.",{
					
					label:"확인",
				});
				return;
			}
			if(!f.userPwd.value){
				alert("비밀번호를 입력해주세요.",{
					
					label:"확인",
				});
				return;
			}			
			
			f.action = "loginOk";
			f.method = "post";
			f.submit();
		}
	</script>

</body>

</html>