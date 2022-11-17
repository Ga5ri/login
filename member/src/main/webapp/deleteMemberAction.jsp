<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*"%>
<%@ page import="java.net.URLEncoder"%>
<%
	request.setCharacterEncoding("UTF-8");
	// 1
	String loginMemberId = (String)(session.getAttribute("loginMemberId"));
	String memberPw = request.getParameter("memberPw");
	
	
	// 2
	String driver	= "org.mariadb.jdbc.Driver";
	String dbUrl	= "jdbc:mariadb://localhost:3306/gdj58";
	String dbUser	= "root";
	String dbPw		= "java1234";
	
	Class.forName(driver); // 외부 드라이브 로딩
	Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPw); // db 연결
	System.out.println(conn+"<--connection");
	
	String sql = "DELETE FROM member WHERE member_id = ? AND member_pw = PASSWORD(?)";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setString(1, loginMemberId);
	stmt.setString(2, memberPw);
	int row = stmt.executeUpdate();
	
	
	if(row == 1){
		String msg = URLEncoder.encode("회원탈퇴가 완료되었습니다.","utf-8");
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp?msg="+msg);
		session.invalidate();
		System.out.println("탈퇴성공");
	} else{
		String msg = URLEncoder.encode("비밀번호가 일치하지 않습니다.","utf-8");
		response.sendRedirect(request.getContextPath()+"/deleteMemberForm.jsp?msg="+msg);
		System.out.println("탈퇴실패");
	}		
%>