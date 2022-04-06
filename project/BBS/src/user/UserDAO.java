package user;   //ȸ������ ����, �����ͺ��̽� ���ٰ�ü

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {

 private Connection conn;   // connection: �����ͺ��̽��� ���� �����ϰ� ���ִ� ��ü
 private PreparedStatement pstmt;
 private ResultSet rs;   // ��� ������ ���� �� �ִ� ��ü

 public UserDAO() {
  try {
   String dbURL = "jdbc:mysql://localhost:3306/BBS?serverTimezone=UTC";
   String dbID = "root";
   String dbPassword = "1234";   // �ڽ��� root������ ��й�ȣ
   Class.forName("com.mysql.jdbc.Driver");   // mysql ����̹�: mysql�� ������ �� �ֵ��� ���ִ� �Ű�ü�� ���̺귯��
   conn = DriverManager.getConnection(dbURL, dbID, dbPassword);   //dbRUL�� dbID�� dbPassword�� �̿��Ͽ� ����

  } catch (Exception e) {   // ����ó��
   e.printStackTrace();   // �����߻�
  }
 }

 public int login(String userID, String userPassword) {   //userID�� userPassword�� �Է¹޾� �α��� �õ�
  String SQL = "SELECT userPassword FROM USER WHERE userID=?";   //������ �����ͺ��̽��� �Է��� ��ɾ�
  try {															//: usertable���� user�� Password �������� ��
   pstmt = conn.prepareStatement(SQL);   //������ sql������ �����ͺ��̽��� ����
   pstmt.setString(1, userID);   //?�� �ش��ϴ� �������� userID�� �־���. ID�� ����, �� ID�� ������ �����ϴ���, �� ID�� Password�� ���� ������
   rs = pstmt.executeQuery();   //����� ���� �� �ִ� ��ü�� ������ ����� �־���
   if(rs.next()) {   //����� ���� �Ѵٸ�(ID�� Password ��ġ�Ѵٸ�)
    if(rs.getString(1).equals(userPassword)) {   //������ �õ��� Password�� �����ͺ��̽����� ������ Password ��ġ
     return 1;  // �α��� ����
   }
    else
    	return 0;  // ��й�ȣ ����ġ
   }
   return -1;  // ���̵� ����
   
  } catch(Exception e) {
	  e.printStackTrace();
  }
  return -2; // ������ ���̽� ����
}
  
 public int join(User user) {   //�� ���� ����� �Է¹���, User class �̿�
	  String SQL = "INSERT INTO USER VALUES (?, ?, ?, ?, ?)";
	  try {
		  pstmt = conn.prepareStatement(SQL);   //Ŀ�ؼǿ� sql ����
		  pstmt.setString(1, user.getUserID());   //�Ű������� �Ѿ�� user �ν��Ͻ��� �� ����
		  pstmt.setString(2, user.getUserPassword());
		  pstmt.setString(3, user.getUserName());
		  pstmt.setString(4, user.getUserGender());
		  pstmt.setString(5, user.getUserEmail());
		  return pstmt.executeUpdate();   //�ش� statement ������ ��� ����
	  } catch(Exception e) {
		  e.printStackTrace();
	  }
	  return -1; //�����ͺ��̽� ����
  }
 
 public int withdrawal(String userID, String userPassword) {   //userID�� userPassword�� �Է¹޾� �α��� �õ�
	  String SQL = "SELECT userPassword FROM USER WHERE userID=?";   //������ �����ͺ��̽��� �Է��� ��ɾ�
	  try {															//: usertable���� user�� Password �������� ��
	   pstmt = conn.prepareStatement(SQL);   //������ sql������ �����ͺ��̽��� ����
	   pstmt.setString(1, userID);   //?�� �ش��ϴ� �������� userID�� �־���. ID�� ����, �� ID�� ������ �����ϴ���, �� ID�� Password�� ���� ������
	   rs = pstmt.executeQuery();   //����� ���� �� �ִ� ��ü�� ������ ����� �־���
	   if(rs.next()) {   //����� ���� �Ѵٸ�(ID�� Password ��ġ�Ѵٸ�)
	    if(rs.getString(1).equals(userPassword)) {   //������ �õ��� Password�� �����ͺ��̽����� ������ Password ��ġ
	    	String SQL2 = "DELETE FROM USER WHERE userID=?";
	    	pstmt = conn.prepareStatement(SQL2);
	    	pstmt.setNString(1, userID);
			return pstmt.executeUpdate();  //Ż�� ����
	   }
	    else
	    	return 0;  // ��й�ȣ ����ġ
	   }
	   return -1;  // ���̵� ����
	   
	  } catch(Exception e) {
		  e.printStackTrace();
	  }
	  return -2; // ������ ���̽� ����
	}
  
  
 }
