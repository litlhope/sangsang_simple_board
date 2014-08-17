<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="kr.heja.sample.board.simple.bean.Board"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>기본게시판</title>
</head>
<body>
<%
Connection conn = null;
Statement stmt = null;

String url = "jdbc:mysql://localhost/test?autoReconnect=true&useUnicode=true&characterEncoding=utf8";
String id = "test";
String pw = "test123";

try {
	Class.forName("com.mysql.jdbc.Driver");
	conn = DriverManager.getConnection(url, id, pw);
	stmt = conn.createStatement();
} catch (Exception ex) {
	ex.printStackTrace();
	out.println("<h1>DB에 연결하지 못했습니다.</h1>");
	return;
}

ResultSet rset = null;
ArrayList<Board> boardList = new ArrayList<Board>();
Board board = null;

String sql = "";

sql = "SELECT id, name, contents, reg_dt FROM board ORDER BY reg_dt DESC";
rset = stmt.executeQuery(sql);
while (rset.next()) {
	board = new Board();
	board.setId(rset.getInt("id"));
	board.setName(rset.getString("name"));
	board.setContents(rset.getString("contents"));
	board.setRegDt(rset.getTimestamp("reg_dt"));
	boardList.add(board);
}
%>
<form name="tranMgr" method="post" action="reg_board.jsp">
	<input type="text" name="name" value="" /><br />
	<textarea name="contents" rows="5" cols="40"></textarea>
	<button type="submit">저장</button>
</form>

<ul>
<%
if (boardList.size() == 0) {
%>
	<li>게시글이 없습니다.</li>
<%	
} else {
	for (int inx = 0; inx < boardList.size(); inx++) {
		board = boardList.get(inx);
%>
	<li><%= board.getName() %>[<%= board.getRegDt() %>]</li>
	<li><%= board.getContents() %></li>
<%
	}
}
%>
</ul>
</body>
</html>