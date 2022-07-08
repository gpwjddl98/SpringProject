<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" pageEncoding="utf-8"%>
<html>
<head>
	<title> 강남 주차장 알리미 </title>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
	<!-- VENDOR CSS -->
	<link rel="stylesheet" href="resources/assets/vendor/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="resources/assets/vendor/font-awesome/css/font-awesome.min.css">
	<link rel="stylesheet" href="resources/assets/vendor/linearicons/style.css">
	<link rel="stylesheet" href="resources/assets/vendor/chartist/css/chartist-custom.css">
	<!-- MAIN CSS -->
	<link rel="stylesheet" href="resources/assets/css/main.css">
	<!-- FOR DEMO PURPOSES ONLY. You should remove this in your project -->
	<link rel="stylesheet" href="resources/assets/css/demo.css">
	<!-- GOOGLE FONTS -->
	<link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700" rel="stylesheet">
	<!-- ICONS -->
	<link rel="apple-touch-icon" sizes="76x76" href="resources/assets/img/apple-icon.png">
	<link rel="icon" type="image/png" sizes="96x96" href="resources/assets/img/favicon.png">
	<script src="https://kit.fontawesome.com/d9e2783f4c.js" crossorigin="anonymous"></script>
	<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js"
            charset="utf-8"></script>
    <script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
</head>

<body>
	
		<div class="main" style="padding:0;">
			<!-- MAIN CONTENT -->
			<div class="main-content">
				<div class="container-fluid" style="text-align:center;">
					<!-- OVERVIEW -->
					<div class="panel panel-headline" style="margin:0 auto;">
						<div class="panel-heading" style="padding:10px;">
							<h3 class="panel-title">네이버로 로그인하기 성공!</h3>
								<div class="imgDiv" style="text-align:center;">
									<img src="resources/assets/img/mainIcon.png">								
								</div>
							
						</div>
							<div class="submit">
								<input type="button" value="메인으로 이동" onclick="go()" style="float:left;">
								<input type="button" value="창닫기" onclick="window.close();" style="float:right;">
							</div>

					</div>
					<!-- END OVERVIEW -->					
				</div>
			</div>
			<!-- END MAIN CONTENT -->
		</div>
		
	<style>
	* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	font-family: "Noto Sans KR", sans-serif;
	}
	.submit {
	margin-left:70px;
	width: 80%;
	align:center;
	}

	.submit input {
	margin-top:20px;
	width: 50%;
	height: 50px;
	border: 0;
	outline: none;
	border-radius: 10px;
	/* background: linear-gradient(to left, rgb(68, 68, 68), rgb(191, 191, 191)); */
	background: rgb(68, 68, 68);
	color: white;
	font-size: 1.2em;
	letter-spacing: 2px;
	}
	
	
	</style>
		
	<!-- Javascript -->
	<script src="resources/assets/vendor/jquery/jquery.min.js"></script>
	<script src="resources/assets/vendor/bootstrap/js/bootstrap.min.js"></script>
	<script src="resources/assets/vendor/jquery-slimscroll/jquery.slimscroll.min.js"></script>
	<script src="resources/assets/vendor/jquery.easy-pie-chart/jquery.easypiechart.min.js"></script>
	<script src="resources/assets/vendor/chartist/js/chartist.min.js"></script>
	<script src="resources/assets/scripts/klorofil-common.js"></script>
	<script type="text/javascript">
        var naver_id_login = new naver_id_login("TXQEEu2dkgi7CDCThSKM", "http://localhost:9090/sample/loginNaverOk"); // 역시 마찬가지로 'localhost'가 포함된 CallBack URL
        
        // 접근 토큰 값 출력
        //console.log(naver_id_login.oauthParams.access_token);
        
        // 네이버 사용자 프로필 조회
        naver_id_login.get_naver_userprofile("naverSignInCallback()");
        
        // 네이버 사용자 프로필 조회 이후 프로필 정보를 처리할 callback function
        function naverSignInCallback() {
        	console.log(naver_id_login.getProfileData('nickname'));
        	console.log(naver_id_login.getProfileData('profile_image'));
        }
        
        function go(){
        	opener.parent.getInfo(naver_id_login.getProfileData('nickname'),naver_id_login.getProfileData('profile_image'));
        	window.close();
        }
    </script>
</body>

</html>