package dao;

import vo.Member;

import java.sql.*;

import util.DBUtil;

public class MemberDao {
	// login
	public Member login(Member paramMember) throws Exception {
		/*
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/cashbook", "root", "java1234");
		--> DB를 연결하는 코드(명령들)가 Dao 메서드들 거의 공통으로 중복된다.
		--> 중복되는 코드를 하나의 이름(메서드)으로 만들자
		--> 입력값과 반환값 결정해야 한다
		--> 입력값X, 반환값은 Connection타입의 결과값이 남아야한다.
		*/
		// DB연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// resultMember 초기화
		Member resultMember = null;
		
		// 쿼리문
		String sql = "SELECT member_id memberId, member_name memberName FROM member WHERE member_id = ? AND member_pw = PASSWORD(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramMember.getMemberId());
		stmt.setString(2, paramMember.getMemberPw());
		
		System.out.println("param.get실행여부"+paramMember.getMemberId());
		System.out.println("param.get실행여부"+paramMember.getMemberPw());
		ResultSet rs = stmt.executeQuery();
	
		if(rs.next()) {
			resultMember = new Member();
			resultMember.setMemberId(rs.getString("memberId"));
			resultMember.setMemberName(rs.getString("memberName"));
			System.out.println("rs실행여부");
		}
		
		rs.close();
		stmt.close();
		conn.close();
		System.out.println("resultgetMenam"+resultMember.getMemberId());
		System.out.println("resultgetMenam"+resultMember.getMemberName());
		return resultMember;
	}
	// 회원가입
	public int insert(Member paramMember) throws Exception {
		// resultRow 초기화
		int resultRow = 0;
		
		// DB연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 중복검사
		String idSql = "SELECT member_id FROM member WHERE member_id = ?";
		PreparedStatement idStmt = conn.prepareStatement(idSql);
		idStmt.setString(1, paramMember.getMemberId());
		
		ResultSet rs = idStmt.executeQuery();
		
		if(rs.next()){ // 값이 있으면 중복
			rs.close();
			idStmt.close();
		} else { // 중복된 값이 없다면 쿼리문 진행
			String sql = "INSERT INTO member(member_id, member_pw, member_name, updatedate, createdate) values(?,PASSWORD(?),?,CURDATE(),CURDATE())";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, paramMember.getMemberId());
			stmt.setString(2, paramMember.getMemberPw());
			stmt.setString(3,paramMember.getMemberName());
			resultRow = stmt.executeUpdate();
			stmt.close();			
		}
		rs.close();
		conn.close();
		return resultRow;
	}
}
