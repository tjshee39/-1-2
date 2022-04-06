package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class BbsDAO {
	private Connection conn;   // connection: �����ͺ��̽��� ���� �����ϰ� ���ִ� ��ü
	private ResultSet rs;   // ��� ������ ���� �� �ִ� ��ü(DB data), ctrl + shift + o = auto import

	public BbsDAO() {  //class�̸��� method�̸� ����, DB����
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
		String SQL = "SELECT bbsID FROM BBS ORDER BY bbsID DESC"; //BBS���̺��� ��������(bbsID����)���� ���� �������� ���� ���� ��ȣ ������
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
	
	public int write(String bbsTitle, String userID, String bbsContent) {  //�Խñ� db�� ����
		String SQL = "INSERT INTO BBS VALUES (?, ?, ?, ?, ?, ?, ?)"; 
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);  //sql���ڸ� �����غ�ܰ� ���·�
			pstmt.setInt(1, getNext());  //�Խñ� ��ȣ
			pstmt.setString(2, bbsTitle);
			pstmt.setString(3, userID);
			pstmt.setString(4, getDate());
			pstmt.setString(5, bbsContent);
			pstmt.setInt(6, 1);  //available = 1: ���� �ȵ�
			pstmt.setInt(7, 0);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;  //�����ͺ��̽� ����
	}

	public ArrayList<Bbs> getList(int pageNumber) {  //DB���� �� ��� �������� �ҽ��ڵ�� BbsDAO.java�� ����Ʈ�� ��� ��ȯ

		String SQL = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1 ORDER BY bbsID DESC LIMIT 10"; //���������� �� �ִ� 10��
		ArrayList<Bbs> list  = new ArrayList<Bbs>();  //Bbs��� Ŭ�������� ���� �ν��Ͻ��� ������ �� �ִ� ����Ʈ
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);  //sql���ڸ� �����غ�ܰ� ���·�
			pstmt.setInt(1, getNext() - (pageNumber -1) * 10);
			rs = pstmt.executeQuery();  //������ �������� �� ������ ��� ������
			while (rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				bbs.setBbsHit(rs.getInt(7));
				list.add(bbs);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;  //�Խñ� ����Ʈ ���
	}
	
	public boolean nextPage(int pageNumber) {  //����¡ ó��
		String SQL = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1"; //���������� �� �ִ� 10��
		ArrayList<Bbs> list  = new ArrayList<Bbs>();  //Bbs��� Ŭ�������� ���� �ν��Ͻ��� ������ �� �ִ� ����Ʈ
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
	
	public Bbs getBbs(int bbsID) {  //�Խñ��� ���� �ҷ����� �Լ� (Ư���� id�� �ش��ϴ� �Խñ� ������)
		String SQL = "SELECT * FROM BBS WHERE bbsID = ?";  //bbsID�� Ư���� ������ ���
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);  //sql���ڸ� �����غ�ܰ� ���·�
			pstmt.setInt(1, bbsID);
			rs = pstmt.executeQuery();  //������ �������� �� ������ ��� ������
			if (rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				bbs.setBbsHit(rs.getInt(7));
				updateHit(bbsID, bbs.getBbsHit());
				
				return bbs;  //�������� ������ ���� �� bbs�ν��Ͻ��� �־���
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;  
	}
	
	public int updateHit(int bbsID, int bbsHit) {
		String SQL = "UPDATE BBS SET bbsHit = ? WHERE bbsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsHit + 1);
			pstmt.setInt(2, bbsID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int updateHitMod(int bbsID) {
		String SQL = "UPDATE BBS SET bbsHit = bbsHit-2 WHERE bbsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int update(int bbsID, String bbsTitle, String bbsContent) {  
		String SQL = "UPDATE BBS SET bbsTitle = ?, bbsContent = ? , bbsDate = ? WHERE bbsID = ?";  //Ư���� bbsID�� ���� ����� ���� ���� 
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);  //sql���ڸ� �����غ�ܰ� ���·�
			pstmt.setString(1, bbsTitle);  
			pstmt.setString(2, bbsContent);
			pstmt.setString(3, getDate());
			pstmt.setInt(4, bbsID);
			updateHitMod(bbsID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;  //�����ͺ��̽� ����
	}
	
	public int delete(int bbsID) {
		String SQL = "UPDATE BBS SET bbsAvailable = 0 WHERE bbsID = ?";  //�� �����ص� ����� ����
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);  //sql���ڸ� �����غ�ܰ� ���·�
			pstmt.setInt(1, bbsID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;  //�����ͺ��̽� ����
	}
}
	
	


