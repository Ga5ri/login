<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*"%>
<%
	// 1
	String memberId = request.getParameter("memberId");
	String memberName = request.getParameter("memberName");
	String newName = request.getParameter("newName");
	String memberPw = request.getParameter("memberPw");
	
	// 2
	String driver = "org.mariadb.jdbc.Driver";
	String dbUrl = "jdbc:mariadb://localhost:3306/gdj58";
	String dbUser = "root";
	String dbPw = "java1234";
	Class.forName(driver);
	Connection conn=DriverManager.getConnection(dbUrl, dbUser, dbPw);
	System.out.println(conn + "<--connection");
	
	
	String sql = "UPDATE member SET member_name = ? WHERE member_name = ? AND member_pw = PASSWORD(?)";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setString(1, newName);
	stmt.setString(2, memberName);
	stmt.setString(3, memberPw);

	int row = stmt.executeUpdate();
	System.out.println(row);
	
	if(row == 1){
		response.sendRedirect(request.getContextPath()+"/memberOne.jsp");
		System.out.println("변경성공");
	} else{
		response.sendRedirect(request.getContextPath()+"/updateMemberForm.jsp");
		System.out.println("변경실패");
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