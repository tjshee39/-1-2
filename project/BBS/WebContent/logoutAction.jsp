<%@ page language="java" contentType="text/html; charset=UTF-8"
 pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>JSP 웹사이트</title>
</head>
<body> 
 	<%
 		session.invalidate();  //현재 이 페이지에 접속한 회원이 세션 빼앗기게 만듦 > 로그아웃
 	%>
 	<script>
 		location.href = 'main.jsp';  //main.jsp로 넘어가기
 	</script>
</body>
</html>