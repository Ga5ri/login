<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 1
	String msg = request.getParameter("msg");
	if(session.getAttribute("loginMemberId") != null){
		//로그인 되지 않은 상태
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>loginForm</title>
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
			.b2 {
				float: right;
			}
		</style>
	</head>
	<body>
		<div class="container rounded b1">
			<h1 class="text-center p-2">로그인</h1>
			<%
				if(msg != null){	
			%>
					<span><%=msg%></span>
			<%		
				}
			%>
			<form action="<%=request.getContextPath()%>/loginAction.jsp" method="post">
				<table class="table table-borderless p-3">
					<tr>
						<td class="text-center">아이디</td>
						<td><input type="text" name="memberId" placeholder="ID"></td>
					</tr>
					<tr>
						<td class="text-center">비밀번호</td>
						<td><input type="password" name="memberPw" placeholder="PASSWORD"></td>
					</tr>
				</table>
				<div class="p-4">
					<a href="<%=request.getContextPath()%>/insertMemberForm.jsp" class="btn btn-primary">회원가입</a>
					<button type="submit" class="btn btn-outline-info b2">로그인</button>
					<!-- insertMemberForm.jsp, insertMamberAction.jsp -->
				</div>
			</form>
		</div>
	</body>
</html>