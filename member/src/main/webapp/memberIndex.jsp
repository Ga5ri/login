<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 1
	if(session.getAttribute("loginMemberId") == null) {
		//로그인 되지 않은 상태
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<div class="container">
		<table class="table">
			<tr>
				<td>
					<a href="<%=request.getContextPath()%>/memberOne.jsp"><%=(String)(session.getAttribute("loginMemberId"))%></a>님 반갑습니다.
				</td>
			</tr>
			<tr>
				<td>
					<a href="<%=request.getContextPath()%>/memberOne.jsp">내정보</a>
				</td>
			</tr>
			<tr>
				<td>
					<a href="<%=request.getContextPath()%>/logout.jsp">로그아웃</a>
				</td>
			</tr>
		</table>
	</div>
</body>
</html>