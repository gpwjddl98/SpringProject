<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" href="resources/assets/css/wow-alert.css">
<script src="https://code.jquery.com/jquery-3.6.0.js" 
integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="	crossorigin="anonymous">	
</script>
<!-- alert 커스텀 -->
<script src="resources/assets/js/wow-alert.js"></script>

</head>
<body>
<script type="text/javascript">
	var message="${msg}";
	var returnUrl = '${url}';	
	alert(message,{		
		label:"확인",
		success:function(){
			document.location.href=returnUrl;
		}
	});	
</script>


</body>
</html>