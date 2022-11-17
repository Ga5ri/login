<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@page import="java.net.URLEncoder" %>
<%
	// 1) Controller
	//session 유효성 검증 코드 후 필요하다면 redirect!
	if(session.getAttribute("loginEmp") == null){
		String msg = URLEncoder.encode("로그인해주세요", "utf-8");
 	    response.sendRedirect(request.getContextPath()+"/loginForm.jsp?msg="+msg);
 	   	return;
	}
	String search = request.getParameter("search");
	Object objLoginEmp = session.getAttribute("loginEmp");
	Employee loginEmp = (Employee)objLoginEmp;
	
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	String sort = "ASC";
	if(request.getParameter("sort") !=null && request.getParameter("sort").equals("DESC")) {
		sort = "DESC";
	}
	
	// 2) Model
	int rowPerPage = 10;
	// beginRow 알고리즘 코드
	int beginRow = (currentPage-1) * rowPerPage;
	
	// 사원목록
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/employees", "root", "java1234");	
	
	String cntSql = null;
	PreparedStatement cntStmt = null;
	if(search == null){ // null -> 전체 행
		cntSql = "SELECT COUNT(*) cnt FROM employees";
		cntStmt = conn.prepareStatement(cntSql);
	} else { // search 값에 맞는 행
		cntSql = "SELECT COUNT(*) cnt FROM employees WHERE first_name LIKE ? OR last_name LIKE ?";
		cntStmt = conn.prepareStatement(cntSql);
		cntStmt.setString(1, "%"+search+"%");
		cntStmt.setString(2, "%"+search+"%");
	}
	ResultSet cntRs=cntStmt.executeQuery();
	
	// lastPage 알고리즘 코드
	int cnt = 0;
	if(cntRs.next()){
		cnt=cntRs.getInt("cnt");
	}

	int lastPage = cnt/rowPerPage;
	if(cnt%rowPerPage != 0){
		lastPage+=1;
	}
	String listSql = null;
	PreparedStatement listStmt = null;
	if(search == null || search.equals("")){
		listSql = "SELECT emp_no empNo, first_name firstName, last_name lastName FROM employees ORDER BY first_name ASC LIMIT ?,?";
		if(sort.equals("DESC")) {
			listSql = "SELECT emp_no empNo, first_name firstName, last_name lastName FROM employees ORDER BY first_name DESC LIMIT ?,?";
		}
		listStmt = conn.prepareStatement(listSql);
		listStmt.setInt(1, beginRow);
		listStmt.setInt(2, rowPerPage);
	} else {
		listSql = "SELECT emp_no empNo, first_name firstName, last_name lastName FROM employees WHERE first_name LIKE? OR last_name LIKE? ORDER BY first_name ASC LIMIT ?,?;";
		if(sort.equals("DESC")) {
			listSql = "SELECT emp_no empNo, first_name firstName, last_name lastName FROM employees WHERE first_name LIKE? OR last_name LIKE? ORDER BY first_name DESC LIMIT ?,?;";
		}
			listStmt = conn.prepareStatement(listSql);
			listStmt.setString(1, "%"+search+"%");
			listStmt.setString(2, "%"+search+"%");
			listStmt.setInt(3, beginRow);
			listStmt.setInt(4, rowPerPage);
	}

	ResultSet listRs = listStmt.executeQuery();
	ArrayList<Employee> list = new ArrayList<Employee>();
	while(listRs.next()) {
		Employee e = new Employee();
		e.setEmpNo(listRs.getInt("empNo"));
		e.setFirstName(listRs.getString("firstName"));
		e.setLastName(listRs.getString("lastName"));
		list.add(e);
	}
	
	// 3) View
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>empList</title>
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
		<style>
		.b1{
			position: absolute;
			top:100px;
			left:300px;
			box-shadow:inset 0 0 10px gray, 0 0 10px black;
		}
		.b2{
			float: right;
		}
		table {
			text-align: center;
		}
		</style>
	</head>
