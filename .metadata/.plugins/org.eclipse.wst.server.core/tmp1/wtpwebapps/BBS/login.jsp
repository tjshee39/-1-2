<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.min.css">  <!-- bootstrap: 디자인 프레임워크(반응형) -->
<link rel="stylesheet" href="css/custom.css">
<title>JSP BBS</title>
</head>
<body>
	<jsp:include page="navbar_header.jsp" />
	
	<!-- 로그인 양식 -->
	<div class="container">
		<div class="col-lg-4"></div>
		<div class="col-lg-4">
			<div class="jumbotron" style="padding-top:20px;">
				<form method="post" action="loginAction.jsp">  <!-- post: 정보를 숨기면서 보내는 메소드 / loginAction.jsp로 로그인 정보 보냄 -->
					<img src="images/titleLogo.png" style="display:block; margin:auto; width: 100px; height: 100px;">
					<h3 id="login" style="text-align: center; font-family:'Source Serif Pro', serif;
					font-weight:700">LOGIN</h3>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="아이디" name="userID" maxlength="20">
					</div>
					<div class="form-group">
						<input type="password" class="form-control" placeholder="비밀번호" name="userPassword" maxlength="20">
					</div>
					<input type="submit" class="btn btn-primary form-control" value="로그인"
					style="background-color: #b7b7b7; border:#b7b7b7">
				</form>
			</div>			
		</div>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>