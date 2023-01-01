<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*"%>
<%@ page import = "java.sql.*"%>
<%
	// 1
	request.setCharacterEncoding("UTF-8");
	if(request.getParameter("memberId")==null 
			|| request.getParameter("memberPw")==null
			|| request.getParameter("memberId").equals("") 
			|| request.getParameter("memberPw").equals("")){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	/*
	String memberId = request.getParameter("memberId");
	String memberPw = request.getParameter("memberPw");
	*/
	
	Member member	= new Member();
	member.memberId	= request.getParameter("memberId");
	member.memberPw	= request.getParameter("memberPw");
	System.out.print(member.memberId + " <--- ID");
	System.out.print(member.memberPw + " <--- PW");
	// 2
	String driver	= "org.mariadb.jdbc.Driver";
	String dbUrl	= "jdbc:mariadb://localhost:3306/gdj58";
	String dbUser	= "root";
	String dbPw		= "java1234";
	
	Class.forName(driver); // 외부 드라이브 로딩
	Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPw); // db 연결
	System.out.println(conn+"<-connection");
	/*
		SELECT member_id memberId
		FROM MEMBER
		WHERE member_id=? AND member_pw=PASSWORD(?);
	*/
	String sql = "SELECT member_id FROM member WHERE member_id=? AND member_pw=PASSWORD(?)";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setString(1, member.memberId);
	stmt.setString(2, member.memberPw);
	ResultSet rs = stmt.executeQuery();
	
	String targetPage = "/loginForm.jsp";
	
	if(rs.next()) {
		// 로그인 성공
		System.out.println("success");
		targetPage = "/memberIndex.jsp";
		// 로그인 성공했다는 값을 저장 -> session 
		session.setAttribute("loginMemberId", rs.getString("member_id")); 
		// Object loginMemberId = rs.getString("memberId"); // 다형성
		// String loginMemberId = (String)(session.getAttribute("loginMemberId"));		
				
	}	
	rs.close();
	stmt.close();
	conn.close();
	response.sendRedirect(request.getContextPath()+targetPage);
%>