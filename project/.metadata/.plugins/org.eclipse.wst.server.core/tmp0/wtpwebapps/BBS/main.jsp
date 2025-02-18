<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>   <!-- 라이브러리 불러오기 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.min.css">  <!-- bootstrap: 디자인 프레임워크(반응형) -->
<link rel="stylesheet" href="css/custom.css">
<link rel="stylesheet" href="css/main.css">
<link rel="stylesheet" href="css/main_normalize.css">
<title>JSP BBS</title>
<style type="text/css">
	a, a:hover {
		color: #000000;
		text-decoration: none;
	}
</style>
</head>
<body>
	<%   //로그인 된 사람들의 정보를 담을 수 있도록 만듦
		String userID = null;
		if (session.getAttribute("userID") != null) {  //현재 세션이 존재하는 사람이라면 ID값을 그대로 받아 관리할 수 있도록 만듦
			userID = (String) session.getAttribute("userID");
		}  //userID라는 변수에 해당ID가 담기고 그렇지 않은 사람들은 null
	%>
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<span class="icon-bar"></span>  <!-- 메뉴 -->
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="main.jsp"><img src="images/titleLogo.png" height="100%"></a>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li class="active"><a href="main.jsp">메인</a></li>  <!-- active: 현재 접속한 페이지 -->
				<li><a href="bbs.jsp">기타</a></li>
				<li><a href="bbsLife.jsp">죽음/질병</a>
				<li><a href="bbsAnimal.jsp">동물</a>
				<li><a href="bbsPlant.jsp">식물</a>
				<li><a href="bbsInsect.jsp">곤충</a>
			</ul>
			<%  //로그인 되어있지 않은 경우만 나올 수 있음
				if (userID == null) {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">접속하기<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="login.jsp">로그인</a></li>
						<li><a href="join.jsp">회원가입</a></li>
					</ul>
				</li>
			</ul>
			<%
				} else {   //로그인 되어있을 때
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">회원관리<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="logoutAction.jsp">로그아웃</a></li>
					</ul>
				</li>
			</ul>
			<%
				}
			%>
		</div>
	</nav>
	
	<div class="page-main" role="main">

    <div id="buttons2">
    <div id="dream">
        <h2 style="font-family: 'Nanum Myeongjo', serif; text-align: center;">꿈</h2>
        <h4 style="font-family: 'Nanum Myeongjo', serif; text_align: center; color: #dcd7ee;">
        : 잠자는 동안 일어나는 심리적 현상의 연속</h4>
    </div>
        <div class="inner clearfix" style="font-family: 'Nanum Myeongjo', serif">
            <button>
                <a href="bbsLife.jsp">
                <span>
                    <img src="img/1_gr.png">
                    <img src="img/1_bl.png"><br>
                                   죽음/질병
                </span>
                </a>
            </button>
            <button>
                <a href="bbsAnimal.jsp">
                <span>
                    <img src="img/2_gr.png">
                    <img src="img/2_bl.png"><br>
                                   동물
                </span>
                </a>
            </button>
            <button>
                <span>
                <a href="bbsPlant.jsp">
                    <img src="img/3_gr.png">
                    <img src="img/3_bl.png"><br>
                                   식물
                </a>
                </span>
            </button>
            <button>
                <span>
                <a href="bbsInsect.jsp">
                    <img src="img/4_gr.png">
                    <img src="img/4_bl.png"><br>
                                   곤충
                </a>
                </span>
            </button>
        </div>
    </div>

	</div>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<script src="js/bootstrap.js"></script>
	<script src="js/main.js"></script>
	<script src="js/main_vendor/jquery-1.10.2.min.js"></script>
	<script src="js/main_vendor/jquery-ui-1.10.3.custom.min.js"></script>
</body>
</html>