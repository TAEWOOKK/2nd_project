package kr.co.ezen;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Vector;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BookingDAO {
	Connection conn;
	PreparedStatement pstmt;
	ResultSet rs;
	
	public void getConnection() {
		
		try{
			Context initctx = new InitialContext();
			DataSource ds = (DataSource) initctx.lookup("java:comp/env/jdbc/OracleDB");
			
			conn = ds.getConnection();
		}
		catch(Exception e){
			e.printStackTrace();
		}
	}
	//selectBooking() : 회원 예약정보를 조회하기
	public Vector<BookingVO> selectBooking(int x){
		
		Vector<BookingVO> v = new Vector<>();
		String sql = null;
		try {
			getConnection();//DB연결 시도			
		if(x==1) {													// = Admin.
			sql  = "select * from  skibooking order by id, rdate DESC";
		} else if(x==2) {											// = User
			sql  = "select * from SkiBooking where (CURRENT_DATE-1 <= TO_DATE(bdate, 'YYYY-MM-DD')) ORDER BY bdate ASC";
				
		}
		pstmt = conn.prepareStatement(sql);
		
		rs = pstmt.executeQuery();
		
		while(rs.next()) {
			
			BookingVO bkBean = new BookingVO();
			
			bkBean.setId(rs.getString("id"));// 1			
//			bkBean.setBdate(rs.getString("bdate").substring(0,10));
			bkBean.setBdate(rs.getString("bdate"));
			bkBean.setBcheck(rs.getString("bcheck"));
//			bkBean.setRdate(rs.getString("rdate").substring(0,10));
			bkBean.setRdate(rs.getString("rdate"));
		
			v.add(bkBean);//벡터에서 mBean의 내용을 참조 하도록 설정합니다.
		}			
		
		}catch(Exception e) {
			e.printStackTrace();
		} finally {
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

	
	//insertBooking(BookingVO bvo): 예약 table에 data input
	public void insertBooking(String id , String bdate) {
		
		
		try {
			getConnection();

			String sql = "insert into skibooking values(?,?,'O',to_char(sysdate, 'yyyy-MM-dd HH24:mi:SS'))";
			
			pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, id);
				pstmt.setString(2, bdate);
			pstmt.executeUpdate();
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
		}
	}
	
	public int selectCountBooking(String dayoneString) throws SQLException {
		getConnection();
		int x = 0;
		try {
			
			String sql = "select count(*) from skibooking where bcheck='O' and bdate=?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dayoneString);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				x = rs.getInt(1);
			
			}
			
		}
		catch(Exception e) {
			e.printStackTrace();
		} 
		finally {
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
		return x;
	}

	

	
	public int selectIdDateBooking(String userid,String date) {
		getConnection();
		int x = 0;
		try {
			
			String sql = "select * from skibooking where id =? and bdate =?";
		
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			pstmt.setString(2, date);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				x=1;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		} 
		finally {
			//나중에 사용한 오브젝트를 먼저 closed 해준다
			if(rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if(conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		return x;
	}
	
	//cancelBooking(id, bdate): id에 해당하는 내용을 반환 
	public BookingVO cancelBooking(String id, String bdate){
		getConnection();
		BookingVO bvo = new BookingVO();
		String sql;
		
		try {
			String check = "select bcheck from skibooking where id=? and bdate=?";
			pstmt = conn.prepareStatement(check);
			pstmt.setString(1,  id);
			pstmt.setString(2,  bdate);
			
			rs = pstmt.executeQuery();
			
			String checks = null;
			if(rs.next()) {
				checks = rs.getString(1);
			}
			
			if(checks.equals("X") || checks.equals("x")) {
				sql = "update skibooking set bcheck='O' where id=? and bdate=?";
			}else {
				sql = "update skibooking set bcheck='X' where id=? and bdate=?";
			}
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, bdate);
			pstmt.executeUpdate();
		}
		catch(Exception e) {
			e.printStackTrace();
		} 
		finally {
			//나중에 사용한 오브젝트를 먼저 closed 해준다
			if(rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if(conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		return bvo;
	}
	
	//deleteBooking(id, bdate): id에 해당하는 내용을 반환 
	public BookingVO deleteBooking(String id, String bdate){
		getConnection();
		BookingVO bvo = new BookingVO();
		String sql;
		
		try {
			sql = "delete from skibooking where id=? and bdate=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, bdate);
			
			pstmt.executeUpdate();
		}
		catch(Exception e) {
			e.printStackTrace();
		} 
		finally {
			//나중에 사용한 오브젝트를 먼저 closed 해준다
			if(rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if(conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		return bvo;
	}
	
	// 예약현황
	public Map<Integer, Integer> getBookingCountByDate(int year, int month) {
        Map<Integer, Integer> bookingCountByDate = new HashMap<Integer, Integer>();

        try {
            getConnection();

            String sql = "SELECT bdate, COUNT(*) AS count FROM skibooking WHERE bdate BETWEEN ? AND ? and bcheck='O' GROUP BY bdate";
            pstmt = conn.prepareStatement(sql);

            // 시작일과 종료일 계산
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Calendar cal = Calendar.getInstance();
            cal.set(Calendar.YEAR, year);
            cal.set(Calendar.MONTH, month - 1);
            cal.set(Calendar.DATE, 1);
            String start_date_str = sdf.format(cal.getTime());
            cal.add(Calendar.MONTH, 1);
            cal.add(Calendar.DATE, -1);
            String end_date_str = sdf.format(cal.getTime());

            // 매개변수 설정
            pstmt.setString(1, start_date_str);
            pstmt.setString(2, end_date_str);

            rs = pstmt.executeQuery();

            while (rs.next()) {
                // 예약일자 문자열을 Date 객체로 변환
                Date bookingDate = sdf.parse(rs.getString("BDATE"));

                // Date 객체에서 일(day) 값을 추출하여 bookingCountByDate 맵에 저장
                int day = bookingDate.getDate();
                int count = rs.getInt("count");
                bookingCountByDate.put(day, count);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ParseException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (pstmt != null) {
                    pstmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return bookingCountByDate;
    }
}
