<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>   <!-- 라이브러리 불러오기 -->
<%@ page import="bbsanimal.BbsAnimal" %>
<%@ page import="bbsanimal.BbsAnimalDAO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.min.css">  <!-- bootstrap: 디자인 프레임워크(반응형) -->
<link rel="stylesheet" href="css/custom.css">
<title>JSP BBS</title>
</head>
<style>
  th, td {
    border: 1px solid #dddddd;
  }
</style>
<body>

<!-- 글내용 보기 -->

	<%   //로그인 된 사람들의 정보를 담을 수 있도록 만듦
		String userID = null;
		if (session.getAttribute("userID") != null) {  //현재 세션이 존재하는 사람이라면 ID값을 그대로 받아 관리할 수 있도록 만듦
			userID = (String) session.getAttribute("userID");
		}  //userID라는 변수에 해당ID가 담기고 그렇지 않은 사람들은 null
		
		int bbsAnimalID = 0;
		
		if (request.getParameter("bbsAnimalID") != null) {  //bbsID라는 매개변수가 존재한다면
			bbsAnimalID = Integer.parseInt(request.getParameter("bbsAnimalID"));
		}
		
		if (bbsAnimalID == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href = 'bbsAnimal.jsp");   //bbs.jsp로 넘어가기
			script.println("</script>");
		}
		
		BbsAnimal bbsanimal = new BbsAnimalDAO().getBbsAnimal(bbsAnimalID);  //구체적인 정보를 bbs라는 인스턴스에 담아줌
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
			<%  //로그인 되어있지 않은 경우만 나올 수 있음(접속하기)
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
	<div class="container">  <!-- 특정한 내용을 담을 수 있는 container 지정 -->
		<div class="row">  <!-- table-striped: 게시판의 글 목록들이 홀/짝수 번갈아가면서 색상 변경 -->
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
			<thead>
				<tr>  <!-- 글의 목록만 보여주는 기능 -->
					<th colspan = "4" style="background-color: #eeeeee; text-align: center; ">게시판 글 보기 양식</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td colspan="2">글 제목</td>
					<td colspan="2"><%= bbsanimal.getBbsAnimalTitle().replaceAll(" ", "&nbsp;")
					.replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br/>") %></td>
							<!-- <script>가 삽입될 수 있는 문제 방지 -->
				</tr>	    <!-- input: action페이지에 전송 -->
				<tr>
					<td>작성자</td>
					<td style="width: 20%;"><%= bbsanimal.getUserID() %></td>
					<td>조회수</td>
					<td style="width: 20%;"><%= bbsanimal.getBbsAnimalHit() %></td>
				</tr>
				<tr>
					<td colspan="2">작성일자</td>
					<td colspan="2" style="width: 20%;"><%= bbsanimal.getBbsAnimalDate().substring(0, 11) 
					+ bbsanimal.getBbsAnimalDate().substring(11, 13) 
					+ "시" + bbsanimal.getBbsAnimalDate().substring(14, 16) + "분"%></td>
				</tr>
				<tr>
					<td colspan="4">내용</td>
				</tr>
				<tr>
					<td colspan="4" style="min-height: 200px; text-align: center; margin-left: auto; margin-right: auto;">
						<%= bbsanimal.getBbsAnimalContent().replaceAll(" ", "&nbsp;")
						.replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br/>") %>
					</td>
					<!-- 특수문자 대체 대체 -->
				</tr>
			</tbody>
			</table>
			<a href = "bbsAnimal.jsp" class = "btn btn-primary" style="background-color: #b7b7b7; border-color: #b7b7b7;">목록</a>
			<c:if test="${userID eq '관리자' }">
				<a href = "bbsAnimal.jsp" class = "btn btn-primary" style="background-color: #b7b7b7; border-color: #b7b7b7;">목록</a>
				<a href="updateAnimal.jsp?bbsAnimalID=<%= bbsAnimalID %>" class = "btn btn-primary" style="background-color: #b7b7b7; border-color: #b7b7b7;">수정</a>
				<a onclick="return confirm('삭제하시겠습니까?')" href="deleteAnimalAction.jsp?bbsAnimalID=<%= bbsAnimalID %>" 
					class = "btn btn-primary" style="background-color: #b7b7b7; border-color: #b7b7b7;">삭제</a>
			</c:if> 
		</div>
	</div>
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>