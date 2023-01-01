<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder"%>
<%
	request.setCharacterEncoding("UTF-8");
	// 1 요청분석
	if(session.getAttribute("loginMemberId") == null){
		//로그인 되지 않은 상태
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}

	// 안전장치
	if(request.getParameter("memberName") == null || request.getParameter("memberPw") == null || request.getParameter("memberName").equals("") || request.getParameter("memberPw").equals("")){
		response.sendRedirect(request.getContextPath()+"/updateMemberForm.jsp");
		return;
	}

	String loginMemberId = (String)(session.getAttribute("loginMemberId"));
	String memberName = request.getParameter("memberName");
	String memberPw = request.getParameter("memberPw");
	
	// 2 요청처리
	String driver = "org.mariadb.jdbc.Driver";
	String dbUrl = "jdbc:mariadb://localhost:3306/gdj58";
	String dbUser = "root";
	String dbPw = "java1234";
	Class.forName(driver);
	Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPw);
	System.out.println(conn+"<-connection");
	
	
	String sql = "UPDATE member SET member_name = ? WHERE member_id = ? AND member_pw = PASSWORD(?)"; // 닉네임변경 쿼리문
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setString(1, memberName);
	stmt.setString(2, loginMemberId);
	stmt.setString(3, memberPw);
	
	int row = stmt.executeUpdate();
	if(row == 1){
		String msg = URLEncoder.encode("닉네임 변경이 완료되었습니다.","utf-8");
		response.sendRedirect(request.getContextPath()+"/memberOne.jsp?msg="+msg);
		System.out.println("닉네임변경 성공");
	}else {
		String msg = URLEncoder.encode("비밀번호가 일치하지 않습니다.","utf-8");
		response.sendRedirect(request.getContextPath()+"/updateMemberForm.jsp?msg="+msg);
		System.out.println("닉네임변경 실패");
	}
	
%>