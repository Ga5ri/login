<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>비밀번호 수정</h1>
	<form action="<%=request.getContextPath()%>/updateMemberPwAction.jsp" method="post">
		<table>
			<tr>
				<td>아이디 입력</td>
				<td><input type="text" name="member_id" placeholder="ID를 입력해주세요."></td>
			</tr>
			<tr>
				<td>비밀번호 입력</td>
				<td><input type="password" name="member_pw" placeholder="현재 비밀번호를 입력해주세요."></td>
			</tr>
			<tr>
				<td>변경할 비밀번호 입력</td>
				<td><input type="password" name="newPw"></td>
			</tr>
		</table>
		<div>
			<button type="submit">변경</button>
		</div>
	</form>
</body>
</html>