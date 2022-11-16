<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*"%>
<%@ page import="java.net.URLEncoder"%>
<%
	request.setCharacterEncoding("UTF-8");
	// 1
	String memberId = request.getParameter("memberId");
	String memberPw = request.getParameter("memberPw");
	
	
	// 2
	String driver	= "org.mariadb.jdbc.Driver";
	String dbUrl	= "jdbc:mariadb://localhost:3306/gdj58";
	String dbUser	= "root";
	String dbPw		= "java1234";
	
	Class.forName(driver); // 외부 드라이브 로딩
	Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPw); // db 연결
	System.out.println(conn+"<--connection");
	
	String sql = "SELECT * FROM member WHERE member_pw = PASSWORD(?)";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setString(1, memberPw);
	ResultSet rs = stmt.executeQuery();
	
	
	if(rs.next()){
		String dSql = "DELETE FROM member WHERE member_id = ?";
		PreparedStatement dStmt = conn.prepareStatement(dSql);	
		dStmt.setString(1, memberId);
		dStmt.executeUpdate();
		session.invalidate();
		
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		System.out.println("탈퇴성공");
	} else{
		String msg2 = URLEncoder.encode("비밀번호를 확인하세요.","utf-8");
		response.sendRedirect(request.getContextPath()+"/deleteMemberForm.jsp");
		System.out.println("탈퇴실패");
	}		
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>