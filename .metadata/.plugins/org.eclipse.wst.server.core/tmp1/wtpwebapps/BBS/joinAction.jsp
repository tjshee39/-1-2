<%@ page language="java" contentType="text/html; charset=UTF-8"
 pageEncoding="UTF-8"%>
 
<%@ page import="user.UserDAO" %>  <!-- 이거 쓸거임 -->
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8");%>   <!-- 건너오는 모든 데이터를 UTR-8로 받음 -->

<jsp:useBean id="user" class="user.User" scope="page" />   <!-- 현재 페이지에서만 Beans 사용 -->
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userPassword" />
<jsp:setProperty name="user" property="userName" />
<jsp:setProperty name="user" property="userGender" />
<jsp:setProperty name="user" property="userEmail" />


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>JSP 웹사이트</title>
</head>
<body>
 
 <%
    String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");  //userID라는 변수가 할당된 세션아이디를 담을 수 있도록 해줌
	}
	if (userID != null) {  //이미 로그인이 되어있으면 회원가입 페이지로 다시 넘어가지 못함
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('이미 로그인이 되어있습니다.')");
		script.println("location.href = 'main.jsp");   //main.jsp로 넘어가기
		script.println("</script>");
	}
    if (user.getUserID() == null || user.getUserPassword() == null || user.getUserName() == null
    	|| user.getUserGender() == null || user.getUserEmail() == null){
    	PrintWriter script = response.getWriter();
    	script.println("<script>");
    	script.println("alert('입력이 되지 않은 사항이 있습니다.')");
    	script.println("history.back()");
    	script.println("</script>");     
    } else {
		UserDAO userDAO = new UserDAO();   //데이터베이스에 접근 가능한 객체
		int result = userDAO.join(user);   //사용자가 입력한 user정보가 담긴 user라는 인스턴스가 join함수 실행 	
		if (result == -1){
		   PrintWriter script = response.getWriter();
		   script.println("<script>");
	   	   script.println("alert('이미 존재하는 아이디입니다.')");
	   	   script.println("history.back()");
	   	   script.println("</script>");   
	  	   }
		else {  //회원가입 정상적으로 완료
		   session.setAttribute("userID", user.getUserID());  //해당회원의 ID를 세션값으로 넣어줌
	   	   PrintWriter script = response.getWriter();
	   	   script.println("<script>");
	   	   script.println("alert('가입이 완료되었습니다.')");
	   	   script.println("location.href = 'main.jsp'");
	   	   script.println("</script>");
	  	   }
    }
 %>
 
 
</body>
</html>