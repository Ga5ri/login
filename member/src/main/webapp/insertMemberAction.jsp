<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*"%>
<%@ page import = "java.sql.*"%>
<%@ page import="java.net.URLEncoder"%>
<%
	request.setCharacterEncoding("utf-8");
	// 1. 요청분석
	String memberId = request.getParameter("memberId");
	String memberPw = request.getParameter("memberPw");
	String memberName = request.getParameter("memberName");
	
	// 안전장치
	if(request.getParameter("memberName")==null||request.getParameter("memberName").equals("")||request.getParameter("memberId")==null
			||request.getParameter("memberId").equals("")||request.getParameter("memberPw")==null||request.getParameter("memberPw").equals("")){
		response.sendRedirect(request.getContextPath()+"/insertMemberForm.jsp");
		return;
	}
	
	// 2. 요청처리
	String driver = "org.mariadb.jdbc.Driver";
	String dbUrl = "jdbc:mariadb://localhost:3306/gdj58";
	String dbUser = "root";
	String dbPw = "java1234";
	Class.forName(driver);
	Connection conn=DriverManager.getConnection(dbUrl, dbUser, dbPw);
	System.out.println(conn + "<--connection");
	
	// 중복검사
	String idSql = "SELECT member_id FROM member WHERE member_id = ?";
	PreparedStatement idStmt = conn.prepareStatement(idSql);
	idStmt.setString(1, memberId);
	ResultSet rs = idStmt.executeQuery();
	if(rs.next()){
		String msg = URLEncoder.encode("이미 존재하는 ID입니다.","utf-8");
		response.sendRedirect(request.getContextPath()+"/insertMemberForm.jsp?msg="+msg);
		return;
	}
	
	String sql = "INSERT INTO member(member_id, member_pw, member_name) values(?,PASSWORD(?),?)";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setString(1, memberId);
	stmt.setString(2, memberPw);
	stmt.setString(3, memberName);
	
	int row = stmt.executeUpdate(); 
	
	if(row==1){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		System.out.println("회원가입성공");
	} else{
		response.sendRedirect(request.getContextPath()+"/insertMemberForm.jsp");
		System.out.println("회원가입실패");
	}	
	
	stmt.close();
	conn.close();
%>