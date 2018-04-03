package com.namiya.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.sql.DataSource;

public class NamiyaUserDAO {
	private static NamiyaUserDAO instance=new NamiyaUserDAO();
	private DataSourceManager db;
	private DataSource dataSource;
	private NamiyaUserDAO() {
		db=DataSourceManager.getInstance();
		dataSource=db.getDataSource();
	}
	public static NamiyaUserDAO getInstance() {
		return instance;
	}
	
	public void closeAll(PreparedStatement pstmt,Connection con) throws SQLException{
		if(pstmt!=null)
			pstmt.close();
		if(con!=null)
			con.close(); 
	}
	public void closeAll(ResultSet rs,PreparedStatement pstmt,Connection con) throws SQLException{
		if(rs!=null)
			rs.close();
		closeAll(pstmt,con);
	}	
	
	//로그인 메서드
	public NamiyaUserVO login(String id, String password) throws SQLException {
		NamiyaUserVO vo = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = dataSource.getConnection();
			StringBuilder sql = new StringBuilder();
			sql.append("SELECT nickname, grade ");
			sql.append("FROM namiya_user ");
			sql.append("WHERE id = ? AND PASSWORD = ?");
			/*
			SELECT nickname, grade
			FROM namiya_user
			WHERE id = 'test@naver.com' AND PASSWORD = '123'
			*/
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, id);
			pstmt.setString(2, password);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				vo = new NamiyaUserVO();
				vo.setId(id);
				vo.setNickName(rs.getString(1));
				vo.setGrade(rs.getString(2));
			}
		} finally {
			closeAll(rs, pstmt, con); 
		}//finally
		return vo;
	}//method
	
	//회원가입 메서드
	public void createUser(NamiyaUserVO vo) throws SQLException {
		Connection con=null;
		PreparedStatement pstmt=null;
		try {
			con=dataSource.getConnection();
			String sql="INSERT INTO namiya_user(id, password, nickname ) VALUES(?,?,?)";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, vo.getId());
			pstmt.setString(2, vo.getPassword());
			pstmt.setString(3, vo.getNickName());
			pstmt.executeUpdate();
		}finally {
			closeAll(pstmt, con);
		}
	}//method
	
	// 임시비밀번호 발송
	public int tempPassword(String id, String password) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int result = 0;
		try {
			con = dataSource.getConnection();
			// 아이디가 존재하는지 조회
			String sql = "SELECT count(*) FROM namiya_user WHERE id = ?";
			/*
			 	SELECT id FROM namiya_user WHERE id = ?
			 */
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1,id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				result = rs.getInt(1);
			}
			pstmt.close();
			
			// 비밀번호 수정
			 sql = "UPDATE namiya_user SET password = ? WHERE id = ?";
			/*
				UPDATE namiya_user SET password = ? WHERE id = ?
			 */
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, password);
			pstmt.setString(2, id);
			pstmt.executeUpdate();
		} finally {
			closeAll(rs, pstmt, con);
		}
		return result;
	}// method
	
	// 회원수정 메서드
	public void updateUser(NamiyaUserVO vo) throws SQLException {
		Connection con=null;
		PreparedStatement pstmt=null;
		try {
			con=dataSource.getConnection();
			String sql="UPDATE namiya_user SET nickname = ?, password = ? WHERE id = ?";
			/*
				UPDATE namiya_user SET nickname = ?, password = ? WHERE id = ?
			 */
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, vo.getNickName());
			pstmt.setString(2, vo.getPassword());
			pstmt.setString(3, vo.getId());
			pstmt.executeUpdate();
		}finally {
			closeAll(pstmt, con);
		}
	}//method
	
	//회원탈퇴 메서드
	public void deleteUser(String id) throws SQLException {
		Connection con=null;
		PreparedStatement pstmt=null;
		try {
			con=dataSource.getConnection();
			String sql="UPDATE namiya_user SET grade = 'd' WHERE id = ?";
			/*
				UPDATE namiya_user SET grade = 'd' WHERE id = ?
			 */
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.executeUpdate();
		}finally {
			closeAll(pstmt, con);
		}
	}//method
	
	//전체 회원 수 조회 메서드
	public int totalUserCount() throws SQLException {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int count=0;
		try {
			con=dataSource.getConnection();
			String sql="select count(*) from namiya_user";
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				count=rs.getInt(1);
			}
		}finally {
			closeAll(rs, pstmt, con);
		}
		return count;
	}//method
}
