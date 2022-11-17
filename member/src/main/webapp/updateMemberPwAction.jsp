<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.net.URLEncoder"%>
<%@ page import = "vo.*"%>
<%
	request.setCharacterEncoding("utf-8");
	//1
	if(session.getAttribute("loginMemberId") == null){
		//로그인 되지 않은 상태
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}

	// 안전장치
	if(request.getParameter("memberPw") == null || request.getParameter("updatePw") == null || request.getParameter("memberPw").equals("") || request.getParameter("updatePw").equals("")){
		response.sendRedirect(request.getContextPath()+"/updateMemberPwForm.jsp");
		return;
	}
	
	String loginMemberId = (String)(session.getAttribute("loginMemberId"));
	String memberPw = request.getParameter("memberPw");
	String updatePw = request.getParameter("updatePw");
	System.out.println(loginMemberId+"<-loginMemberId");
	System.out.println(memberPw+"<-PASSWORD");
	System.out.println(updatePw+"<-NEWPASSWORD");
	// 2
	String driver = "org.mariadb.jdbc.Driver";
	String dbUrl = "jdbc:mariadb://localhost:3306/gdj58";
	String dbUser = "root";
	String dbPw = "java1234";
	Class.forName(driver);
	Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPw);
	System.out.println(conn+"<-Connection");

	String sql = "UPDATE member SET member_pw = PASSWORD(?) WHERE member_id = ? AND member_pw = PASSWORD(?)"; // 비밀번호 변경 쿼리문
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setString(1, updatePw);
	stmt.setString(2, loginMemberId);
	stmt.setString(3, memberPw);
	
	int row = stmt.executeUpdate();
	System.out.println(row);
	
	if(row == 1){
		String msg = URLEncoder.encode("비밀번호 변경이 완료되었습니다.","utf-8");
		response.sendRedirect(request.getContextPath()+"/memberOne.jsp?msg="+msg);
		System.out.println("PW변경 성공");
	}else {
		String msg = URLEncoder.encode("비밀번호가 일치하지 않습니다.","utf-8");
		response.sendRedirect(request.getContextPath()+"/updateMemberPwForm.jsp?msg="+msg);
		System.out.println("PW변경 실패");
	}
	
%>
