<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 1
	request.setCharacterEncoding("utf-8");
	if(session.getAttribute("loginMemberId") == null){
		//로그인 되지 않은 상태
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}

	String msg = request.getParameter("msg");
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
			<h1 class="text-center p-3">비밀번호 변경</h1>
			<form action="<%=request.getContextPath()%>/updateMemberPwAction.jsp" method="post">
				<table class="table">
					<tr>
						<td>현재 비밀번호</td>
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
					<tr>
						<td>변경할 비밀번호</td>
						<td>
							<input type="password" name="updatePw">
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