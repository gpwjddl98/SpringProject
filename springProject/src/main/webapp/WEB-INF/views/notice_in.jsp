<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true" pageEncoding="utf-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<% pageContext.setAttribute("replaceChar", "\n"); %>
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
<!-- 제이쿼리 cdn -->
<script src="https://code.jquery.com/jquery-3.6.0.js"
	integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
	crossorigin="anonymous">
	
</script>
<!-- alert 커스텀 -->
<script src="resources/assets/js/wow-alert.js"></script>
<link rel="stylesheet" href="resources/assets/css/wow-alert.css">
<script src="https://kit.fontawesome.com/d9e2783f4c.js"
	crossorigin="anonymous"></script>

<style>
* {
	margin: 0;
	padding: 0;
}

h1 {
	margin: 60px 50px 0px 80px;
	color: #252c35;
}

input.modi {
	background-color: #00AAFF;
	color: #fff;
	border: 1px solid #fff;
	width: 130px;
	height: 50px;
	margin: auto;
	display: block;
}

table {
	margin: 10px 5% 3% 5%;
	width: 90%;
}

tr {
	border-top: 1px solid #fff;
	border-bottom: 1px solid #fff;
}

tr:nth-child(1) {
	border-top: 0px;
}

th {
	text-align: center;
	background-color: #00AAFF;
	color: #fff;
	height: 50px;
	width:100px;
}

td {
	background-color: #dbdbdb;
	padding: 10px;
}

textarea:focus {    outline:none;
	
}

li.fo {
	list-style: none;
	margin: 3% 5% 0px 5%;
	height: 170px;
}

.wr {
	font-size: 20px;
	display: inline;
	padding-right: 10px;
}

.re {
	display: inline;
}

.co {
	width: 100%;
	height: 100px;
	font-size: 25px;
	background-color: #fff;
	margin-top: 10px;
}

.reply_del {
	position: relative;
	left: 1030px;
	top: -160px;
	background-color: #00AAFF;
	color: #fff;
	border: 0;
	padding: 10px;
}

	div.reply{
   		margin: 0px 5%;
   	}
   	.reply label{
   		margin-right: 10px;
   		margin-left: 10px;
   	}
   	input.reply{
   		position: relative;
  		left: 1030px;
  		top: -170px;
  		background-color: #00AAFF;
  		color:#fff;
  		border: 0;
  		padding: 10px;
   	}
   	
   	#goList {
   		margin:auto;
   	}