<body>
	<div class="container b1">
		<div class="p-2 b2">
			<a href="<%=request.getContextPath()%>/logout.jsp" class="btn btn-outline-danger">로그아웃</a>
		</div>
		<h1 class="text-center p-3">사원목록</h1>
		<!-- 검색창 -->
		<form action="<%=request.getContextPath()%>/empList.jsp" method="post" class="p-4">
			<label for="search">성or이름 검색 : </label>
			<input type="text" name="search" id="search" value="<%=search%>">
			<button type="submit">검색</button>
		</form>
		<table class="table">
			<tr>
				<th>번호</th>
				<th>
					이름(firstName)
					<%
						if(sort.equals("ASC")) {
					%>
							<a href="<%=request.getContextPath()%>/empList.jsp?currentPage=<%=currentPage%>&sort=DESC">[내림차순]</a>				
					<%		
						} else {
					%>
							<a href="<%=request.getContextPath()%>/empList.jsp?currentPage=<%=currentPage%>&sort=ASC">[오름차순]</a>								
					<%		
						}
					%>
				</th>
				<th>
					성(lastName)
				</th>
			</tr>
			<%
				for(Employee e : list) {
			%>
					<tr>
						<td><%=e.getEmpNo()%></td>
						<td><%=e.getFirstName()%></td>
						<td><%=e.getLastName()%></td>
					</tr>
			<%
				}
			%>
		</table>
		<!-- 페이징 코드 -->
		<div class="btn-group text-center p-3">
			<%
				if(search == null){ // null -> 기존 페이징
			%>
					<a href="<%=request.getContextPath()%>/empList.jsp?currentPage=1&sort=<%=sort%>" class="btn btn-outline-secondary b2">처음</a>
					<%
						if(currentPage>1){
					%>
							<a href="<%=request.getContextPath()%>/empList.jsp?currentPage=<%=currentPage-1%>&sort=<%=sort%>" class="btn btn-outline-secondary b2">이전</a>
					<%		
						}
					%>
					<span class="b2 btn btn-outline-secondary"><%=currentPage%></span>
					<%
						if(currentPage<lastPage){
					%>
							<a href="<%=request.getContextPath()%>/empList.jsp?currentPage=<%=currentPage+1%>&sort=<%=sort%>" class="btn btn-outline-secondary b2">다음</a>
					<%		
						}
					%>
					<a href="<%=request.getContextPath()%>/empList.jsp?currentPage=<%=lastPage%>&sort=<%=sort%>" class="btn btn-outline-secondary b2">마지막</a>
			<%
				} else { // 검색어(search)에 맞춰서 페이징
			%>
					<a href="<%=request.getContextPath()%>/empList.jsp?currentPage=1&sort=<%=sort%>&search=<%=search%>&sort=<%=sort%>" class="btn btn-outline-secondary b2">처음</a>
					<%
						if(currentPage>1){
					%>
							<a href="<%=request.getContextPath()%>/empList.jsp?currentPage=<%=currentPage-1%>&sort=<%=sort%>&search=<%=search%>" class="btn btn-outline-secondary b2">이전</a>
					<%		
						}
					%>
					<span class="b2 btn btn-outline-secondary"><%=currentPage%></span>
					<%
						if(currentPage<lastPage){
					%>
							<a href="<%=request.getContextPath()%>/empList.jsp?currentPage=<%=currentPage+1%>&sort=<%=sort%>&search=<%=search%>" class="btn btn-outline-secondary b2">다음</a>
					<%		
						}
					%>
					<a href="<%=request.getContextPath()%>/empList.jsp?currentPage=<%=lastPage%>&sort=<%=sort%>&search=<%=search%>" class="btn btn-outline-secondary b2">마지막</a>
				<%
					}
				%>
		</div>
	</div>
</body>
</html>