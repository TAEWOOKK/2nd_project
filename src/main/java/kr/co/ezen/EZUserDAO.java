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

import kr.co.ezen.EZUserVO;
public class EZUserDAO {



	//전역적인 공간에 선언
	Connection conn;
	PreparedStatement pstmt;
	ResultSet rs;
	
	
	/*//DB 연결 정보 설정 부분.
	public Connection getConnection() {
		
		String Driver = "oracle.jdbc.OracleDriver";
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		String pass = "1234";
		String uid = "hun";
		
		
		try{
			Class.forName(Driver);
			conn = DriverManager.getConnection(url, uid, pass);
		
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return conn;		
	}
	*/
	
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

		//id 중복체크
		public String getid(String id) {
			getConnection();

			
			String checkid = null;
			try {
				String sql="select * from skiuser where id = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, id);
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					checkid=rs.getString(1);	
				}
				
			}
			catch(Exception e){
				e.printStackTrace();
			}
			finally {
				if(pstmt != null) {
					try {
						pstmt.close();
					} 
					catch (SQLException e) {
						e.printStackTrace();
					}
				}
				if(conn != null) {
					try {
						conn.close();
					} 
					catch (SQLException e) {
						e.printStackTrace();
					}
				}
				if(rs != null) {
					try {
						rs.close();
					} 
					catch (SQLException e) {
						e.printStackTrace();
					}
				}
			}
			return checkid;
		}
		
		//회원가입
		public void signUp(EZUserVO eVo) throws Exception { // 호출한 곳으로 예외처리 전환
			
			getConnection();
			
			try {
				
				String sql = "insert into skiuser(id, pwd, name, sex, birth, tel, city, email, edate) values(?, ?, ?, ?, ?, ?, ?, ?, sysdate)";
				
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1, eVo.getId());
				pstmt.setString(2, eVo.getPwd());
				pstmt.setString(3, eVo.getName());
				pstmt.setString(4, eVo.getSex());
				pstmt.setString(5, eVo.getBirth());
				pstmt.setString(6, eVo.getTel());
				pstmt.setString(7, eVo.getCity());
				pstmt.setString(8, eVo.getEmail());	
				
				pstmt.executeUpdate();		
				
			}catch(SQLException e) {
				e.printStackTrace();
				System.out.println(" 회원정보 생성 SQL 처리중 예외처리가 발생하였습니다.  " +  e.getClass().getName() + ": " + e.getMessage());
				throw e;			
			
			}catch(Exception e) {
				e.printStackTrace();
				System.out.println(" 회원정보 생성 처리중 예외처리가 발생하였습니다.  " +  e.getClass().getName() + ": " + e.getMessage());
				throw e;
			
				
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
		}// 회원가입 end
		
		// getPwd(id) : 아이디 체크루틴 & 로그인 실행 화면 내 비밀번호 확인 
		public String getPwd(String id) throws Exception {
			
			String pwd = null;
			
			try {
				getConnection();
				
				String sql = "select pwd from skiuser where id =?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, id);
				rs = pstmt.executeQuery();
				
				if (rs.next()) {
					pwd = rs.getString(1);
				}
			}catch (Exception e) {
				e.printStackTrace();
			}finally {
				if(pstmt != null) {
					pstmt.close();
				}
				if(conn != null) {
					conn.close();
				}
			}
		return pwd;
			
		}// 비밀번호 확인 end
		
		// getutype(id) : 로그인 실행 화면 내 utype 확인 
		public String getUtype(String id) throws Exception {
			
			String utype = null;
			
			try {
				getConnection();
				
				String sql = "select utype from skiuser where id =?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, id);
				rs = pstmt.executeQuery();
				
				if (rs.next()) {
					utype = rs.getString(1);
				}
			}catch (Exception e) {
				e.printStackTrace();
			}finally {
				if(pstmt != null) {
					pstmt.close();
				}
				if(conn != null) {
					conn.close();
				}
			}
		return utype;
			
		}// utype 확인 end
				
	//oneselectMember(String id);
		public EZUserVO oneselectskiuser(String id) throws Exception {
				
			EZUserVO evo = new EZUserVO();
				
			try {
				//DB연결 
				getConnection();			
				
				String sql = "select * from  skiuser where id=?";
					
				pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, id);
				rs = pstmt.executeQuery();
						
				if(rs.next()) {
					evo.setId(rs.getString("id"));//불러우는 순서
					evo.setName(rs.getString("name"));
					evo.setEmail(rs.getString("email"));
				}
					
			} catch(Exception e) {
				e.printStackTrace();
				//throw e;
					
			} finally {
				//나중에 사용한 오브젝트를 먼저 closed 해준다
				if(rs != null) {
					rs.close();
				}
				if(pstmt != null) {
					pstmt.close();
				}
				if(conn != null) {
					conn.close();
				}
			}
				
			return evo;
				
		}
		

	// selectUser start! -------------------ALL 회원 정보 얻기 ------------------- 2023.03.10 add
	public Vector<EZUserVO> selectUser() throws Exception {
		
		Vector<EZUserVO> v = new Vector<>();
		
		/*
		private String id;
		private String pwd;
		private String name;
		private String sex;
		private String birth;
		private String tel;
		private String city;
		private String email;
		private String utype;
		private String edate;
		*/	
		
		
		try {
			getConnection();  // DB connect try
			
			String sql = "select * from SKIUSER order by edate desc";
	
			//String sql = "select id, name, email, tele, hobby, job, age, info from campingmember order by id";
	
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			/*
			private String id;
			private String pwd;
			private String name;
			private String sex;
			private String birth;
			private String tel;
			private String city;
			private String email;
			private String utype;
			private String edate;
			*/
			
			
			while (rs.next()) {
				
				EZUserVO ezuVO = new EZUserVO();
								
				ezuVO.setId(rs.getString("id")); 
				ezuVO.setPwd(rs.getString("pwd")); 	 //우선 화면으로 출력  나중에 지우자			
				ezuVO.setName(rs.getString("name"));
				ezuVO.setSex(rs.getString("sex"));
				ezuVO.setBirth(rs.getString("birth"));
				ezuVO.setTel(rs.getString("tel")); 
				ezuVO.setCity(rs.getString("city")); 				
				ezuVO.setEmail(rs.getString("email")); 
				ezuVO.setUtype(rs.getString("utype")); 
				ezuVO.setEdate(rs.getString("edate").toString());
				// ezuVO.setEdate(rs.getString("edate")); 
				
				v.add(ezuVO);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
			//throw e;
			
		} finally {
			
			if(rs != null) {
				try {
					pstmt.close();
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
	// selectUser ---- //ALL 회원 정보 얻기  ended
	
	// oneselectUser(id)  start ------------------회원 정보 얻기 (1인)------------------------------------- 2023.03.10 add
	public EZUserVO oneselectUser(String id) throws Exception {
		
		EZUserVO ezu1 = new EZUserVO();
		
		try {
			getConnection();  // DB connect try
			
			String sql = "select * from SKIUSER where id = ?";

			/*
			private String id;
			private String pwd;
			private String name;
			private String sex;
			private String birth;
			private String tel;
			private String city;
			private String email;
			private String utype;
			private String edate;
			*/
			
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,  id);			
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				
				ezu1.setId(rs.getString("id")); 
				//ezu1.setPwd(rs.getString("pwd")); 	 			
				ezu1.setName(rs.getString("name"));
				ezu1.setSex(rs.getString("sex"));
				ezu1.setBirth(rs.getString("birth"));
				ezu1.setTel(rs.getString("tel")); 
				ezu1.setCity(rs.getString("city")); 				
				ezu1.setEmail(rs.getString("email")); 
				ezu1.setUtype(rs.getString("utype")); 
				ezu1.setEdate(rs.getString("edate").toString());
			}
		
		}catch(Exception e) {
			e.printStackTrace();
			//throw e;
			
		} finally {
			
			if(rs != null) {
				try {
					pstmt.close();
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

		return ezu1;		
	
	}	
	// oneselectUser(id) ---- // 회원 정보 얻기 (1인) ended
	

	
	
	

	
	// signUpChange(ezuvo) start! ---------------------MyPage 회원수정 처리 ---------------- 2023.03.10 add
	public void signUpChange(EZUserVO ezuVO) throws Exception { // 호출한 곳으로 예외처리 전환
			

		try {
			
			getConnection();  // DB connect try
			
			String sql = "update  skiuser set name=?, sex=?, birth=?,  tel=?, city=?,  email=? where id =?";
			
			pstmt = conn.prepareStatement(sql);
		
			//System.out.println(" update ezuVO.getId()==>" + ezuVO.getId());			
			
			pstmt.setString(1, ezuVO.getName());
			pstmt.setString(2, ezuVO.getSex());
			pstmt.setString(3, ezuVO.getBirth());
			pstmt.setString(4, ezuVO.getTel());
			pstmt.setString(5, ezuVO.getCity());
			pstmt.setString(6, ezuVO.getEmail());		
			pstmt.setString(7, ezuVO.getId()); // 검색

			pstmt.executeUpdate();	
			
		
		}catch(SQLException e) {
			e.printStackTrace();
			System.out.println(" 회원정보 수정(마이페이지) SQL 처리중 예외처리가 발생하였습니다.  " +  e.getClass().getName() + ": " + e.getMessage());
			throw e;			
		
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println(" 회원정보 수정(마이페이지) 처리중 예외처리가 발생하였습니다.  " +  e.getClass().getName() + ": " + e.getMessage());
			throw e;
			
			
		} finally {
			
			if(rs != null) {
				try {
					pstmt.close();
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

	// signUpChange(ezuvo) ---- // MyPage 회원수정 처리  ended 

	
	// signUpChangeMgr(ezuvo) start! ------------------회원 수정 처리 (관리자용)------------------- 2023.03.10 add
	public void signUpChangeMgr(EZUserVO ezuVO) throws Exception { // 호출한 곳으로 예외처리 전환
			
			
		try {
			
			getConnection();  // DB connect try
			
			
			//System.out.println("산술나누기에러 유도" + 100/0);		
			
			String sql = " ";
			

			sql = "update  skiuser set name=?, sex=?, birth=?, tel=?, city=?,  email=?, utype=?  where id =?";		
	
				
			
			pstmt = conn.prepareStatement(sql);
		
			//System.out.println(" update ezuVO.getId()==>" + ezuVO.getId());			
			
			pstmt.setString(1, ezuVO.getName());
			pstmt.setString(2, ezuVO.getSex());
			pstmt.setString(3, ezuVO.getBirth());
			pstmt.setString(4, ezuVO.getTel());
			pstmt.setString(5, ezuVO.getCity());
			pstmt.setString(6, ezuVO.getEmail());
			pstmt.setString(7, ezuVO.getUtype());			
			pstmt.setString(8, ezuVO.getId()); // 검색

			pstmt.executeUpdate();	
			
		}catch(SQLException e) {
			e.printStackTrace();
			System.out.println(" 회원정보 수정(관리자용) SQL 처리중 예외처리가 발생하였습니다.  " +  e.getClass().getName() + ": " + e.getMessage());
			throw e;			
		
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println(" 회원정보 수정(관리자용) 처리중 예외처리가 발생하였습니다.  " +  e.getClass().getName() + ": " + e.getMessage());
			throw e;
			
		} finally {
			
			if(rs != null) {
				try {
					pstmt.close();
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

	// signUpChangeMgr (ezuvo) ----// 회원 수정 처리 (관리자용)  ended  
	

	
	// signUpDelete(ezuvo) start!     -------------회원 삭제 처리 (관리자용)------------------- 2023.03.10 add	

	public void signUpDelete(EZUserVO ezuVO) throws Exception { // 호출한 곳으로 예외처리 전환
			
		try {
			
			getConnection();  // DB connect try
			
			String sql = "delete from skiuser where id =?";
			
			pstmt = conn.prepareStatement(sql);				
 
			pstmt.setString(1, ezuVO.getId());

			pstmt.executeUpdate();	
	
			
		}catch(SQLException e) {
			e.printStackTrace();
			System.out.println(" 회원정보 삭제(관리자용) SQL 처리중 예외처리가 발생하였습니다.  " +  e.getClass().getName() + ": " + e.getMessage());
			throw e;			
		
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println(" 회원정보 삭제(관리자용) 처리중 예외처리가 발생하였습니다.  " +  e.getClass().getName() + ": " + e.getMessage());
			throw e;	
		

		} finally {
			
			if(rs != null) {
				try {
					pstmt.close();
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

	// signUpDelete(ezuvo) ---- // 회원 삭제 처리 (관리자용) ended

	// signUpDelete(ezuvo) ---- // 회원 삭제 처리 (마이페이지) 
		public void signUpDelete2(String id) throws Exception  {  
			try {
				
				getConnection();  // DB connect try
				
				String sql = "delete from skiuser where id =?";
				
				pstmt = conn.prepareStatement(sql);
			
				//System.out.println(" update ezuVO.getId()==>" + ezuVO.getId());		
				

				pstmt.setString(1, id);

				pstmt.executeUpdate();	
				
			
			}catch(SQLException e) {
				e.printStackTrace();
				System.out.println(" 회원정보 탈퇴(마이페이지) SQL 처리중 예외처리가 발생하였습니다.  " +  e.getClass().getName() + ": " + e.getMessage());
				throw e;			
			
			}catch(Exception e) {
				e.printStackTrace();
				System.out.println(" 회원정보 탈퇴(마이페이지) 처리중 예외처리가 발생하였습니다.  " +  e.getClass().getName() + ": " + e.getMessage());
				throw e;	
				
				
			}finally {
				
				if(rs != null) {
					try {
						pstmt.close();
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

		// signUpDelete(ezuvo) ---- // 회원 삭제 처리 (마이페이지) ended
	
		
		// getName(id) : 아이디 활용 이름 가져오기
		public String getName(String id) throws Exception {
			
			String name = null;
			
			try {
				getConnection();
				
				String sql = "select name from skiuser where id =?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, id);
				rs = pstmt.executeQuery();
				
				if (rs.next()) {
					name = rs.getString(1);
				}
			}catch (Exception e) {
				e.printStackTrace();
				//throw e;
				
			}finally {
				if(pstmt != null) {
					pstmt.close();
				}
				if(conn != null) {
					conn.close();
				}
			}
		return name;
			
		}
	
}