</style>

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
			<div class="container-fluid">
				<div class="navbar-btn">
					<button type="button" class="btn-toggle-fullwidth">
						<i class="lnr lnr-arrow-left-circle"></i>
					</button>
				</div>
				<div class="navbar-form navbar-left"
					style="position: absolute; margin: 0 0 0 300px;">
					<img src="resources/assets/img/banners.png" style="width: 90%;">
				</div>
				\
            </form> -->
				<div class="navbar-btn navbar-btn-right" style="margin-right: 20px;">
					<img src="resources/assets/img/parkingMap.png" alt="map Logo">
				</div>
			</div>
		</nav>
		<!-- END NAVBAR -->
		<!-- LEFT SIDEBAR -->
		<div id="sidebar-nav" class="sidebar">
			<div class="sidebar-scroll">
				<ul class="nav">
					<c:if test="${empty sessionScope.login}">
					<div style="text-align: center; font-size: 30px;">
					<li><img src="resources/assets/img/mainIcon.png"
							class="img-circle" alt="Avatar"
							style="width: 90%; margin-top: 30px;"><br><span style="font-size:15pt;">강남 주차장 알리미</span></li>
					</div>
					<li><a href="parking" class=""><i
							class="lnr lnr-home"></i> <span>메인화면</span></a></li>
					<li><a href="notice" class="active"><i
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
						</div>
					</li>						
					<li><a href='userSignUp' class=""><i
							class="fa-solid fa-car-on"></i> <span>회원가입</span></a></li>
					<li><a href="userLogin" class=""><i
							class="fa-solid fa-car"></i> <span>로그인</span></a></li>
					<li><a href="loginNeedAlert" class=""><i class="fa-solid fa-car-rear"></i> <span>회원정보
								변경</span></a></li>
					<li><a href="loginNeedAlert" class=""><i class="fa-solid fa-car-burst"></i> <span>회원
								탈퇴</span></a></li>
					</c:if>		
					
					<c:if test="${not empty sessionScope.login}">					
					<div style="text-align:center; font-size:30px;">
							<c:if test="${login eq 'naver'}">
								<li><img src="${userList[0].userPhotoName}" class="img-circle" alt="Avatar" style="width : 200px; height:200px; margin-top : 30px; object-fit:cover;"><br><span>${userList[0].userNick}</span></li>
							</c:if>
							<c:if test="${login eq 'common'}">
								<li><img src="${pageContext.request.contextPath}/resources/upload/${userList[0].userPhotoName}" class="img-circle" alt="Avatar" style="width : 200px; height:200px; margin-top : 30px; object-fit:cover;"><br><span>${userList[0].userNick}</span></li>
							</c:if>							
						</div>						
						<li><a href="parking" class=""><i class="lnr lnr-home"></i> <span>메인화면</span></a></li>
						<li><a href="notifications.html" class="active"><i class="lnr lnr-alarm"></i> <span>공지사항</span></a></li>
						<li><a href="favorites" class=""><i class="fa-solid fa-square-parking"></i> <span>즐겨찾는 주차장</span></a></li>
						<li>
							<a href="#subPages" data-toggle="collapse" class="collapsed"><i class="fa-solid fa-chalkboard-user"></i> <span>커뮤니티</span> <i class="icon-submenu lnr lnr-chevron-left"></i></a>
							<div id="subPages" class="collapse ">
								<ul class="nav">
									<li><a href="list" class="">후기 게시판</a></li>
									<li><a href="b_list" class="">자유 게시판</a></li>
								</ul>
							</div>
						</li>						
						<li><a href="logout" class=""><i class="fa-solid fa-car"></i> <span>로그아웃</span></a></li>
						<li><a href="userInfo" class=""><i class="fa-solid fa-car-rear"></i> <span>회원정보 조회</span></a></li>
						<li><a href="userDelete" class=""><i class="fa-solid fa-car-burst"></i> <span>회원 탈퇴</span></a></li>
						<li><a href="parking" class=""><i class="fa-solid fa-car-side"></i> <span>임시자리</span></a></li>
						<li><a href="parking" class=""><i class="fa-solid fa-car-side"></i> <span></span></a></li>
						<li><a href="parking" class=""><i class="fa-solid fa-car-side"></i> <span></span></a></li>
					</c:if>	
				</ul>
				
			</div>
		</div>
		<!-- END LEFT SIDEBAR -->
		<!-- MAIN -->
		<!-- 지도 표시화면 -->
		<div class="main">
			<h1>공지사항</h1><br>
			<form name="modi">
				<input type="hidden" name="idx" value="${vo.idx}"> 
				
			</form>
			<table>
				<tr colspan="2">
					<th>제목</th>
					<td>${vo.title}</td>
					<th>조회수</th>
					<td colspan="2"><center>${vo.viewcount }</center></td>
				</tr>
				<tr colspan="2" style="width:100%;">
					<th>작성일</th>
					<td>${vo.regdate}</td>
					<td></td>
					<td></td>
				</tr>
				<tr colspan="4">
					<th>내용</th>
					<td colspan="3" height="400px;">${vo.content}</td>
				</tr>
			</table>
			
			<div class="goList">
			<input class="modi" value="목록으로" type="button"
					onclick="location.href='notice'">
			</div>
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
		
	</script>
</body>
</html>