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
<!-- AJAX -->
<script src="resources/assets/js/httpRequest.js"></script>



<script>
	/* 삭제스크립트 */
	function del(f) {
		var orpwd = f.orpwd.value.trim(); //받아온값
		var pwd = prompt(" ")
		if (pwd == null) {
			;
		} else {
			if (pwd != orpwd) {
				alert("비밀번호가 일지하지 않습니다.", {

					label : "확인",
				});
				return;
			} else if (pwd == orpwd) {
				if (!confirm("삭제하시겠습니까?")) {
					return;
				} else {
					;
				}
			}

			var url = "b_delet.do";
			var param = "idx=" + f.idx.value;

			sendRequest(url, param, resultFn, "post");
		}

	}

	function resultFn() {
		if (xhr.readyState == 4 && xhr.status == 200) {

			var data = xhr.responseText;
			var json = (new Function('return' + data))();

			if (json[0].res == 'no') {
				alert("비밀번호가 틀렸습니다.", {

					label : "확인",
				});
				return;
			}
			alert("게시글이 삭제되었습니다.", {

				label : "확인",
			});
			location.href = "b_list.do";
		}
	}

	/* 수정스크립트 */
	function modify(f) {

		var orpwd = f.orpwd.value.trim();
		var pwd = prompt(" ")
		if (pwd == null) {
			;
		} else {

			if (pwd == "") {
				alert("비밀번호를 입력해주세요", {

					label : "확인",
				});
				return;
			} else if (pwd == orpwd) {
				if (!confirm("수정하시겠습니까?")) {
					return;
				} else {
					f.action = "b_modi_form.do";

					f.submit();
				}
			}else if( pwd != orpwd){
				alert("비밀번호가 일지하지 않습니다.", {

					label : "확인",
				});
			}

			
		}
	}
	/* 댓글작성스크립트 */

	function send(f) {
		   var f = document.f;
		   var writer = f.writer.value.trim();
		   var content = f.content.value.trim();
		   var pwd = f.pwd.value.trim();
		   if(writer == ""){
			   alert("글쓴이를 작성해주세요");
			   return;
		   }
		   if(content == ""){
			   alert("내용을 작성해주세요");
			   return;
		   }  
		   if(pwd == ""){
			   alert("비밀버호를 작성해주세요");
			   return;
		   }
		
		f.action = "b_reply_insert";
		f.submit();
	}

	/* 댓글 삭제 */

	function reply_del(f) {

		var repwd = f.repwd.value.trim();
		var rpwd = prompt(" ")
		if(rpwd == null){
			;
		}else{
		if (rpwd !== repwd) {
			alert("비밀번호가 일치하지 않습니다.", {

				label : "확인",
			});
			return;
		} else if(rpwd == repwd ){
			 if(!confirm("삭제하시겠습니까?")) {
				 return;
			 }else{
				 ;
			 }
		}
			
		

		var url = "b_reply_delet.do";
		var param = "reidx=" + f.reidx.value;

		sendRequest(url, param, resultreply, "post");
		}
	}

	function resultreply() {
		if (xhr.readyState == 4 && xhr.status == 200) {

			var data = xhr.responseText;
			var json = (new Function('return' + data))();

			if (json[0].res == 'no') {
				alert("비밀번호가 틀렸습니다.", {

					label : "확인",
				});
				return;
			} alert("게시글이 삭제되었습니다.", {

				label : "확인",
			});

				location.reload();
			}
		}

	
</script>

<style>
* {
	margin: 0;
	padding: 0;
}

h1 {
	margin: 60px 50px 0px 50px;
	color: #252c35;
}

input.modi {
	background-color: #00AAFF;
	color: #fff;
	border: 1px solid #fff;
	width: 130px;
	height: 50px;
	position: relative;
	left: 70%;
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
	box-sizing: border-box;
}

td {
	wdith: 300px;
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
	left: 90%;
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
  		left: 90%;
  		top: -170px;
  		background-color: #00AAFF;
  		color:#fff;
  		border: 0;
  		padding: 10px;
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
									<li><a href="list" class="">후기 게시판</a></li>
									<li><a href="b_list" class="active">자유 게시판</a></li>
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
			<h1>자세히보기</h1>
			<form name="modi">
				<input type="hidden" name="idx" value="${bo.idx}"> <input
					type="hidden" name="orpwd" value="${bo.pwd }"> <input
					class="modi" value="수정하기" type="button" onclick="modify(this.form)">
				<input class="modi" value="삭제하기" type="button"
					onclick="del(this.form)"> <input class="modi" value="목록으로"
					type="button"
					onclick="location.href='b_list.do?page=${param.page}'">
			</form>
			<table>
				<tr>
					<th>제목</th>
					<td>${bo.title}</td>
					<th>작성일</th>
					<td>${bo.regdate}</td>
				</tr>
				<tr>
					<th>작성자</th>
					<td>${bo.id}</td>
					<th>조회수</th>
					<td>${bo.viewcount }</td>
				</tr>
				<tr>
					<th>내용</th>
					<td colspan="3" height="200px;">${bo.content}</td>
				</tr>
			</table>

			<!-- 댓글시작 -->

			<c:forEach var="re" items="${reply}">
				<form>
					<li class="fo">
						<p class="wr">${re.writer}</p>  <p class="re">${re.regdate}</p>
						<p class="co">${re.content }</p> 
						<input type="hidden" name="reidx" value="${re.reidx}"> 
						<input type="hidden" name="idx" value="${re.idx }"> 
						<input type="hidden" name="repwd" value="${re.pwd }"> 
						<input class="reply_del" type="button"value="삭제하기" onclick="reply_del(this.form)">

					</li>
				</form>
			</c:forEach>

			<form name="f">
				<div class="reply">
					<p>
						<label>작성자</label> <input type="text" name="writer"> 
						<label>비밀번호</label> <input type="password" name="pwd">
					</p>
					<p>
						<textarea rows="5" cols="50" name="content" style="resize: none; width:100%;"></textarea>
					</p>
					<p>
						<input type="hidden" name="idx" value="${bo.idx}">
						<input class="reply" type="button" value="댓글작성" onclick="send(this.form)">
					</p>
				</div>
			</form>
			<!-- 댓글 끝 -->
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