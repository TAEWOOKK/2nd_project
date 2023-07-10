package kr.co.ezen;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import kr.co.ezen.NBoardVO;

public class NBoardDAO {
	Connection conn;
	PreparedStatement pstmt;
	ResultSet rs;
	
	public void getConnection() {	
		try {
			Context initctx = new InitialContext();
			DataSource ds = (DataSource) initctx.lookup("java:comp/env/jdbc/OracleDB");
			
			conn = ds.getConnection();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void insertBoard(NBoardVO nbVO) {
		getConnection();

		try {
			
			String sql = "insert into SKINOTICE values(numb_seq.nextval,?,?,?,sysdate,0)";
			pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, nbVO.getCat());
				pstmt.setString(2, nbVO.getTitle());
				pstmt.setString(3, nbVO.getDetails());
			pstmt.executeUpdate();	
					
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try { if(rs != null) rs.close(); } catch (SQLException e) {}
			try { if(pstmt != null) pstmt.close(); } catch (SQLException e) {}
			try { if(conn != null) conn.close(); } catch (SQLException e) {}
		}
	}
	
	
	/////
	
	// selectBoard() : 모든 게시판 정보를 조회
			public Vector<NBoardVO> selectBoard(int startRow, int endRow) {
				Vector<NBoardVO> v = new Vector<>();
				
				try {
					getConnection();
					
					String sql = "select * from (select A.*, Rownum Rnum from (select * from SKINOTICE order by numb desc, cat asc)A)"
							+ "where rnum >=? and rnum<=?";
					
					pstmt = conn.prepareStatement(sql);
						pstmt.setInt(1, startRow);
						pstmt.setInt(2, endRow);
					
					rs = pstmt.executeQuery();
					while(rs.next()) {
						NBoardVO nbVo = new NBoardVO();
						
						nbVo.setNumb(rs.getInt("numb"));
						nbVo.setCat(rs.getString("cat"));
						nbVo.setTitle(rs.getString("title"));
						nbVo.setDetails(rs.getString("details"));
						nbVo.setWdate(rs.getString("wdate").substring(0,10));
						nbVo.setWdate(rs.getString("wdate").substring(0,10));
						nbVo.setViews(rs.getInt("views"));
						
						v.add(nbVo); // 벡터에서 mBean의 내용을 참조하도록 설정
					}
				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					try { if(rs != null) rs.close(); } catch (SQLException e) {}
					try { if(pstmt != null) pstmt.close(); } catch (SQLException e) {}
					try { if(conn != null) conn.close(); } catch (SQLException e) {}
				}
				
				return v;
			}
			
			// oneSelectMember(num)
			public NBoardVO oneSelectBoard(int numb) {
				
				NBoardVO nbVO = new NBoardVO();
				try {
					getConnection();
					
					String readSql = "update skinotice set views = views+1 where numb=?";
					pstmt = conn.prepareStatement(readSql);
						pstmt.setInt(1, numb);
					pstmt.executeUpdate();
					
					String sql = "select * from skinotice where numb=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, numb);
					rs = pstmt.executeQuery();
					while(rs.next()) {
						
						nbVO.setNumb(rs.getInt("numb"));
						nbVO.setCat(rs.getString("cat"));
						nbVO.setTitle(rs.getString("title"));
						nbVO.setDetails(rs.getString("details"));
						nbVO.setWdate(rs.getString("wdate").substring(0,10));
						nbVO.setViews(rs.getInt("views"));
						
					}
				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					try { if(rs != null) rs.close(); } catch (SQLException e) {}
					try { if(pstmt != null) pstmt.close(); } catch (SQLException e) {}
					try { if(conn != null) conn.close(); } catch (SQLException e) {}
				}
				
				return nbVO;
			}
			
		/////
			// updateBoard 수ㅔ시글 수정
			public void updateBoard(NBoardVO nvVO) {
				try {
					getConnection();
					
					String sql = "update skinotice set cat=?, title=?, details=? where numb=?";
					pstmt = conn.prepareStatement(sql);
						pstmt.setString(1,nvVO.getCat());
						pstmt.setString(2,nvVO.getTitle());
						pstmt.setString(3,nvVO.getDetails());
						pstmt.setInt(4,nvVO.getNumb());
						pstmt.executeUpdate();
				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					try { if(rs != null) rs.close(); } catch (SQLException e) {}
					try { if(pstmt != null) pstmt.close(); } catch (SQLException e) {}
					try { if(conn != null) conn.close(); } catch (SQLException e) {}
				}
			}
			
			public void deleteBoard(int numb) {
				try {
					getConnection();

					String sql = "delete from skinotice where numb =?";
					pstmt = conn.prepareStatement(sql);
						pstmt.setInt(1, numb);
					pstmt.executeUpdate();
					
				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					try { if(rs != null) rs.close(); } catch (SQLException e) {}
					try { if(pstmt != null) pstmt.close(); } catch (SQLException e) {}
					try { if(conn != null) conn.close(); } catch (SQLException e) {}
				}
			}
			
			
			
			//////
			
			
			
			// getAllCount(): 전체 게시글의 갯수 구하기
			public int getAllCount() {
				
				getConnection();
				
				int count = 0;
				
				try {
					String sql = "select count(*) from skinotice";
					
					pstmt = conn.prepareStatement(sql);
					rs = pstmt.executeQuery();
					if(rs.next()) {
						count = rs.getInt(1);
					}
				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					try { if(rs != null) rs.close(); } catch (SQLException e) {}
					try { if(pstmt != null) pstmt.close(); } catch (SQLException e) {}
					try { if(conn != null) conn.close(); } catch (SQLException e) {}
				}
				
				return count;
			}
			
			public NBoardVO getNotice() {
				NBoardVO nbVO = new NBoardVO();
				getConnection();
				
				try {
					String sql = "select * from (select * from skinotice where cat='important' order by wdate desc) where rownum <=1";
					
					pstmt = conn.prepareStatement(sql);
					rs = pstmt.executeQuery();
					if(rs.next()) {
						nbVO.setTitle(rs.getString("title"));
						nbVO.setWdate(rs.getString("wdate").substring(0,10));
						nbVO.setNumb(rs.getInt("numb"));
					}
				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					try { if(rs != null) rs.close(); } catch (SQLException e) {}
					try { if(pstmt != null) pstmt.close(); } catch (SQLException e) {}
					try { if(conn != null) conn.close(); } catch (SQLException e) {}
				}
				return nbVO;
			}
			
			// prevSelectMember(num)
			public NBoardVO prevSelectBoard(int numb) {
				
				NBoardVO nbVO = new NBoardVO();
				try {
					getConnection();
					int numb2 = 0;
					
					String sql = "select * from (select numb, lag(numb) over (order by rownum) numb_prev from skinotice)where numb=?";
						pstmt = conn.prepareStatement(sql);
						pstmt.setInt(1, numb);
					rs = pstmt.executeQuery();
					if(rs.next()) {
						numb2 = rs.getInt("numb_prev");
					}
					
					String sql2 = "select title,numb from skinotice where numb=?";
						pstmt = conn.prepareStatement(sql2);
						pstmt.setInt(1, numb2);
					rs = pstmt.executeQuery();
					while(rs.next()) {

						nbVO.setTitle(rs.getString("title"));
						nbVO.setNumb(rs.getInt("numb"));
					}
				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					try { if(rs != null) rs.close(); } catch (SQLException e) {}
					try { if(pstmt != null) pstmt.close(); } catch (SQLException e) {}
					try { if(conn != null) conn.close(); } catch (SQLException e) {}
				}
				
				return nbVO;
			}
			
			// prevSelectMember(num)
			public NBoardVO nextSelectBoard(int numb) {
				
				NBoardVO nbVO = new NBoardVO();
				try {
					getConnection();
					int numb2 = 0;
					
					String sql = "select * from (select numb, lead(numb) over (order by rownum) numb_next from skinotice)where numb=?";
						pstmt = conn.prepareStatement(sql);
						pstmt.setInt(1, numb);
					rs = pstmt.executeQuery();
					if(rs.next()) {
						numb2 = rs.getInt("numb_next");
					}
					
					String sql2 = "select title, numb from skinotice where numb=?";
						pstmt = conn.prepareStatement(sql2);
						pstmt.setInt(1, numb2);
					rs = pstmt.executeQuery();
					while(rs.next()) {

						nbVO.setTitle(rs.getString("title"));
						nbVO.setNumb(rs.getInt("numb"));
					}
				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					try { if(rs != null) rs.close(); } catch (SQLException e) {}
					try { if(pstmt != null) pstmt.close(); } catch (SQLException e) {}
					try { if(conn != null) conn.close(); } catch (SQLException e) {}
				}
				
				return nbVO;
			}
}
