<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
Connection conn = null;
PreparedStatement pstmt = null;

String url = "jdbc:mysql://localhost/test?autoReconnect=true&useUnicode=true&characterEncoding=utf8";
String id = "test";
String pw = "test123";

try {
	Class.forName("com.mysql.jdbc.Driver");
	conn = DriverManager.getConnection(url, id, pw);
	
} catch (Exception ex) {
	ex.printStackTrace();
	out.println("<h1>DB에 연결하지 못했습니다.</h1>");
	return;
}

request.setCharacterEncoding("UTF-8");
String name = request.getParameter("name");
String contents = request.getParameter("contents");

if (name == null || name.length() == 0) {
	out.println("<h1>이름을 입력해 주세요. - 브라우저의 뒤로가기 버튼을 이용하여 입력화면으로 이동 할 수 있습니다.</h1>");
	return;
}

String sql = "";
sql = "INSERT INTO board (`name`, `contents`, `reg_dt`) VALUES (?, ?, NOW())";
pstmt = conn.prepareStatement(sql);
pstmt.setString(1, name);
pstmt.setString(2, contents);

pstmt.executeUpdate();

response.sendRedirect("/SimpleBoard/");
%>
