package finalPj.update;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import work.crypt.SHA256;
import work.crypt.BCrypt;

public class UpdateDBBean {
	private static UpdateDBBean instance = new UpdateDBBean();
    
	public static UpdateDBBean getInstance() {
		return instance;
	}
	    
	private UpdateDBBean() {}
		
    // 커네션 풀 사용  
	
	private Connection getConnection() throws Exception {
		Context initCtx = new InitialContext();
		Context envCtx = (Context) initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource)envCtx.lookup("jdbc/basicjsp");
		return ds.getConnection();
	}
	
	// member테이블의 내용을 얻어내며, cryptProcessList.jsp 페이지에서 사용
	// 여기서 부터 작성 
	
	@SuppressWarnings("resource")
	public List<UpdateDataBean> getMembers() throws Exception {
	    Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<UpdateDataBean> memberList = null;
		int x = 0;
		try{
			conn = getConnection();
			
			pstmt = conn.prepareStatement("select count(*) from pj_member");
	        rs = pstmt.executeQuery();
	        
	        if(rs.next()) x = rs.getInt(1);
			
		    pstmt = conn.prepareStatement(
		    		  "select userId, userPw from pj_member");      
		    rs = pstmt.executeQuery();
		    
		    if(rs.next()) {
		    	memberList = new ArrayList<UpdateDataBean>(x);
		    	do{
		    		UpdateDataBean pj_member = new UpdateDataBean();
		    		pj_member.setUserId(rs.getString("userId"));	            
		    		pj_member.setUserPw(rs.getString("userPw"));
		            memberList.add(pj_member);
				}while(rs.next());
			}
		}catch(Exception e) {
		    e.printStackTrace();
		} finally {
		    if (rs != null) try{ rs.close(); }catch(SQLException ex) {}
		    if (pstmt != null) try{ pstmt.close(); }catch(SQLException ex) {}
		    if (conn != null) try{ conn.close(); }catch(SQLException ex) {}
		}
		return memberList;
	}
	// 여기까지 작성
	
    // member테이블의 비밀번호를 알괄적으로 암호화해서 저장하며, 
	// cryptProcess.jsp에서 사용
	
	// 여기서 부터 작성
    public void updateMember() {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs= null;
        
        // SHA-256를 사용하는 SHA256클래스의 객체를 얻어낸다.
        SHA256 sha = SHA256.getInsatnce();
        
        try {
            conn = getConnection();
            
            pstmt = conn.prepareStatement(
                	"select userId,userPw from pj_member");
            rs = pstmt.executeQuery();
            
            while(rs.next()){
            	String userId = rs.getString("userId");
            	String orgPass = rs.getString("userPw");
            	
            	// SHA256클래스의 getSha256()메소드를 사용해 
            	// 원래의 비밀번호를 SHA-256방식으로 암호화
            	String shaPass = sha.getSha256(orgPass.getBytes());
            	
            	// SHA-256방식으로 암호화된 값을 다시 BCrypt클래스의 
            	// hashpw()메소드를 사용해서 bcrypt방식으로 암호화
            	// BCrypt.gensalt()메소드는 salt값을 난수를 사용해 생성.
            	String bcPass = BCrypt.hashpw(shaPass, BCrypt.gensalt());
            	
            	pstmt = conn.prepareStatement(
                        "update pj_member set userPw=? where userId=?");
                pstmt.setString(1, bcPass);
                pstmt.setString(2, userId);
                pstmt.executeUpdate();
            }
        } catch(Exception ex) {
            ex.printStackTrace();
        } finally {
        	if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }
}
// 여기까지 작성 