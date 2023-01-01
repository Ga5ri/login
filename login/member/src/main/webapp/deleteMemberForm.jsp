<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*"%>
<%@ page import = "java.util.*"%>
<%@ page import = "vo.*"%>
<%
	
	// 1 요청분석
	String msg = request.getParameter("msg");
	request.setCharacterEncoding("UTF-8");
	if(session.getAttribute("loginMemberId") == null){
		//로그인 되지 않은 상태
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	// 2 요청처리
	String driver	= "org.mariadb.jdbc.Driver";
	String dbUrl	= "jdbc:mariadb://localhost:3306/gdj58";
	String dbUser	= "root";
	String dbPw		= "java1234";
	
	Class.forName(driver); // 외부 드라이브 로딩
	Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPw); // db 연결
	System.out.println(conn+"<--connection");
	
	String sql = "SELECT * FROM member WHERE member_id = ?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setString(1, (String)session.getAttribute("loginMemberId"));
	ResultSet rs = stmt.executeQuery();
	
	Member m = new Member();
	if(rs.next()){
		m.memberId = rs.getString("member_id");
		m.memberName = rs.getString("member_name");
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
			<h1 class="text-center p-3">회원 탈퇴</h1>
			<form action="<%=request.getContextPath()%>/deleteMemberAction.jsp" method="post">
				<table class="table">
					<tr>
						<td>닉네임</td>
						<td><input type="text" name="memberName" value="<%=m.memberName%>" readonly="readonly"></td>
					</tr>
					<tr>
						<td>아이디</td>
						<td><input type="text" name="memberId" value="<%=m.memberId%>" readonly="readonly"></td>
					</tr>
					<tr>
						<td>비밀번호 확인</td>
						<td>
							<input type="password" name="memberPw">
							<%
								if(msg != null){	
							%>
									<span><%=msg%></span>
							<%		
								}
							%>
						</td>
					</tr>
				</table>
				<div class="d-grid p-3">
					<button type="submit" class="btn btn-danger">회원 탈퇴</button>
				</div>
			</form>
		</div>
	</body>
</html>