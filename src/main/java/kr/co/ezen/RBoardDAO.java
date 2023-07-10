package kr.co.ezen;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class RBoardDAO {

	Connection conn;
	PreparedStatement pstmt;
	ResultSet rs;
	
	
	//DB 연결 정보 설정 부분.(Connection Pool 버전)
	public void getConnection() {
				
			
		try{
			Context initctx = new InitialContext();
			DataSource ds = (DataSource) initctx.lookup("java:comp/env/jdbc/OracleDB");
					
			conn = ds.getConnection();
					
				
		}catch(Exception e){
			e.printStackTrace();
		}
				
	}
	
	
	
	//insertBoard(RBVO);
	public void insertBoard(RBoardVO RBVO) {
		
		getConnection();
		
		try {
			
			int ref = 0;
			int ref_step = 1;
			int ref_level = 1;
			
			
			String sql = "select max(ref) from SkiReview";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				ref = rs.getInt(1) + 1;
				
				
			}
			
			String sql2 = "insert into SkiReview values(SkiReview_seq.nextval, ?, ?, sysdate,  "
					+ " ?,?,?,?)";
		
			pstmt = conn.prepareStatement(sql2);
			
			pstmt.setString(1, RBVO.getTitle());
			pstmt.setString(2, RBVO.getWriter());
			pstmt.setString(3, RBVO.getDetails());
			pstmt.setInt(4, ref);
			pstmt.setInt(5, ref_step);
			pstmt.setInt(6, ref_level);
						
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				
			}
			if(conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				
			}
		}
		
		
	}
	//selectBoard(startRow, endRow); 모든 게시판글 조회하기
		public Vector<RBoardVO> selectBoard(int startRow, int endRow) {
			
			Vector<RBoardVO> v = new Vector<>();

			try {
			getConnection();//DB연결 시도
				
				//최신글 가져오기: Rnum 이용
			String sql = "select * from (select A.*, Rownum Rnum from(select * from SkiReview where ref_step=1 order by numb desc)A)"
							+ "where rnum >=? and rnum <=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			
			
			
			rs = pstmt.executeQuery();
			

			while(rs.next()) {
				
				RBoardVO RBVO = new RBoardVO();
				
				RBVO.setNumb(rs.getInt(1));//1 = 테이블순서
				RBVO.setTitle(rs.getString(2));
				RBVO.setWriter(rs.getString(3));
				RBVO.setWdate(rs.getString(4).substring(0,10));
				RBVO.setDetails(rs.getString(5).toString());
				RBVO.setRef(rs.getInt(6));
				RBVO.setRef_step(rs.getInt(7));
				RBVO.setRef_level(rs.getInt(8));
				
				
				
				v.add(RBVO);//벡터에서 bBean의 내용을 참조 하도록 설정합니다
			}
			}catch(Exception e){
				e.printStackTrace();
			}finally {
				if(rs != null) {
					try {
						rs.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
					
				}
				if(pstmt != null) {
					try {
						pstmt.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
					
				}
				if(conn != null) {
					try {
						conn.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
					
				}
			}
			
			return v;
		}
		
		
		
		
		
				//REselectBoard2(startRow, endRow); 모든 댓글 조회하기, 10개씩묶기
				public Vector<RBoardVO> REselectBoard(int Ref, int startRow, int endRow) {
					
					Vector<RBoardVO> v = new Vector<>();

					try {
					getConnection();//DB연결 시도
						
						//최신글 가져오기: Rnum 이용
					String sql = "select * from (select A.*, Rownum Rnum from(select * from SkiReview where ref=? and ref_step>1 order by numb asc)A)"
									+ "where rnum >=? and rnum <=?";
					pstmt = conn.prepareStatement(sql);
					
					pstmt.setInt(1, Ref);
					pstmt.setInt(2, startRow);
					pstmt.setInt(3, endRow);
					
					
					
					rs = pstmt.executeQuery();
					

					while(rs.next()) {
						
						RBoardVO RBVO = new RBoardVO();
						
						RBVO.setNumb(rs.getInt(1));//1 = 테이블순서
						RBVO.setTitle(rs.getString(2));
						RBVO.setWriter(rs.getString(3));
						RBVO.setWdate(rs.getString(4).substring(0,10));
						RBVO.setDetails(rs.getString(5).toString());
						RBVO.setRef(rs.getInt(6));
						RBVO.setRef_step(rs.getInt(7));
						RBVO.setRef_level(rs.getInt(8));
						
						
						
						v.add(RBVO);//벡터에서 bBean의 내용을 참조 하도록 설정합니다
					}
					}catch(Exception e){
						e.printStackTrace();
					}finally {
						if(rs != null) {
							try {
								rs.close();
							} catch (SQLException e) {
								e.printStackTrace();
							}
							
						}
						if(pstmt != null) {
							try {
								pstmt.close();
							} catch (SQLException e) {
								e.printStackTrace();
							}
							
						}
						if(conn != null) {
							try {
								conn.close();
							} catch (SQLException e) {
								e.printStackTrace();
							}
							
						}
					}
					
					return v;
				}
	
		//oneselectBoard(numb)
		public RBoardVO oneselectBoard(int numb) {
			
			RBoardVO RBVO = new RBoardVO();
			
			try {
				getConnection();//DB연결 시도
				
							
				
				String sql = "select * from SkiReview where numb = ?"; 
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, numb);//id를 가지고 찾기
				
				rs = pstmt.executeQuery();
				
				
				
				
				if(rs.next()) {
					
					RBVO.setNumb(rs.getInt("numb"));//1 = 테이블순서
					RBVO.setTitle(rs.getString("title"));
					RBVO.setWriter(rs.getString("writer"));
					RBVO.setWdate(rs.getString(4).substring(0,10));
					RBVO.setDetails(rs.getString(5));
					RBVO.setRef(rs.getInt(6));
					RBVO.setRef_step(rs.getInt(7));
					RBVO.setRef_level(rs.getInt(8));
					
				}
				}catch(Exception e){
					e.printStackTrace();
				}finally {
					if(rs != null) {
						try {
							rs.close();
						} catch (SQLException e) {
							e.printStackTrace();
						}
						
					}
					if(pstmt != null) {
						try {
							pstmt.close();
						} catch (SQLException e) {
							e.printStackTrace();
						}
						
					}
					if(conn != null) {
						try {
							conn.close();
						} catch (SQLException e) {
							e.printStackTrace();
						}
						
					}
				}		
			
			return RBVO;
		}
	
		
		//rewriteBoard(bBean); 댓글쓰기 구현
		public void rewriteBoard(RBoardVO RBVO) {
			 
			
			getConnection();
			
			try {
				int ref = RBVO.getRef();
				int ref_step = RBVO.getRef_step();
				int ref_level = RBVO.getRef_level();
				
				
				
				//기존 참조한 글보다 더 큰 값을 줍니다. ref_level을 1증가 시킵니다.
				String sql = "update SkiReview set ref_level = ref_level + 1 where ref=? and ref_level > ?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, ref);
					pstmt.setInt(2, ref_level);
					
					pstmt.executeUpdate();
					
								
			//댓글에 대한 데이터 저장
				String sql2 = "insert into SkiReview values(SkiReview_seq.nextval, ?, ?, sysdate, "
								+ " ?,?,?,?)";
						
					pstmt = conn.prepareStatement(sql2);
							
					pstmt.setString(1,  RBVO.getTitle());
					pstmt.setString(2, RBVO.getWriter());
					pstmt.setString(3, RBVO.getDetails());
					pstmt.setInt(4, ref);
					pstmt.setInt(5, ref_step + 1);
					pstmt.setInt(6, ref_level + 1);
										
					pstmt.executeUpdate();
					
				
				
			}catch(Exception e) {
				e.printStackTrace();
				
			}finally {
				if(rs != null) {
					try {
						rs.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
					
				}
				if(pstmt != null) {
					try {
						pstmt.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
					
				}
				if(conn != null) {
					try {
						conn.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
					
				}
			}
			
			
			
			
		}
		
		//getUpdateBoard(num): num에 해당하는 내용을 반환 
				public RBoardVO getUpdateBoard(int numb){
					
					getConnection();
					
					RBoardVO RBVO = new RBoardVO();
					
					try {
						String sql  = "select * from SkiReview where numb = ?";
						pstmt = conn.prepareStatement(sql);
						pstmt.setInt(1,  numb); 
						
						rs = pstmt.executeQuery();
						
						if(rs.next()) {
											
							RBVO.setNumb(rs.getInt("numb"));// 1			
							RBVO.setTitle(rs.getString(2));
							RBVO.setWriter(rs.getString("writer"));
							RBVO.setWdate(rs.getString(4).toString());
							RBVO.setDetails(rs.getString(5));
							RBVO.setRef(rs.getInt(6));
							RBVO.setRef_step(rs.getInt(7));
							RBVO.setRef_level(rs.getInt(8));
						}						
					
					
					}catch(Exception e) {
						e.printStackTrace();
					}finally {
						if(rs != null) {
							try {
								rs.close();
							} catch (SQLException e) {
								e.printStackTrace();
							}
						}
						if(pstmt != null) {
							try {
								pstmt.close();
							} catch (SQLException e) {
								e.printStackTrace();
							}
						}
						if(conn != null) {
							try {
								conn.close();
							} catch (SQLException e) {
								e.printStackTrace();
							}
						}			
					}				
					return RBVO;
					
				}
		
		
		//boardUpdate(bBean) : 데이터 수정
		public void updateBoard(RBoardVO RBVO) {
		
			try {
			getConnection();//DB연결 시도
			
			String sql = "update SkiReview set TITLE=?, DETAILS=? where numb = ?";
			
			pstmt = conn.prepareStatement(sql);
			
			
			
			pstmt.setString(1, RBVO.getTitle());
			pstmt.setString(2, RBVO.getDetails());
			pstmt.setInt(3, RBVO.getNumb());
			
			pstmt.executeUpdate();	
			
			
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(pstmt != null) {
					try {
						pstmt.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
					
				}
				if(conn != null) {
					try {
						conn.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
					
				}
				
			}
			
			
		}
		
		
		//deleteBoard(numb) : 데이터 삭제 처리 구현
				public void deleteBoard(int numb, int ref) {
				
					try {
					getConnection();//DB연결 시도
					
					String sql = "delete from SkiReview where numb=? or ref=?";
					
					pstmt = conn.prepareStatement(sql);
					
					pstmt.setInt(1, numb);
					pstmt.setInt(2, ref);
					
					
					pstmt.executeUpdate();
					
					
					}catch(Exception e) {
						e.printStackTrace();
					}finally {
						
						if(pstmt != null) {
							try {
								pstmt.close();
							} catch (SQLException e) {
								e.printStackTrace();
							}
							
						}
						if(conn != null) {
							try {
								conn.close();
							} catch (SQLException e) {
								e.printStackTrace();
							}
							
						}
						
					}
					
					
				}
				
				
				//deleteBoard(numb) : 데이터 삭제 처리 구현
				public void RedeleteBoard(int numb) {
				
					try {
					getConnection();//DB연결 시도
					
					String sql = "delete from SkiReview where numb=?";
					
					pstmt = conn.prepareStatement(sql);
					
					pstmt.setInt(1, numb);
					
					
					pstmt.executeUpdate();
					
					
					}catch(Exception e) {
						e.printStackTrace();
					}finally {
						
						if(pstmt != null) {
							try {
								pstmt.close();
							} catch (SQLException e) {
								e.printStackTrace();
							}
							
						}
						if(conn != null) {
							try {
								conn.close();
							} catch (SQLException e) {
								e.printStackTrace();
							}
							
						}
						
					}
					
					
				}
				
	
				

				
			//getAllCount(); 전체 후기글의 갯수 구하기
			public int getAllCount() {
				
				getConnection();
				
				int count = 0;
				
				try {
					
					
					String sql = "select count(*) from SkiReview where ref_step=1";
					
					
					pstmt = conn.prepareStatement(sql);
					
					rs = pstmt.executeQuery();
					
					if(rs.next()) {
						
						count = rs.getInt(1);
						
					}	
					}catch(Exception e) {
						e.printStackTrace();
					}finally {
						if(rs != null) {
						try {
							rs.close();
						} catch (SQLException e) {
							e.printStackTrace();
						}
					}
						
						if(pstmt != null) {
							try {
								pstmt.close();
							} catch (SQLException e) {
								e.printStackTrace();
							}
							
						}
						if(conn != null) {
							try {
								conn.close();
							} catch (SQLException e) {
								e.printStackTrace();
							}
							
						}
						
					}
				return count;
					
					
					
					
					
					
				}
				
			
			//getAllCount2(); 전체 댓글 갯수 구하기
			public int getAllCount2(int ref) {
				
				getConnection();
				
				int count = 0;
				
				try {
					
					
					String sql = "select count(*) from SkiReview where ref=? and ref_step > 1";
					
					
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, ref);
								
					rs = pstmt.executeQuery();
					
					if(rs.next()) {
						
						count = rs.getInt(1);
						
					}	
					}catch(Exception e) {
						e.printStackTrace();
					}finally {
						if(rs != null) {
						try {
							rs.close();
						} catch (SQLException e) {
							e.printStackTrace();
						}
					}
						
						if(pstmt != null) {
							try {
								pstmt.close();
							} catch (SQLException e) {
								e.printStackTrace();
							}
							
						}
						if(conn != null) {
							try {
								conn.close();
							} catch (SQLException e) {
								e.printStackTrace();
							}
							
						}
						
					}
				return count;
					
					
					
					
					
					
				}
					
			//getAllReview(); 후기글 리스트 구현
			public int getAllReview(int ref) {
				
				getConnection();
				
				int count = 0;
				
				try {
					
					
					String sql = "select count(*) from SkiReview where ref=? and ref_step>1";
	
					
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, ref);
					rs = pstmt.executeQuery();
					
					if(rs.next()) {
						
						count = rs.getInt(1);
						
					}	
					}catch(Exception e) {
						e.printStackTrace();
					}finally {if(rs != null) {
						try {
							rs.close();
						} catch (SQLException e) {
							e.printStackTrace();
						}
					}
						
						if(pstmt != null) {
							try {
								pstmt.close();
							} catch (SQLException e) {
								e.printStackTrace();
							}
							
						}
						if(conn != null) {
							try {
								conn.close();
							} catch (SQLException e) {
								e.printStackTrace();
							}
							
						}
						
					}
				return count;
					
					
					
					
					
					
				}
				
				

			// prevSelectBoard(num) 이전페이지 구현
			public RBoardVO prevSelectBoard(int numb) {
				
				RBoardVO rbVO = new RBoardVO();
				try {
					getConnection();
					int numb2 = 0;
					
					String sql = "select * from (select numb, lag(numb) over (order by rownum) numb_prev from SkiReview where ref_step=1)where numb=?";
						pstmt = conn.prepareStatement(sql);
						pstmt.setInt(1, numb);
					rs = pstmt.executeQuery();
					if(rs.next()) {
						numb2 = rs.getInt("numb_prev");
					}
					
					String sql2 = "select title,numb from SkiReview where numb=?";
						pstmt = conn.prepareStatement(sql2);
						pstmt.setInt(1, numb2);
					rs = pstmt.executeQuery();
					while(rs.next()) {

						rbVO.setTitle(rs.getString("title"));
						rbVO.setNumb(rs.getInt("numb"));
					}
				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					try { if(rs != null) rs.close(); } catch (SQLException e) {}
					try { if(pstmt != null) pstmt.close(); } catch (SQLException e) {}
					try { if(conn != null) conn.close(); } catch (SQLException e) {}
				}
				
				return rbVO;
			}
			
			
			
			
			
			// nextSelectBoard(num) 다음페이지 구현
			public RBoardVO nextSelectBoard(int numb) {
				
				RBoardVO rbVO = new RBoardVO();
				try {
					getConnection();
					int numb2 = 0;
					
					String sql = "select * from (select numb, lead(numb) over (order by rownum) numb_next from SkiReview where ref_step=1)where numb=?";
						pstmt = conn.prepareStatement(sql);
						pstmt.setInt(1, numb);
					rs = pstmt.executeQuery();
					if(rs.next()) {
						numb2 = rs.getInt("numb_next");
					}
					
					String sql2 = "select title, numb from SkiReview where numb=? ";
						pstmt = conn.prepareStatement(sql2);
						pstmt.setInt(1, numb2);
					rs = pstmt.executeQuery();
					while(rs.next()) {

						rbVO.setTitle(rs.getString("title"));
						rbVO.setNumb(rs.getInt("numb"));
					}
				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					try { if(rs != null) rs.close(); } catch (SQLException e) {}
					try { if(pstmt != null) pstmt.close(); } catch (SQLException e) {}
					try { if(conn != null) conn.close(); } catch (SQLException e) {}
				}
				
				return rbVO;
			}
			
			
			
			
			
			
			
			
				
				
				
				
			
				
}
