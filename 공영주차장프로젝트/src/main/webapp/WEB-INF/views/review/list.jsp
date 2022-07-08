<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true" pageEncoding="utf-8"%>
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
<link rel="stylesheet" href="resources/assets/css/list.css">
<!-- LIST CSS -->
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

<!-- 네이버 지도 api 연동(키) -->
<script type="text/javascript"
	src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=xt6b9q2l1i">
	
</script>

<!-- 제이쿼리 cdn -->
<script src="https://code.jquery.com/jquery-3.6.0.js"
	integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
	crossorigin="anonymous">
	
</script>
<script src="https://kit.fontawesome.com/d9e2783f4c.js"
	crossorigin="anonymous"></script>
<!-- 검색 ajax -->

<script>
	function getSearchList() {
		$.ajax({
					type : 'get',
					url : "getSearchList",
					data : $("form[name=search-form]").serialize(),
					success : function(result) {
						console.log(result.length);
						if (result.length >= 1) {
							//테이블 초기화
							$('#boardtable').empty();
							$('#boardtable')
									.prepend(
											"<tr><th>번호</th><th>제목</th><th>작성자</th><th>작성일</th><th>조회수</th></tr>");
							$(".page").hide();

							result
									.forEach(function(item) {

										$('#boardtable')
												.append(
														"<tr>"
																+ "<td style='background-color :#dbdbdb;text-align: center;height: 50px;border: 1px solid #fff;color: #000;'>"
																+ item.idx
																+ "</td>"
																+ "<td style='background-color :#dbdbdb;text-align: center;height: 50px;border: 1px solid #fff;color: #000;'><a href='view.do?idx="
																+ item.idx
																+ "'>"
																+ item.title
																+ "</td>"
																+ "<td style='background-color :#dbdbdb;text-align: center;height: 50px;border: 1px solid #fff;color: #000;'>"
																+ item.userNick
																+ "</td>"
																+ "<td style='background-color :#dbdbdb;text-align: center;height: 50px;border: 1px solid #fff;color: #000;'>"
																+ item.regdate
																+ "</td>"
																+ "<td style='background-color :#dbdbdb;text-align: center;height: 50px;border: 1px solid #fff;color: #000;'>"
																+ item.viewcount
																+ "</td>"
																+ "</tr>");
									})
						}
					}
				})
	}
</script>
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
						<li><a href="notice" class=""><i class="lnr lnr-alarm"></i> <span>공지사항</span></a></li>
						<li><a href="favorites" class=""><i class="fa-solid fa-square-parking"></i> <span>즐겨찾는 주차장</span></a></li>
						<li>
							<a href="#subPages" data-toggle="collapse" class="collapsed"><i class="fa-solid fa-chalkboard-user"></i> <span>커뮤니티</span> <i class="icon-submenu lnr lnr-chevron-left"></i></a>
							<div id="subPages" class="collapse ">
								<ul class="nav">
									<li><a href="list" class="active">후기 게시판</a></li>
									<li><a href="b_list" class="">자유 게시판</a></li>
								</ul>
							</div>
						</li>						
						<li><a href="logout" class=""><i class="fa-solid fa-car"></i> <span>로그아웃</span></a></li>
						<li><a href="userInfo" class=""><i class="fa-solid fa-car-rear"></i> <span>회원정보 조회</span></a></li>
						<li><a href="userDelete" class=""><i class="fa-solid fa-car-burst"></i> <span>회원 탈퇴</span></a></li>
					</c:if>	
				</ul>
				
			</div>
		</div>
		<!-- END LEFT SIDEBAR -->
		<!-- MAIN -->
		<!-- 지도 표시화면 -->
		<div class="main">
			<h1>후기게시판</h1>
			<input class="new" value="새글작성" type="button"
				onclick="location.href='insert_form.do'">
			<table id="boardtable">

				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th>작성일</th>
					<th>별점</th>
					<th>조회수</th>
				</tr>

				<c:forEach var="v" items="${list}" varStatus="num">
					<tr class="tbody">
						<td>${v.idx}</td>
						<td><a href="view.do?idx=${v.idx}&page=${param.page}">${v.title}</a></td>
						<td>${v.userNick}</td>
						<td>${v.regdate}</td>
						<td>${v.starview}</td>
						<td>${v.viewcount}</td>
					</tr>
				</c:forEach>


			</table>
			<p class="page">${pageMenu}</p>
			<!-- 검색 -->
			<div class="search">
				<form name="search-form" autocomplete="off">
					<select name="type">
						<option selected value="">검색 내용 선택</option>
						<option value="title">제목</option>
					</select> <input type="text" name="keyword" value=""> <input
						type="button" onclick="getSearchList()" value="검색">
				</form>
			</div>
			<!-- 검색 끝 -->
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