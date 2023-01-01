package dao;

import java.sql.*;
import java.util.*;
import util.*;


public class CashDao {
	// 호출 : cashList.jsp (월별)
	public ArrayList<HashMap<String, Object>> selectCashListByMonth(String memberId, int year, int month) throws Exception {
		
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String,Object>>();
		
		// DB연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 쿼리문
		String sql = "SELECT c.cash_no cashNo, c.cash_date cashDate, c.cash_price cashPrice, c.category_no categoryNo, ct.category_kind categoryKind, ct.category_name categoryName FROM cash c INNER JOIN category ct ON c.category_no = ct.category_no WHERE c.member_id = ? AND YEAR(c.cash_date) = ? AND MONTH(c.cash_date) = ? ORDER BY c.cash_date ASC, ct.category_kind ASC";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberId);
		stmt.setInt(2, year);
		stmt.setInt(3, month);
		//System.out.println(month+"cashlistmonth");
		
		ResultSet rs = stmt.executeQuery();
		//System.out.println(rs+"<-rs실행여부1");
		
		while(rs.next()) {// true일시 
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("cashNo", rs.getInt("cashNo"));
			m.put("cashDate", rs.getString("cashDate"));
			m.put("cashPrice", rs.getLong("cashPrice"));
			m.put("categoryNo", rs.getInt("categoryNo"));
			m.put("categoryKind", rs.getString("categoryKind"));
			m.put("categoryName", rs.getString("categoryName"));
			list.add(m);
		}
		rs.close();
		stmt.close();
		conn.close();
		return list;
	}
	// 호출 : cashDateList.jsp (일별)
	public ArrayList<HashMap<String, Object>> selectCashListByDate(String memberId, int year, int month, int date) throws Exception {
		
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		// DB연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 쿼리문
		String sql = "SELECT c.cash_no cashNo, c.cash_date cashDate, c.cash_price cashPrice, c.cash_memo cashMemo, c.category_no categoryNo, ct.category_kind categoryKind, ct.category_name categoryName, c.updatedate, c.createdate FROM cash c INNER JOIN category ct ON c.category_no = ct.category_no WHERE c.member_id = ? AND YEAR(c.cash_date) = ? AND MONTH(c.cash_date) = ? AND DAY(c.cash_date) = ? ORDER BY c.cash_date ASC, ct.category_kind ASC"; 
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberId);
		stmt.setInt(2, year);
		stmt.setInt(3, month);
		stmt.setInt(4, date);
		
		ResultSet rs = stmt.executeQuery();
		//System.out.println(rs+"<-rs실행여부");
		//System.out.println(rs.next()+"<-rsnext");
		
		while(rs.next()) { // true일시 
			HashMap<String, Object> m = new HashMap<String, Object>();
			//System.out.println(rs.getInt("cashNo")+"<-cashNo"); 
			m.put("cashNo", rs.getInt("cashNo"));
			m.put("cashDate", rs.getString("cashDate"));
			//System.out.println(rs.getString("cashDate")+"<-cashDate"); 
			m.put("cashPrice", rs.getLong("cashPrice"));
			//System.out.println(rs.getLong("cashPrice")+"<-cashPrice");
			m.put("cashMemo", rs.getString("cashMemo"));
			m.put("categoryNo", rs.getInt("categoryNo"));
			m.put("categoryKind", rs.getString("categoryKind"));
			m.put("categoryName", rs.getString("categoryName"));
			m.put("updatedate", rs.getString("updatedate"));
			m.put("createdate", rs.getString("createdate"));
			list.add(m);
		}
		rs.close();
		stmt.close();
		conn.close();
		return list;
	}
	
	// 호출 : insertCashAction.jsp
	public int insertCash(String memberId, String cashMemo, String cashDate, int categoryNo, long cashPrice) throws Exception {
			
		int icResult = 0;
		
		// DB연결	
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 쿼리문
		String sql = "INSERT INTO cash (member_id, cash_memo, cash_date, category_no, cash_price, updatedate, createdate) VALUES(?,?,?,?,?,CURDATE(),CURDATE())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberId);
		stmt.setString(2, cashMemo);
		stmt.setString(3, cashDate); 
		stmt.setInt(4, categoryNo);
		stmt.setLong(5, cashPrice);
		
		icResult = stmt.executeUpdate();
			
		stmt.close();
		conn.close();
		return icResult;
		}

	// 호출 : updateCashAction.jsp
	// 해당 캐시번호 자료 보기
		public HashMap<String, Object> selectCashListByCashNo(int cashNo) throws Exception{
			HashMap<String, Object> map = new HashMap<>();
			
			DBUtil dbUtil = new DBUtil();
			Connection conn = dbUtil.getConnection();
			String sql = "SELECT cash_no cashNo, cash_date cashDate, cash_price cashPrice, category_no categoryNo, cash_memo cashMemo \r\n"
					+ "FROM cash\r\n"
					+ "WHERE cash_no = ?";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, cashNo);
			
			ResultSet rs = stmt.executeQuery();
			if(rs.next()) {
				map.put("cashNo", cashNo);
				map.put("cashDate", rs.getString("cashDate"));
				map.put("cashPrice", rs.getLong("cashPrice"));
				map.put("categoryNo", rs.getInt("categoryNo"));
				map.put("cashMemo", rs.getString("cashMemo"));
			}
			return map;
		}
		
		// 수정
		public int updateCashList(int categoryNo, long cashPrice, String cashMemo, int cashNo, String memberId) throws Exception{
			int row = 0; 

			DBUtil dbUtil = new DBUtil();
			Connection conn = dbUtil.getConnection();
			
			String sql = "UPDATE cash\r\n"
					+ "SET category_no = ?\r\n"
					+ "	, cash_price = ?\r\n"
					+ "	, cash_memo = ?\r\n"
					+ "	, updatedate = CURDATE()\r\n"
					+ "WHERE cash_no = ? AND member_id = ?";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, categoryNo);
			stmt.setLong(2, cashPrice);
			stmt.setString(3, cashMemo);
			stmt.setInt(4, cashNo);
			stmt.setString(5, memberId);
			
			// 성공하면 row = 1
			row = stmt.executeUpdate();
			return row;

		}
		
		// 삭제
		public int deleteCash(int cashNo) throws Exception{
			int row = 0;
			
			DBUtil dbUtil = new DBUtil();
			Connection conn = dbUtil.getConnection();
			String sql = "DELETE FROM cash WHERE cash_no = ?";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, cashNo);
			
			// 성공하면 row = 1
			row = stmt.executeUpdate();
			return row;
		}
}