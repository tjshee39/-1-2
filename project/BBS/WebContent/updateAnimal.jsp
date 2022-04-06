<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>   <!-- 라이브러리 불러오기 -->
<%@ page import="bbsanimal.BbsAnimal" %>
<%@ page import="bbsanimal.BbsAnimalDAO" %>
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

<!-- 글 수정 -->

	<%   //로그인 된 사람들의 정보를 담을 수 있도록 만듦
		String userID = null;
		if (session.getAttribute("userID") != null) {  //현재 세션이 존재하는 사람이라면 ID값을 그대로 받아 관리할 수 있도록 만듦
			userID = (String) session.getAttribute("userID");
		}  //userID라는 변수에 해당ID가 담기고 그렇지 않은 사람들은 null
		
		if (userID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href = 'login.jsp");   //login.jsp로 넘어가기
			script.println("</script>");
		}
		
		int bbsAnimalID = 0;
		
		if (request.getParameter("bbsAnimalID") != null) {  //bbsID라는 매개변수가 존재한다면
			bbsAnimalID = Integer.parseInt(request.getParameter("bbsAnimalID"));
		}
		
		if (bbsAnimalID == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href = 'bbs.jsp");   //bbs.jsp로 넘어가기
			script.println("</script>");
		}
		
		BbsAnimal bbsanimal = new BbsAnimalDAO().getBbsAnimal(bbsAnimalID);  //넘어온 bbsID로 해당 글을 가져옴
		if (!userID.equals(bbsanimal.getUserID())) {  //현재 유저가 글 작성자가 아니라면
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href = 'bbsAnimal.jsp");   //bbs.jsp로 넘어가기
			script.println("</script>");
		}
	%>
	<nav class="navbar navbar-default">
		<div class="navbar-header">  <!-- 홈페이지 로고 -->
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
			<a class="navbar-brand" href="main.jsp"><img src="images/navTitle.png" height="100%"></a>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="main.jsp">메인</a></li>  <!-- active: 현재 접속한 페이지 -->
				<li><a href="bbs.jsp">기타</a></li>
				<li><a href="bbsLife.jsp">죽음/질병</a>
				<li class="active"><a href="bbsAnimal.jsp">동물</a>
				<li><a href="bbsPlant.jsp">식물</a>
				<li><a href="bbsInsect.jsp">곤충</a>
			</ul>
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
		</div>
	</nav>
	<div class="container">  <!-- 특정한 내용을 담을 수 있는 container 지정 -->
		<div class="row">  <!-- table-striped: 게시판의 글 목록들이 홀/짝수 번갈아가면서 색상 변경 -->
			<form method="post" action="updateAnimalAction.jsp?bbsAnimalID=<%= bbsAnimalID %>">  <!-- bbsID가 updateAction.jsp로 보내짐 -->
				<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>  <!-- 글의 목록만 보여주는 기능 -->
							<th colspan = "2" style="background-color: #eeeeee; text-align: center; ">게시판 글 수정 양식</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><input type = "text" class="form-control" placeholder="글 제목" name="bbsAnimalTitle" maxlength="50" 
							value=<%= bbsanimal.getBbsAnimalTitle() %>></td>  <!-- 수정하기 전의 제목 보여줌 -->
						</tr>	   
						<tr>
							<td><textarea class="form-control" placeholder="글 내용" name="bbsAnimalContent" maxlength="2048" 
							style="height: 350px;"><%= bbsanimal.getBbsAnimalContent() %></textarea></td>
							<!-- 수정하기 전의 내용 보여줌 -->
						</tr>
					</tbody>
				</table>
				<button type = "submit" class="btn btn-primary pull-right" style="background-color: #b7b7b7; border-color: #b7b7b7;">글수정</button>  <!-- 오른쪽에 글수정버튼 -->
			</form>
		</div>
	</div>
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>