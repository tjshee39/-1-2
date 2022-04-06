package user;   //회원정보 접근, 데이터베이스 접근객체

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {

 private Connection conn;   // connection: 데이터베이스에 접근 가능하게 해주는 객체
 private PreparedStatement pstmt;
 private ResultSet rs;   // 어떠한 정보를 담을 수 있는 객체

 public UserDAO() {
  try {
   String dbURL = "jdbc:mysql://localhost:3306/BBS?serverTimezone=UTC";
   String dbID = "root";
   String dbPassword = "1234";   // 자신의 root계정의 비밀번호
   Class.forName("com.mysql.jdbc.Driver");   // mysql 드라이버: mysql에 접속할 수 있도록 해주는 매개체의 라이브러리
   conn = DriverManager.getConnection(dbURL, dbID, dbPassword);   //dbRUL에 dbID와 dbPassword를 이용하여 접속

  } catch (Exception e) {   // 예외처리
   e.printStackTrace();   // 오류발생
  }
 }

 public int login(String userID, String userPassword) {   //userID와 userPassword를 입력받아 로그인 시도
  String SQL = "SELECT userPassword FROM USER WHERE userID=?";   //실제로 데이터베이스에 입력할 명령어
  try {															//: usertable에서 user의 Password 가져오게 함
   pstmt = conn.prepareStatement(SQL);   //정해진 sql문장을 데이터베이스에 삽입
   pstmt.setString(1, userID);   //?에 해당하는 내용으로 userID를 넣어줌. ID가 뭔지, 그 ID가 실제로 존재하는지, 그 ID의 Password는 뭔지 가져옴
   rs = pstmt.executeQuery();   //결과를 담을 수 있는 객체에 실행한 결과를 넣어줌
   if(rs.next()) {   //결과가 존재 한다면(ID와 Password 일치한다면)
    if(rs.getString(1).equals(userPassword)) {   //접속을 시도한 Password와 데이터베이스에서 가져온 Password 일치
     return 1;  // 로그인 성공
   }
    else
    	return 0;  // 비밀번호 불일치
   }
   return -1;  // 아이디가 없음
   
  } catch(Exception e) {
	  e.printStackTrace();
  }
  return -2; // 데이터 베이스 오류
}
  
 public int join(User user) {   //한 명의 사용자 입력받음, User class 이용
	  String SQL = "INSERT INTO USER VALUES (?, ?, ?, ?, ?)";
	  try {
		  pstmt = conn.prepareStatement(SQL);   //커넥션에 sql 문장
		  pstmt.setString(1, user.getUserID());   //매개변수로 넘어온 user 인스턴스에 값 받음
		  pstmt.setString(2, user.getUserPassword());
		  pstmt.setString(3, user.getUserName());
		  pstmt.setString(4, user.getUserGender());
		  pstmt.setString(5, user.getUserEmail());
		  return pstmt.executeUpdate();   //해당 statement 실행한 결과 넣음
	  } catch(Exception e) {
		  e.printStackTrace();
	  }
	  return -1; //데이터베이스 오류
  }
 
 public int withdrawal(String userID, String userPassword) {   //userID와 userPassword를 입력받아 로그인 시도
	  String SQL = "SELECT userPassword FROM USER WHERE userID=?";   //실제로 데이터베이스에 입력할 명령어
	  try {															//: usertable에서 user의 Password 가져오게 함
	   pstmt = conn.prepareStatement(SQL);   //정해진 sql문장을 데이터베이스에 삽입
	   pstmt.setString(1, userID);   //?에 해당하는 내용으로 userID를 넣어줌. ID가 뭔지, 그 ID가 실제로 존재하는지, 그 ID의 Password는 뭔지 가져옴
	   rs = pstmt.executeQuery();   //결과를 담을 수 있는 객체에 실행한 결과를 넣어줌
	   if(rs.next()) {   //결과가 존재 한다면(ID와 Password 일치한다면)
	    if(rs.getString(1).equals(userPassword)) {   //접속을 시도한 Password와 데이터베이스에서 가져온 Password 일치
	    	String SQL2 = "DELETE FROM USER WHERE userID=?";
	    	pstmt = conn.prepareStatement(SQL2);
	    	pstmt.setNString(1, userID);
			return pstmt.executeUpdate();  //탈퇴 성공
	   }
	    else
	    	return 0;  // 비밀번호 불일치
	   }
	   return -1;  // 아이디가 없음
	   
	  } catch(Exception e) {
		  e.printStackTrace();
	  }
	  return -2; // 데이터 베이스 오류
	}
  
  
 }
