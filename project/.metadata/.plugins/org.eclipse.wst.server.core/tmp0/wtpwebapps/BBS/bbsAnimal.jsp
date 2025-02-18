<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>   <!-- 라이브러리 불러오기 -->
<%@ page import="bbsanimal.BbsAnimalDAO" %>  <!-- bbs패키지에 있는 BbsDAO -->
<%@ page import="bbsanimal.BbsAnimal" %>

<%@ page import="java.util.ArrayList" %>  <!-- 게시판 목록 출력 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.min.css">  <!-- bootstrap: 디자인 프레임워크(반응형) -->
<link rel="stylesheet" href="css/custom.css">
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
		
		int pageNumber = 1;  //기본적으로 1페이지
		if (request.getParameter("pageNumber") != null) {
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
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
				<li><a href="main.jsp">메인</a></li>  <!-- active: 현재 접속한 페이지 -->
				<li><a href="bbs.jsp">기타</a></li>
				<li><a href="bbsLife.jsp">죽음/질병</a>
				<li class="active"><a href="bbsAnimal.jsp">동물</a>
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
	<div class="container">  <!-- 특정한 내용을 담을 수 있는 container 지정 -->
		<div class="row">  <!-- table-striped: 게시판의 글 목록들이 홀/짝수 번갈아가면서 색상 변경 -->
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
			<thead>
				<tr>  <!-- 글의 목록만 보여주는 기능 -->
					<th style="background-color: #eeeeee; text-align: center; ">번호</th>
					<th style="background-color: #eeeeee; text-align: center; ">제목</th>
					<th style="background-color: #eeeeee; text-align: center; ">작성자</th>
					<th style="background-color: #eeeeee; text-align: center; ">작성일</th>
				</tr>
			</thead>
			<tbody>
				<%
					BbsAnimalDAO bbsAnimalDAO = new BbsAnimalDAO();
					ArrayList<BbsAnimal> list = bbsAnimalDAO.getList(pageNumber);
					for (int i = 0; i < list.size(); i++) {
				%>
				<tr>
					<td><%= list.get(i).getBbsAnimalID() %></td> 
					<td><a href="viewAnimal.jsp?bbsAnimalID=<%=list.get(i).getBbsAnimalID() %>">
					<%= list.get(i).getBbsAnimalTitle() %></a></td>
					<!-- 제목 누르면 해당 게시글의 내용을 보여주는 페이지로 이동 -->
					<!-- 해당 게시글 번호를 매개변수로 보냄 -->
					<td><%= list.get(i).getUserID() %></td>
					<td><%= list.get(i).getBbsAnimalDate().substring(0, 11) 
					+ list.get(i).getBbsAnimalDate().substring(11, 13) 
					+ "시" + list.get(i).getBbsAnimalDate().substring(14, 16) + "분" %></td>
					<!-- substirng: 필요한 부분만 잘라서 출력 -->
				</tr>
				<%
					}
				%>
			</tbody>
			</table>
				<%
					if (pageNumber != 1) {
				%>
					<a href="bbsAnimal.jsp?pageNumber=<%=pageNumber - 1 %>" class="btn btn-success btn-arrow-left"
					style="background-color: #888686; border: #888686">이전</a>
				<%
					} if(bbsAnimalDAO.nextPage(pageNumber + 1)) {  //다음 페이지가 존재한다면
				%>
					<a href="bbsAnimal.jsp?pageNumber=<%=pageNumber + 1 %>" class="btn btn-success btn-arrow-right"
					style="background-color: #888686; border: #888686">다음</a>
				<%
					}
				%>
				
				<!-- 회원만 넘어갈 수 있음 -->
				<%
					if (session.getAttribute("userID") == null) {
						userID = "not null";
				%>
				<button class="btn btn-primary purll-right"
					onclick="if(confirm('권한이 없습니다.'))location.history.back();" type="button"				
					style="background-color:#b7b7b7; border:0;">글쓰기</button>
				<%
					} else if (session.getAttribute("userID").equals("관리자")) {
				%>
					<a href="writeAnimal.jsp" class="btn btn-primary pull-right" 
					style="background-color:#b7b7b7; border:0;">글쓰기</a>
				<%
					} else if (!session.getAttribute("userID").equals("관리자")) {
				%>
				
				<button class="btn btn-primary purll-right"
					onclick="if(confirm('권한이 없습니다.'))location.history.back();" type="button"				
					style="background-color:#b7b7b7; border:0;">글쓰기</button>
				<%
					}
				%>
				
			<!-- <a href="write.jsp" class="btn btn-primary pull-right">글쓰기</a>  <!-- 오른쪽에 글쓰기버튼 --> 
		</div>
	</div>
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>