<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
	request.setCharacterEncoding("utf-8");

	// 1 요청분석
	String msg = request.getParameter("msg");
	
	if(session.getAttribute("loginMemberId") == null){
		// 로그인 안된상태일경우
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	String loginMemberId = (String)(session.getAttribute("loginMemberId"));

	// 2 요청처리
	String driver = "org.mariadb.jdbc.Driver";
	String dbUrl = "jdbc:mariadb://localhost:3306/gdj58";
	String dbUser = "root";
	String dbPw = "java1234";
	Class.forName(driver);
	Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPw);
	System.out.println(conn+"<-connection");

	String sql = "SELECT member_id memberId, member_name memberName FROM member WHERE member_id=?"; // 비밀번호 변경 쿼리문
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setString(1, loginMemberId);
	ResultSet rs = stmt.executeQuery();
	
	String loginMemberName = null;
	if(rs.next()){
		loginMemberName = rs.getString("memberName");		
	}
	
	
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
		<style>
			.b1{
				position: absolute;
				top: 100px;
				left: 40%;
				width: 20%;
				box-shadow: inset 0 0 10px skyblue, 0 0 10px black;
			}
		</style>
	</head>
	<body>
		<div class="container b1">
			<h1 class="text-center p-3">닉네임 수정</h1>
			<form action="<%=request.getContextPath()%>/updateMemberAction.jsp" method="post">
				<table class="table">
					<tr>
						<td>ID</td>
						<td><input type="text" name="memberId" value="<%=loginMemberId%>" readonly="readonly"></td>
					</tr>
					<tr>
						<td>변경할 닉네임</td>
						<td><input type="text" name="memberName"></td>
					</tr>
					<tr>
						<td>비밀번호</td>
						<td>
							<input type="password" name="memberPw">
							<%
								if(msg != null){
							%>
									 <div><%=msg%></div>
							<%
								}
							%>
						</td>
					</tr>
				</table>
				<div class="d-grid p-3">
					<button type="submit" class="btn btn-success">수정</button>
				</div>
			</form>
		</div>
	</body>
</html>