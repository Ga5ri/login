<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*"%>
<%@ page import = "vo.*"%>
<%
	request.setCharacterEncoding("UTF-8");
	// 1 요청분석
	String memberId = request.getParameter("member_id");
	String memberPw = request.getParameter("member_pw");
	String newPw = request.getParameter("newPw");
	System.out.println(memberPw+"<--password");
	System.out.println(newPw+"<--newpassword");
	
	// 2 요청처리
	String driver	= "org.mariadb.jdbc.Driver";
	String dbUrl	= "jdbc:mariadb://localhost:3306/gdj58";
	String dbUser	= "root";
	String dbPw		= "java1234";
	
	Class.forName(driver); // 외부 드라이브 로딩
	Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPw); // db 연결
	System.out.println(conn+"<--conncetion");
	
	String sql = "UPDATE member SET member_pw = PASSWORD(?) WHERE member_id = ? AND member_pw = PASSWORD(?)";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setString(1, newPw);
	stmt.setString(2, memberId);
	stmt.setString(3, memberPw);

	int row = stmt.executeUpdate();
	System.out.println(row);
	
	if(row == 1){
		response.sendRedirect(request.getContextPath()+"/memberOne.jsp");
		System.out.println("변경성공");
	} else{
		response.sendRedirect(request.getContextPath()+"/updateMemberPwForm.jsp");
		System.out.println("변경실패");
	}	
	/*
	UPDATE MEMBER 
	SET member_pw = PASSWORD('0000')
	WHERE member_id='guest' AND member_pw = PASSWORD('1234')
	*/
	
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