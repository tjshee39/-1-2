package bbslife;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class BbsLifeDAO {
	private Connection conn;   // connection: �����ͺ��̽��� ���� �����ϰ� ���ִ� ��ü
	private ResultSet rs;   // ��� ������ ���� �� �ִ� ��ü(DB data), ctrl + shift + o = auto import

	public BbsLifeDAO() {  //class�̸��� method�̸� ����, DB����
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
	
	public String getDate() {  //�� �ۼ� �� ���� ������ �ð� �־���
		String SQL = "SELECT NOW()"; //���� �ð��� �������� sql����
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);  //sql���ڸ� �����غ�ܰ� ���·�
			rs = pstmt.executeQuery();  //������ �������� �� ������ ��� ������
			if (rs.next()) {
				return rs.getString(1);  //������ ��¥ �״�� ��ȯ
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";  //�����ͺ��̽� ����
	}
	
	public int getNext() {  
		String SQL = "SELECT bbsLifeID FROM BBSLIFE ORDER BY bbsLifeID DESC"; //BBS���̺����� ��������(bbsID����)���� ���� �������� ���� ���� ��ȣ ������
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);  //sql���ڸ� �����غ�ܰ� ���·�
			rs = pstmt.executeQuery();  //������ �������� �� ������ ��� ������
			if (rs.next()) {
				return rs.getInt(1) +1;  //���� �Խñ��� ��ȣ
			}
			return 1;  //ù ���� �Խñ��� ���
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;  //�����ͺ��̽� ����
	}
	
	public int write(String bbsLifeTitle, String userID, String bbsLifeContent) {  //�Խñ� db�� ����
		String SQL = "INSERT INTO BBSLIFE VALUES (?, ?, ?, ?, ?, ?, ?)"; 
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);  //sql���ڸ� �����غ�ܰ� ���·�
			pstmt.setInt(1, getNext());  //�Խñ� ��ȣ
			pstmt.setString(2, bbsLifeTitle);
			pstmt.setString(3, userID);
			pstmt.setString(4, getDate());
			pstmt.setString(5, bbsLifeContent);
			pstmt.setInt(6, 1);  //available = 1: ���� �ȵ�
			pstmt.setInt(7, 0);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;  //�����ͺ��̽� ����
		}

	
	
	public ArrayList<BbsLife> getList(int pageNumber) {  //DB���� �� ��� �������� �ҽ��ڵ�� BbsDAO.java�� ����Ʈ�� ��� ��ȯ

		String SQL = "SELECT * FROM BBSLIFE WHERE bbsLifeID < ? AND bbsLifeAvailable = 1 ORDER BY bbsLifeID DESC LIMIT 10"; //���������� �� �ִ� 10��
		ArrayList<BbsLife> list  = new ArrayList<BbsLife>();  //Bbs��� Ŭ�������� ���� �ν��Ͻ��� ������ �� �ִ� ����Ʈ
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);  //sql���ڸ� �����غ�ܰ� ���·�
			pstmt.setInt(1, getNext() - (pageNumber -1) * 10);
			rs = pstmt.executeQuery();  //������ �������� �� ������ ��� ������
			while (rs.next()) {
				BbsLife bbslife = new BbsLife();
				bbslife.setBbsLifeID(rs.getInt(1));
				bbslife.setBbsLifeTitle(rs.getString(2));
				bbslife.setUserID(rs.getString(3));
				bbslife.setBbsLifeDate(rs.getString(4));
				bbslife.setBbsLifeContent(rs.getString(5));
				bbslife.setBbsLifeAvailable(rs.getInt(6));
				bbslife.setBbsLifeHit(rs.getInt(7));
				list.add(bbslife);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;  //�Խñ� ����Ʈ ���
	}
	
	public boolean nextPage(int pageNumber) {  //����¡ ó��
		String SQL = "SELECT * FROM BBSLIFE WHERE bbsLifeID < ? AND bbsLifeAvailable = 1"; //���������� �� �ִ� 10��
		ArrayList<BbsLife> list  = new ArrayList<BbsLife>();  //Bbs��� Ŭ�������� ���� �ν��Ͻ��� ������ �� �ִ� ����Ʈ
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);  //sql���ڸ� �����غ�ܰ� ���·�
			pstmt.setInt(1, getNext() - (pageNumber -1) * 10);
			rs = pstmt.executeQuery();  //������ �������� �� ������ ��� ������
			if (rs.next()) {
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;  
	}
	
	public BbsLife getBbsLife(int bbsLifeID) {  //�Խñ��� ���� �ҷ����� �Լ� (Ư���� id�� �ش��ϴ� �Խñ� ������)
		String SQL = "SELECT * FROM BBSLIFE WHERE bbsLifeID = ?";  //bbsID�� Ư���� ������ ���
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);  //sql���ڸ� �����غ�ܰ� ���·�
			pstmt.setInt(1, bbsLifeID);
			rs = pstmt.executeQuery();  //������ �������� �� ������ ��� ������
			if (rs.next()) {
				BbsLife bbslife = new BbsLife();
				bbslife.setBbsLifeID(rs.getInt(1));
				bbslife.setBbsLifeTitle(rs.getString(2));
				bbslife.setUserID(rs.getString(3));
				bbslife.setBbsLifeDate(rs.getString(4));
				bbslife.setBbsLifeContent(rs.getString(5));
				bbslife.setBbsLifeAvailable(rs.getInt(6));
				bbslife.setBbsLifeHit(rs.getInt(7));
				updateHit(bbsLifeID, bbslife.getBbsLifeHit());
				
				return bbslife;  //�������� ������ ���� �� bbs�ν��Ͻ��� �־���
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;  
	}
	
	public int updateHit(int bbsLifeID, int bbsLifeHit) {
		String SQL = "UPDATE BBSLIFE SET bbsLifeHit = ? WHERE bbsLifeID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsLifeHit + 1);
			pstmt.setInt(2, bbsLifeID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int updateHitMod(int bbsLifeID) {
		String SQL = "UPDATE BBSLIFE SET bbsLifeHit = bbsLifeHit-2 WHERE bbsLifeID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsLifeID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int update(int bbsLifeID, String bbsLifeTitle, String bbsLifeContent) {  
		String SQL = "UPDATE BBSLIFE SET bbsLifeTitle = ?, bbsLifeContent = ?, bbsLifeDate = ? WHERE bbsLifeID = ?";  //Ư���� bbsID�� ���� ����� ���� ���� 
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);  //sql���ڸ� �����غ�ܰ� ���·�
			pstmt.setString(1, bbsLifeTitle);  
			pstmt.setString(2, bbsLifeContent);
			pstmt.setString(3, getDate());
			pstmt.setInt(4, bbsLifeID);
			updateHitMod(bbsLifeID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;  //�����ͺ��̽� ����
	}
	
	public int delete(int bbsLifeID) {
		String SQL = "UPDATE BBSLIFE SET bbsLifeAvailable = 0 WHERE bbsLifeID = ?";  //�� �����ص� ����� ����
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);  //sql���ڸ� �����غ�ܰ� ���·�
			pstmt.setInt(1, bbsLifeID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;  //�����ͺ��̽� ����
	}
}
	
	

