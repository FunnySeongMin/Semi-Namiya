package com.namiya.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.sql.DataSource;

public class NamiyaDAO {
	private static NamiyaDAO instance = new NamiyaDAO();
	private DataSource dataSource;
	private DataSourceManager db;

	private NamiyaDAO() {
		db = DataSourceManager.getInstance();
		dataSource = db.getDataSource();
	}

	public static NamiyaDAO getInstance() {
		return instance;
	}

	public void closeAll(PreparedStatement pstmt, Connection con) throws SQLException {
		if (pstmt != null)
			pstmt.close();
		if (con != null)
			con.close();
	}

	public void closeAll(ResultSet rs, PreparedStatement pstmt, Connection con) throws SQLException {
		if (rs != null)
			rs.close();
		closeAll(pstmt, con);
	}

	// 게시글 등록 메서드
	public void createPost(NamiyaPostVO postVO) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = dataSource.getConnection();
			String sql = "INSERT INTO namiya_post(p_no, p_title, p_content, p_lock, id) "
					+ "VALUES(NAMIYA_POST_SEQ.NEXTVAL, ?, ?, ?, ?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, postVO.getpTitle());
			pstmt.setString(2, postVO.getpContent());
			pstmt.setString(3, postVO.getLock());
			pstmt.setString(4, postVO.getUserVO().getId());
			pstmt.executeUpdate();
			pstmt.close();
			pstmt = con.prepareStatement("select NAMIYA_POST_SEQ.CURRVAL from dual");
			rs = pstmt.executeQuery();
			if (rs.next())
				postVO.setpNo(rs.getInt(1));
		} finally {
			closeAll(rs, pstmt, con);
		}
	}// method

	// 답변 등록 메서드
	public void createReply(NamiyaAnswerVO answerVO) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = dataSource.getConnection();
			sql = "UPDATE namiya_post SET reply = 1 WHERE p_no = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, answerVO.getpNo());
			pstmt.executeUpdate();
			pstmt.close();
			sql = "insert into namiya_answer(p_no,a_title,a_content) values(?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, answerVO.getpNo());
			pstmt.setString(2, answerVO.getaTitle());
			pstmt.setString(3, answerVO.getaContent());
			pstmt.executeUpdate();
		} finally {
			closeAll(pstmt, con);
		}
	}// method

	// pagingBean에 따른 row넘버 기준으로 게시물 목록을 반환하는 메서드
	public ArrayList<NamiyaPostVO> readPostList(PagingBean pagingBean) throws SQLException {
		ArrayList<NamiyaPostVO> list = new ArrayList<NamiyaPostVO>();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = dataSource.getConnection();
			StringBuilder sql = new StringBuilder();
			sql.append("select p.p_no, p.p_title, p.p_date, p.p_lock, p.reply, p.id, u.nickname ");
			sql.append("from (select row_number() over(order by p_no desc) ");
			sql.append("rnum, p_no, p_title, p_lock, reply, id, ");
			sql.append("to_char(p_date,'yyyy.mm.dd') p_date from namiya_post) ");
			sql.append("p, namiya_user u where p.id=u.id and rnum ");
			sql.append("between ? and ? order by p_no desc");
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, pagingBean.getStartRowNumber());
			pstmt.setInt(2, pagingBean.getEndRowNumber());
			rs = pstmt.executeQuery();
			while (rs.next()) {
				NamiyaPostVO pvo = new NamiyaPostVO();
				pvo.setpNo(rs.getInt(1));
				pvo.setpTitle(rs.getString(2));
				pvo.setpDate(rs.getString(3));
				pvo.setLock(rs.getString(4));
				pvo.setReply(rs.getInt(5));
				NamiyaUserVO uvo = new NamiyaUserVO();
				uvo.setId(rs.getString(6));
				uvo.setNickName(rs.getString(7));
				pvo.setUserVO(uvo);
				list.add(pvo);
			}
		} finally {
			closeAll(rs, pstmt, con);
		}
		return list;
	}// method

	// 내가 작성한 글 총 개수를 반환하는 메서드
	public int readMyPostCount(String id) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int count = 0;
		try {
			con = dataSource.getConnection();
			StringBuilder sql = new StringBuilder();
			sql.append("SELECT count(*) ");
			sql.append("FROM namiya_user u, namiya_post p ");
			sql.append("WHERE u.id = p.id and u.id=? ");
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				count = rs.getInt(1);
			}
		} finally {
			closeAll(rs, pstmt, con);
		}
		return count;
	}// method

	// 전달받은 글번호에 맞는 글의 내용을 반환하는 메서드
	public NamiyaPostVO readPostInfo(int pno) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		NamiyaPostVO postVO = null;
		NamiyaUserVO userVO = null;
		try {
			con = dataSource.getConnection();
			String sql = "SELECT p_no, p_title, p_content, p_date, p_lock, reply, u.nickname, u.id "
					+ "FROM namiya_post p, namiya_user u WHERE u.id = p.id and p_no=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, pno);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				userVO = new NamiyaUserVO(rs.getString(8), rs.getString(7), null);
				postVO = new NamiyaPostVO(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4),
						rs.getString(5), rs.getInt(6), userVO);
			}
		} finally {
			closeAll(rs, pstmt, con);
		}
		return postVO;
	}

	// 전달받은 글번호에 맞는 답변의 내용을 반환하는 메서드
	public NamiyaAnswerVO readReply(int pno) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		NamiyaAnswerVO vo = new NamiyaAnswerVO();
		try {
			con = dataSource.getConnection();
			String sql = "SELECT a.p_no, a.a_title, a.a_content, to_char(a.a_date,'yyyy.mm.dd'), a.readRe"
					+ " FROM namiya_answer a, namiya_post p" + " WHERE a.p_no = p.p_no and a.p_no=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, pno);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				vo = new NamiyaAnswerVO(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getInt(5));
			}
		} finally {
			closeAll(rs, pstmt, con);
		}
		return vo;
	}// method

	// 게시글의 내용을 수정하는 메서드
	public void updatePost(int pNo, String pTitle, String pContent, String lock) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = dataSource.getConnection();
			String sql = "UPDATE namiya_post SET p_title = ?, p_content = ?, p_lock=? WHERE p_no = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, pTitle);
			pstmt.setString(2, pContent);
			pstmt.setString(3, lock);
			pstmt.setInt(4, pNo);
			pstmt.executeUpdate();
		} finally {
			closeAll(rs, pstmt, con);
		}
	}// method

	// 답변의 내용을 수정하는 메서드
	public void updateReply(int pno, String aTitle, String aContent) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = dataSource.getConnection();
			String sql = "update namiya_answer set a_title=?,a_content=? where p_no=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, aTitle);
			pstmt.setString(2, aContent);
			pstmt.setInt(3, pno);
			pstmt.executeUpdate();
		} finally {
			closeAll(pstmt, con);
		}
	}// method

	// 게시글을 삭제하는 메서드
	public void deletePost(int pno, String id) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = dataSource.getConnection();
			String sql = "DELETE FROM namiya_post WHERE p_no = ? and id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, pno);
			pstmt.setString(2, id);
			pstmt.executeUpdate();
		} finally {
			closeAll(rs, pstmt, con);
		}
	}// method

	// 답변을 삭제하는 메서드
	public void deleteReply(int pno) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = dataSource.getConnection();
			sql = "update namiya_post set reply=0 where p_no=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, pno);
			pstmt.executeUpdate();
			pstmt.close();
			sql = "delete from namiya_answer where p_no=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, pno);
			pstmt.executeUpdate();
		} finally {
			closeAll(pstmt, con);
		}
	}// method

	// 총 게시물 수를 반환하는 메서드
	public int getTotalPostCount() throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int count = 0;
		try {
			con = dataSource.getConnection();
			String sql = "select count(*) from namiya_post";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next())
				count = rs.getInt(1);
		} finally {
			closeAll(rs, pstmt, con);
		}
		return count;
	}// method

	// 답변이 없는 게시글의 목록을 가져오는 메서드
	public ArrayList<NamiyaPostVO> unAnsweredList(PagingBean pagingBean) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<NamiyaPostVO> list = new ArrayList<NamiyaPostVO>();
		try {
			con = dataSource.getConnection();
			StringBuilder sql = new StringBuilder();
			sql.append("select p.p_no,p.p_title,p.timeposted,p.p_lock,u.nickname ");
			sql.append("from (select row_number() over(order by p_no desc) as rnum,p_no,p_title,p_lock,reply, ");
			sql.append("id,to_char(p_date,'yyyy.mm.dd') timeposted from namiya_post where reply=0) p ");
			sql.append(", namiya_user u where u.id=p.id and rnum between ? and ? ");
			sql.append("order by p_no desc ");
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, pagingBean.getStartRowNumber());
			pstmt.setInt(2, pagingBean.getEndRowNumber());
			rs = pstmt.executeQuery();
			while (rs.next()) {
				NamiyaUserVO vo = new NamiyaUserVO();
				vo.setNickName(rs.getString(5));
				NamiyaPostVO pvo = new NamiyaPostVO();
				pvo.setpNo(rs.getInt(1));
				pvo.setpTitle(rs.getString(2));
				pvo.setpDate(rs.getString(3));
				pvo.setLock(rs.getString(4));
				pvo.setUserVO(vo);
				list.add(pvo);
			}
		} finally {
			closeAll(rs, pstmt, con);
		}
		return list;
	}// method

	// 아이디 체크 메서드
	public String checkId(String id) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String flag = null;
		try {
			con = dataSource.getConnection();
			String sql = "select id from namiya_user where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				flag = rs.getString(1);
			}
		} finally {
			closeAll(rs, pstmt, con);
		}
		return flag;
	}// method

	// 답변없는 게시물의 총 숫자
	public int getUnAnsweredPostCount() throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int count = 0;
		try {
			con = dataSource.getConnection();
			String sql = "select count(*) from namiya_post where reply=0";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				count = rs.getInt(1);
			}
		} finally {
			closeAll(rs, pstmt, con);
		}
		return count;
	}

	public NamiyaAnswerVO getUpdateAnswerView(int pno) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		NamiyaAnswerVO vo = new NamiyaAnswerVO();
		try {
			con = dataSource.getConnection();
			StringBuilder sql = new StringBuilder();
			sql.append("SELECT a.a_title, a.a_content, to_char(a.a_date,'yyyy.mm.dd') ");
			sql.append("FROM namiya_answer a, namiya_post p ");
			sql.append("WHERE a.p_no = p.p_no and a.p_no=?");
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, pno);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				vo.setpNo(pno);
				vo.setaTitle(rs.getString(1));
				vo.setaContent(rs.getString(2));
				vo.setaDate(rs.getString(3));
			}
		} finally {
			closeAll(rs, pstmt, con);
		}
		return vo;
	}

	// 내 상담 리스트
	public ArrayList<NamiyaPostVO> myPostList(String id, PagingBean pagingBean) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<NamiyaPostVO> list = new ArrayList<NamiyaPostVO>();
		try {
			con = dataSource.getConnection();
			StringBuilder sql = new StringBuilder();
			sql.append("select p.p_no,p.p_title,p.timeposted,p.p_lock,u.nickname,p.reply ");
			sql.append("from (select row_number() over(order by p_no desc) as rnum,p_no,p_title,p_lock,reply, ");
			sql.append("id,to_char(p_date,'yyyy.mm.dd') timeposted from namiya_post where id=?) p ");
			sql.append(", namiya_user u where u.id=p.id and rnum between ? and ? order by p_no desc");
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, id);
			pstmt.setInt(2, pagingBean.getStartRowNumber());
			pstmt.setInt(3, pagingBean.getEndRowNumber());
			rs = pstmt.executeQuery();
			while (rs.next()) {
				NamiyaUserVO vo = new NamiyaUserVO();
				vo.setId(id);
				vo.setNickName(rs.getString(5));
				NamiyaPostVO pvo = new NamiyaPostVO();
				pvo.setpNo(rs.getInt(1));
				pvo.setpTitle(rs.getString(2));
				pvo.setpDate(rs.getString(3));
				pvo.setLock(rs.getString(4));
				pvo.setReply(rs.getInt(6));
				pvo.setUserVO(vo);
				list.add(pvo);
			}
		} finally {
			closeAll(rs, pstmt, con);
		}
		return list;
	}

	// 제목으로 검색
	public ArrayList<NamiyaPostVO> readPostByTitle(String keyword, PagingBean pagingBean) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<NamiyaPostVO> list = new ArrayList<NamiyaPostVO>();
		try {
			con = dataSource.getConnection();
			StringBuilder sql = new StringBuilder();
			sql.append("select p.p_no, p.p_title, p.p_date, p.p_lock, p.reply, p.id, u.nickname ");
			sql.append("from (select row_number() over(order by p_no desc) ");
			sql.append("rnum, p_no, p_title, p_lock, reply, id, ");
			sql.append("to_char(p_date,'yyyy.mm.dd') p_date from namiya_post where p_title like '%' || ? || '%') ");
			sql.append("p, namiya_user u where p.id=u.id and rnum ");
			sql.append("between ? and ? order by p_no desc");
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, keyword);
			pstmt.setInt(2, pagingBean.getStartRowNumber());
			pstmt.setInt(3, pagingBean.getEndRowNumber());
			rs = pstmt.executeQuery();
			while (rs.next()) {
				NamiyaPostVO pvo = new NamiyaPostVO();
				pvo.setpNo(rs.getInt(1));
				pvo.setpTitle(rs.getString(2));
				pvo.setpDate(rs.getString(3));
				pvo.setLock(rs.getString(4));
				pvo.setReply(rs.getInt(5));
				NamiyaUserVO uvo = new NamiyaUserVO();
				uvo.setId(rs.getString(6));
				uvo.setNickName(rs.getString(7));
				pvo.setUserVO(uvo);
				list.add(pvo);
			}
		} finally {
			closeAll(rs, pstmt, con);
		}
		return list;
	}// method

	// 작성자로 검색
	public ArrayList<NamiyaPostVO> readPostByNickName(String keyword, PagingBean pagingBean) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<NamiyaPostVO> list = new ArrayList<NamiyaPostVO>();
		try {
			con = dataSource.getConnection();
			StringBuilder sql = new StringBuilder();
			sql.append("select p.p_no, p.p_title, p.p_date, p.p_lock, p.reply, p.id, u.nickname ");
			sql.append("from (select row_number() over(order by p_no desc) ");
			sql.append("rnum, p_no, p_title, p_lock, reply, u.id, ");
			sql.append("to_char(p_date,'yyyy.mm.dd') p_date from namiya_post n, namiya_user u ");
			sql.append("where n.id=u.id and u.nickname=?) p, ");
			sql.append("namiya_user u where p.id=u.id and rnum ");
			sql.append("between ? and ? order by p_no desc");
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, keyword);
			pstmt.setInt(2, pagingBean.getStartRowNumber());
			pstmt.setInt(3, pagingBean.getEndRowNumber());
			rs = pstmt.executeQuery();
			while (rs.next()) {
				NamiyaPostVO pvo = new NamiyaPostVO();
				pvo.setpNo(rs.getInt(1));
				pvo.setpTitle(rs.getString(2));
				pvo.setpDate(rs.getString(3));
				pvo.setLock(rs.getString(4));
				pvo.setReply(rs.getInt(5));
				NamiyaUserVO uvo = new NamiyaUserVO();
				uvo.setId(rs.getString(6));
				uvo.setNickName(rs.getString(7));
				pvo.setUserVO(uvo);
				list.add(pvo);
			}
		} finally {
			closeAll(rs, pstmt, con);
		}
		return list;
	}// method

	// 글 내용으로 검색
	public ArrayList<NamiyaPostVO> readPostByContent(String keyword, PagingBean pagingBean) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<NamiyaPostVO> list = new ArrayList<NamiyaPostVO>();
		try {
			con = dataSource.getConnection();
			StringBuilder sql = new StringBuilder();
			sql.append("select p.p_no, p.p_title, p.p_date, p.p_lock, p.reply, p.id, u.nickname, p.p_content ");
			sql.append("from (select row_number() over(order by p_no desc) ");
			sql.append("rnum, p_no, p_title, p_lock, reply, id, p_content, ");
			sql.append("to_char(p_date,'yyyy.mm.dd') p_date from namiya_post where p_content like '%' || ? || '%') ");
			sql.append("p, namiya_user u where p.id=u.id and rnum ");
			sql.append("between ? and ? order by p_no desc");
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, keyword);
			pstmt.setInt(2, pagingBean.getStartRowNumber());
			pstmt.setInt(3, pagingBean.getEndRowNumber());
			rs = pstmt.executeQuery();
			while (rs.next()) {
				NamiyaPostVO pvo = new NamiyaPostVO();
				pvo.setpNo(rs.getInt(1));
				pvo.setpTitle(rs.getString(2));
				pvo.setpDate(rs.getString(3));
				pvo.setLock(rs.getString(4));
				pvo.setReply(rs.getInt(5));
				NamiyaUserVO uvo = new NamiyaUserVO();
				uvo.setId(rs.getString(6));
				uvo.setNickName(rs.getString(7));
				pvo.setUserVO(uvo);
				list.add(pvo);
			}
		} finally {
			closeAll(rs, pstmt, con);
		}
		return list;
	}// method

	public int getSearchPostCount(String category, String keyword) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int count = 0;
		try {
			con = dataSource.getConnection();
			if (category.equals("제목")) {
				sql = "select count(*) from namiya_post where p_title like '%' || ? || '%'";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, keyword);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					count = rs.getInt(1);
				}
			} else if (category.equals("작성자")) {
				sql = "select count(*) from namiya_post p , namiya_user u where p.id=u.id and u.nickname=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, keyword);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					count = rs.getInt(1);
				}
			} else {
				sql = "select count(*) from namiya_post where p_content like '%' || ? || '%'";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, keyword);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					count = rs.getInt(1);
				}
			}
		} finally {
			closeAll(rs, pstmt, con);
		}
		return count;
	}

	public int getUserCount() throws SQLException {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int count=0;
		try {
			con=dataSource.getConnection();
			String sql="select count(*) from namiya_user where MONTHS_BETWEEN(to_char(sysdate,'yyyymmdd'),to_char(logindate,'yyyymmdd'))>36";
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				count=rs.getInt(1);
			}
		}finally {
			closeAll(rs, pstmt, con);
		}
		return count;
	}
	
	//알림 관련 
	public int getUnreadAnswerCount(String id) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int count=0;
		try {
			con = dataSource.getConnection();
			StringBuilder sql = new StringBuilder();
			sql.append("select count(*) ");
			sql.append("from (select p_no, p.id from namiya_post p, namiya_user u ");
			sql.append("where p.id=u.id and u.id = ? ) p, ");
			sql.append("namiya_answer a where p.p_no = a.p_no and a.readRe=0");
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
			}
		} finally {
			closeAll(rs, pstmt, con);
		}
		return count;
	}// method
	
	//댓글 읽음 여부 확인
	public void readComment(int pNo) throws SQLException {
		Connection con=null;
		PreparedStatement pstmt=null;
		try {
			con=dataSource.getConnection();
			String sql="UPDATE namiya_answer SET readRe = '1' WHERE  p_no = ?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, pNo);
			pstmt.executeUpdate();
		}finally {
			closeAll(pstmt, con);
		}
	}//method
}