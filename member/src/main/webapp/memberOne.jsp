<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*"%>
<%@ page import = "java.util.*"%>
<%@ page import = "vo.*"%>
<%
	// 1 요청분석
	request.setCharacterEncoding("UTF-8");
	if(session.getAttribute("loginMemberId") == null){
		//로그인 되지 않은 상태
		response.sendRedirect(request.getContextPath()+"/memberIndex.jsp");
		return;
	}
	String memberId = request.getParameter("member_id");
	String memberName = request.getParameter("member_name");
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
</head>
<body>
	<h1>내정보</h1>
	<!-- pw 제외 내정보 보여줘야함 -->
			<table>
			<tr>
				<td>닉네임</td>
				<td><%=m.memberName%></td>
			</tr>
			<tr>
				<td>아이디</td>
				<td><%=m.memberId%></td>
			</tr>
		</table>
	<div>
		<a href="<%=request.getContextPath()%>/updateMemberPwForm.jsp">비밀번호수정</a>
		<a href="<%=request.getContextPath()%>/updateMemberForm.jsp">개인정보수정</a>
		<a href="<%=request.getContextPath()%>/deleteMemberForm.jsp">회원탈퇴</a>
	</div>
</body>
</html>