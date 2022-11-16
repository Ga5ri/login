<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 1
	if(session.getAttribute("loginMemberId") == null) {
		// 로그인 되지 않은 상태
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div>
		<%=(String)(session.getAttribute("loginMemberId"))%>님 반갑습니다.
		<a href="<%=request.getContextPath()%>/memberOne.jsp">내정보</a>
		<a href="<%=request.getContextPath()%>/logout.jsp">로그아웃</a>
	</div>
	<h1>멤버 페이지 입니다</h1>
</body>
</html>