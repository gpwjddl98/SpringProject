<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
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
						<c:if test="${login eq 'naver'}">
							<li><img src="${list[0].userPhotoName}" class="img-circle"
								alt="Avatar"
								style="width: 200px; height: 200px; margin-top: 30px; object-fit: cover;"><br>
							<span>${list[0].userNick}</span></li>
						</c:if>
						<c:if test="${login eq 'common'}">
							<li><img
								src="${pageContext.request.contextPath}/resources/upload/${list[0].userPhotoName}"
								class="img-circle" alt="Avatar"
								style="width: 200px; height: 200px; margin-top: 30px; object-fit: cover;"><br>
							<span>${list[0].userNick}</span></li>
						</c:if>
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
					<li><a href="logout" class=""><i
							class="fa-solid fa-car"></i> <span>로그아웃</span></a></li>
					<li><a href="userInfo" class="active"><i
							class="fa-solid fa-car-rear"></i> <span>회원정보 조회</span></a></li>
					<li><a href="userDelete" class=""><i
							class="fa-solid fa-car-burst"></i> <span>회원 탈퇴</span></a></li>
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
					<h1>회원 정보 조회</h1>

					<c:if test="${login eq 'naver'}">
						<h2>네이버 로그인 회원입니다.</h2>
					</c:if>

					<div class="userInfo">
						<h4>아이디</h4>
						<input type="text" name="userId" value="${list[0].userId}"
							readonly>
					</div>

					<div class="userInfo">
						<h4>비밀번호</h4>
						<input type="text" name="userPwd" value="${list[0].userPwd}"
							readonly>
					</div>

					<div class="userInfo">
						<h4>이름</h4>
						<input type="text" name="userName" value="${list[0].userName}"
							readonly>
					</div>

					<div class="userInfo_number">
						<h4>전화번호</h4>
						<input type="text" name="userPhone1" size="4"
							value="${list[0].userPhone1}" readonly> <input
							type="text" name="userPhone2" size="4"
							value="${list[0].userPhone2}" readonly> <input
							type="text" name="userPhone3" size="4"
							value="${list[0].userPhone3}" readonly>
					</div>

					<div class="userInfo">
						<h4>닉네임</h4>
						<input type="text" name="userNick" value="${list[0].userNick}"
							readonly>
					</div>
					<div class="userInfo">
						<h4>이메일</h4>
						<input type="text" name="userEmail" value="${list[0].userEmail}"
							readonly>
					</div>
					<div class="userInfo_photo">
						<h4>프로필 사진</h4>
						<div id="userImg" align="center">
							<div class="image-box">
								<c:if test="${sessionScope.login eq 'naver'}">
									<img class="image-thumbnail" src="${list[0].userPhotoName}"
										style="width: 300px; height: 300px; object-fit: scale-down;">
								</c:if>
								<c:if test="${sessionScope.login eq 'common'}">
									<img class="image-thumbnail"
										src="${pageContext.request.contextPath}/resources/upload/${list[0].userPhotoName}"
										style="width: 300px; height: 300px; object-fit: scale-down;">
								</c:if>
							</div>
						</div>
					</div>

					<c:if test="${sessionScope.login eq 'common'}">
						<div class="submit">
							<input type="button" value="회원 정보 수정하기"
								onclick="location.href='userUpdate'" style="float: left;">
							<input type="button" value="취소" onclick="location.href='/sample'"
								style="float: right;">
						</div>
					</c:if>


				</div>
			</div>
			<!-- END MAIN CONTENT -->

			<!-- END MAIN -->
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

.userInfo {
	margin-top: 20px;
	width: 80%;
}

.userInfo_number {
	margin-top: 20px;
	width: 80%;
}

.userInfo_photo {
	margin-top: 20px;
	width: 80%;
}

.userInfo input {
	background-color: #e2e2e2;
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
	background-color: #e2e2e2;
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
	width: 45%;
	height: 50px;
	border: 0;
	outline: none;
	border-radius: 40px;
	background: rgb(100, 100, 100);
	color: white;
	font-size: 1.2em;
	letter-spacing: 2px;
}
</style>


		<footer>
			<div class="container-fluid">
				<p class="copyright">
					Shared by <i class="fa fa-love"></i><a
						href="https://bootstrapthemes.co">BootstrapThemes</a>
				</p>
			</div>
		</footer>


		<!-- END WRAPPER -->
		<style>
.image-box {
	border: 3px solid;
	width: 300px;
	height: 300px;
	overflow: hidden;
	margin: 10 auto;
}

.img-thumbnail {
	width: 100%;
	height: 100%;
	object-fit: cover;
}
</style>


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
			console.log("${sessionScope.login}");
		</script>
</body>

</html>