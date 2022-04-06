<%@ page language="java" contentType="text/html; charset=UTF-8"
 pageEncoding="UTF-8"%>
 
<%@ page import="bbsinsect.BbsInsect" %>
<%@ page import="bbsinsect.BbsInsectDAO" %>  <!-- 이거 쓸거임 -->
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8");%>   <!-- 건너오는 모든 데이터를 UTR-8로 받음 -->

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>JSP 웹사이트</title>
</head>
<body>
 <!-- 글 수정 -->
 
 <%
 	String userID = null;  //로그인 된 사람은 들어갈 수 없음
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");  //userID라는 변수가 할당된 세션아이디를 담을 수 있도록 해줌
	}
	if (userID == null) {  //로그인 된 상태에서만 글쓰기 가능
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인 하세요.')");
		script.println("location.href = 'login.jsp");   //login.jsp로 넘어가기
		script.println("</script>");
	}
	
	//글이 유효한지 판별
	int bbsInsectID = 0;
	
	if (request.getParameter("bbsInsectID") != null) {  //bbsID라는 매개변수가 존재한다면
		bbsInsectID = Integer.parseInt(request.getParameter("bbsInsectID"));
	}
	
	if (bbsInsectID == 0) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 글입니다.')");
		script.println("location.href = 'bbsInsect.jsp");   //bbs.jsp로 넘어가기
		script.println("</script>");
	}
	
	BbsInsect bbsinsect = new BbsInsectDAO().getBbsInsect(bbsInsectID);  //넘어온 bbsID로 해당 글을 가져옴
	if (!userID.equals(bbsinsect.getUserID())) {  //현재 유저가 글 작성자가 아니라면
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('권한이 없습니다.')");
		script.println("location.href = 'bbsInsect.jsp");   //bbs.jsp로 넘어가기
		script.println("</script>");
	} else {
		if (request.getParameter("bbsInsectTitle") == null || request.getParameter("bbsInsectContent") == null
				|| request.getParameter("bbsInsectTitle").equals("") || request.getParameter("bbsInsectContent").equals("")){  //제목이나 내용 입력x
		    	PrintWriter script = response.getWriter();
		    	script.println("<script>");
		    	script.println("alert('입력이 되지 않은 사항이 있습니다.')");
		    	script.println("history.back()");
		    	script.println("</script>");     
		    } else {
				BbsInsectDAO bbsInsectDAO = new BbsInsectDAO();   //데이터베이스에 접근 가능한 객체
				int result = bbsInsectDAO.update(bbsInsectID, request.getParameter("bbsInsectTitle"), request.getParameter("bbsInsectContent")); 
				if (result == -1){
				   PrintWriter script = response.getWriter();
				   script.println("<script>");
			   	   script.println("alert('글 수정에 실패했습니다.')");
			   	   script.println("history.back()");
			   	   script.println("</script>");   
			  	   }
				else {  
			   	   PrintWriter script = response.getWriter();
			   	   script.println("<script>");
			   	   script.println("location.href = 'bbsInsect.jsp'");
			   	   script.println("</script>");
			  	   }
		    }
	}
 %>
 
 
</body>
</html>