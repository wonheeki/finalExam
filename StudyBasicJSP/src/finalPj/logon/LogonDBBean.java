package finalPj.logon;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import work.crypt.SHA256;
import work.crypt.BCrypt;

public class LogonDBBean {

	// LogonDBBean 전역 객체 생성 <- 한개의 객제만 생성해서 공유
	private static LogonDBBean instance = new LogonDBBean();

	// LogonDBBean객체를 리턴하는 메소드
	public static LogonDBBean getInstance() {
		return instance;
	}

	private LogonDBBean() {
	}

	// 커넥션 풀에서 커넥션 객체를 얻어내는 메소드
	private Connection getConnection() throws Exception {
		Context initCtx = new InitialContext();
		Context envCtx = (Context) initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource) envCtx.lookup("jdbc/basicjsp");
		return ds.getConnection();
	}

	// 회원 가입 처리(registerPro.jsp)에서 사용하는 새 레코드 추가 메소드
	public void insertMember(LogonDataBean pj_member) {
		Connection conn = null;
		PreparedStatement pstmt = null;

		SHA256 sha = SHA256.getInsatnce();
		try {
			conn = getConnection();

			String orgPass = pj_member.getUserPw();
			String shaPass = sha.getSha256(orgPass.getBytes());
			String bcPass = BCrypt.hashpw(shaPass, BCrypt.gensalt());

			pstmt = conn.prepareStatement("insert into pj_member values (?,?,?,?,?,?)");
			pstmt.setString(1, pj_member.getUserId());
			pstmt.setString(2, bcPass);
			pstmt.setString(3, pj_member.getUserName());
			pstmt.setString(4, pj_member.getUserEmail());
			pstmt.setString(5, pj_member.getUserTel());
			pstmt.setTimestamp(6, pj_member.getReg_date());
			pstmt.executeUpdate();

		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException ex) {
				}
		}
	}

	// 로그인 폼 처리(loginPro.jsp)페이지의 사용자 인증 처리 및
	// 카드 정보수정/탈퇴를 사용자인증(memberCheck.jsp)에서 사용하는 메소드
	public int userCheck(String userId, String userPw) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int x = -1;

		SHA256 sha = SHA256.getInsatnce();
		try {
			conn = getConnection();

			String orgPass = userPw;
			String shaPass = sha.getSha256(orgPass.getBytes());

			pstmt = conn.prepareStatement("select userPw from pj_member where userId = ?");
			pstmt.setString(1, userId);
			rs = pstmt.executeQuery();

			if (rs.next()) {// 해당 아이디가 있으면 수행
				String dbpasswd = rs.getString("userPw");
				if (BCrypt.checkpw(shaPass, dbpasswd))
					x = 1; // 인증성공
				else
					x = 0; // 비밀번호 틀림
			} else// 해당 카드번호가 없으면 수행
				x = -1;// 카드번호 없음

		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException ex) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException ex) {
				}
		}
		return x;
	}

	// 아이디 중복 확인 (confirmId.jsp)에서 아이디의 중복 여부를 확인하는 메소드
	public int confirmId(String userId) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int x = -1;

		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select userId from pj_member where userId = ?");
			pstmt.setString(1, userId);
			rs = pstmt.executeQuery();

			if (rs.next())// 카드번호가 존재
				x = 1; // 같은 카드번호 있음
			else
				x = -1;// 같은 카드번호 없음
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException ex) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException ex) {
				}
		}
		return x;
	}

	public LogonDataBean getMember(String userId, String userPw) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		LogonDataBean pj_member = null;

		SHA256 sha = SHA256.getInsatnce();
		try {
			conn = getConnection();

			String orgPass = userPw;
			String shaPass = sha.getSha256(orgPass.getBytes());

			pstmt = conn.prepareStatement("select * from pj_member where userId = ?");
			pstmt.setString(1, userId);
			rs = pstmt.executeQuery();

			if (rs.next()) {// 해당 아이디에 대한 레코드가 존재
				String dbpasswd = rs.getString("userPw");
				// 사용자가 입력한 비밀번호와 테이블의 비밀번호가 같으면 수행
				if (BCrypt.checkpw(shaPass, dbpasswd)) {
					pj_member = new LogonDataBean();// 데이터저장빈 객체생성
					pj_member.setUserId(rs.getString("userId"));
					pj_member.setUserName(rs.getString("userName"));
					pj_member.setUserEmail(rs.getString("userEmail"));
					pj_member.setUserTel(rs.getString("userTel"));
					pj_member.setReg_date(rs.getTimestamp("reg_date"));

				}
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException ex) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException ex) {
				}
		}
		return pj_member;// 데이터 저장빈 객체 member 리턴
	}

	// 회원 정보 수정 처리(modifyPro.jsp)에서 회원 정보 수정을 처리하는 메소드
	@SuppressWarnings("resource")
	public int updateMember(LogonDataBean pj_member) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int x = -1;

		SHA256 sha = SHA256.getInsatnce();
		try {
			conn = getConnection();

			String orgPass = pj_member.getUserPw();
			String shaPass = sha.getSha256(orgPass.getBytes());

			pstmt = conn.prepareStatement("select userPw from pj_member where userId = ?");
			pstmt.setString(1, pj_member.getUserId());
			rs = pstmt.executeQuery();

			if (rs.next()) {// 해당 아이디가 있으면 수행
				String dbpasswd = rs.getString("userPw");
				if (BCrypt.checkpw(shaPass, dbpasswd)) {
					pstmt = conn.prepareStatement("update pj_member set userName=?,userEmail=?,userTel=? " + "where userId=?");
					pstmt.setString(1, pj_member.getUserName());
					pstmt.setString(2, pj_member.getUserEmail());
					pstmt.setString(3, pj_member.getUserTel());
					pstmt.setString(4, pj_member.getUserId());
					pstmt.executeUpdate();
					x = 1;// 회원정보 수정 처리 성공
				} else
					x = 0;// 회원정보 수정 처리 실패
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException ex) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException ex) {
				}
		}
		return x;
	}

	// 카드 탈퇴 처리(deletePro.jsp)에서 카드 정보를 삭제하는 메소드
	@SuppressWarnings("resource")
	public int deleteMember(String userId, String userPw) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int x = -1;

		SHA256 sha = SHA256.getInsatnce();
		try {
			conn = getConnection();

			String orgPass = userPw;
			String shaPass = sha.getSha256(orgPass.getBytes());

			pstmt = conn.prepareStatement("select userPw from pj_member where userId = ?");
			pstmt.setString(1, userId);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				String dbpasswd = rs.getString("userPw");
				if (BCrypt.checkpw(shaPass, dbpasswd)) {
					pstmt = conn.prepareStatement("delete from pj_member where userId=?");
					pstmt.setString(1, userId);
					pstmt.executeUpdate();
					x = 1;// 카드 탈퇴처리 성공
				} else
					x = 0;// 카드 원탈퇴 처리 실패
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException ex) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException ex) {
				}
		}
		return x;
	}
}