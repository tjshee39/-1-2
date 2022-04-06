<%@ page language="java" contentType="text/html; charset=UTF-8"
 pageEncoding="UTF-8"%>
 
<%@ page import="user.UserDAO" %>   <!-- 이거 쓸거임 -->
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8");%>   <!-- 건너오는 데이터를 모두 UTF-8로 받음 -->

<jsp:useBean id="user" class="user.User" scope="page" />   <!-- 현재 페이지에서만 beans 쓸거임 -->
<jsp:setProperty name="user" property="userID" />   <!-- userID와 userPassword 받음 -->
<jsp:setProperty name="user" property="userPassword" />


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>JSP 웹사이트</title>
</head>
<body>
 
 	<%
 	String userID = null;
 	String userName = null;
 	if (session.getAttribute("userID") != null) {
 		userID = (String) session.getAttribute("userID");  //userID라는 변수가 할당된 세션아이디를 담을 수 있도록 해줌
 	}
 	if (userID != null) {  //이미 로그인이 되어있으면 로그인페이지로 다시 넘어가지 못함
 		PrintWriter script = response.getWriter();
 		script.println("<script>");
 		script.println("alert('이미 로그인이 되어있습니다.')");
 		script.println("location.href = 'main.jsp");   //main.jsp로 넘어가기
 		script.println("</script>");
 	}
 	UserDAO userDAO = new UserDAO();
 	int result = userDAO.withdrawal(user.getUserID(), user.getUserPassword());  //로그인 시도: login.jsp에서 받음 정보를 함수에서 받음
 	if (result == 1){  //회원 탈퇴 성공
 		PrintWriter script = response.getWriter();
 		script.println("<script>");
 		script.println("alert('회원 탈퇴를 완료하였습니다.')");
 		script.println("location.href = 'main.jsp'");   //main.jsp로 넘어가기
 		script.println("</script>");  
 		}
 	if (result == 0){   //비밀번호 오류
 		PrintWriter script = response.getWriter();
 		script.println("<script>");
 		script.println("alert('비밀번호가 틀립니다.')");
 		script.println("history.back()");   //이전페이지로 사용자 돌려보내기
 		script.println("</script>");  
 		}
 	if (result == -2){
 		PrintWriter script = response.getWriter();
 		script.println("<script>");
 		script.println("alert('데이터 베이스 오류가 발생하였습니다.')");
 		script.println("history.back()");
 		script.println("</script>");  
 		}
 	%>
 	
 	<%
 		session.invalidate();  //현재 이 페이지에 접속한 회원이 세션 빼앗기게 만듦 > 로그아웃
 	%>
 <!-- 
 myql jdbc driver: mysql과 jsp연결
 eclipse > WEB-INF > lib > bin.jar 복붙
 project 폴더 우클릭 > property > Java Build Path > Libraries
 > Add JARs > 추가했던 bin.jar(driver)선택 > 연동완료^~
  -->
 
</body>
</html>