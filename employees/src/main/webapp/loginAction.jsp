<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.Employee"%>
<%@ page import = "java.sql.*"%>
<%
	// 1 controller
	// session 유효성 검증 코드 후 필요하다면 redirect	
	// request 유효성 검증
	int empNo = Integer.parseInt(request.getParameter("empNo"));
	String firstName = request.getParameter("firstName");
	String lastName = request.getParameter("lastName");
	
	// VO setter 호출
	Employee employee = new Employee();
	employee.setEmpNo(empNo);
	employee.setFirstName(firstName);
	employee.setLastName(lastName);

	// 2 model
	String driver	= "org.mariadb.jdbc.Driver";
	String dbUrl	= "jdbc:mariadb://localhost:3306/employees";
	String dbUser	= "root";
	String dbPw		= "java1234";
	
	Class.forName(driver); // 외부 드라이브 로딩
	Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPw); // db 연결
	System.out.println(conn+"<-connection!");
	
	/*
		SELECT emp_no empNo last_name lastName FROM employee 
		WHERE emp_no = ? AND fisrt_name = ? AND last_name = ?
	*/
	String sql = "SELECT emp_no empNo, last_name lastName FROM employees WHERE emp_no =? AND first_name =? AND last_name=?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	// getter 사용
	stmt.setInt(1, employee.getEmpNo());
	stmt.setString(2, employee.getFirstName());
	stmt.setString(3, employee.getLastName());
	
	ResultSet rs = stmt.executeQuery();
	String targetUrl = "/loginForm.jsp";
	if(rs.next()){
		// 로그인 성공
		Employee loginEmp = new Employee();
		loginEmp.setEmpNo(rs.getInt("empNo"));
		loginEmp.setLastName(rs.getString("lastName"));
		// Object 타입은 모든 참조타입의 조상격 
		session.setAttribute("loginEmp", loginEmp); // 키: "loginEmp(문자열)" 값: loginEmp 안에 empNo,lastName 들어있음 -> Object object = loginEmp;
		targetUrl = "/empIndex.jsp";
	} 
	
	rs.close();
	stmt.close();
	conn.close();
	response.sendRedirect(request.getContextPath()+targetUrl);
	
	
	// view가 여기선 없으므로 redirect로 마무리
	// 3 view

%>