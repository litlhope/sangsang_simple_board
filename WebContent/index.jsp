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
/* DB 컨넥션을 위해서는 Connection Interface가 필요합니다. */
Connection conn = null;
Statement stmt = null;

/*
 * DB 컨넥션 정보입니다.
 * jdbc:mysql://localhost/test 까지 필요합니다.
 * test는 database 이름입니다.
 */
String url = "jdbc:mysql://localhost/test?autoReconnect=true&useUnicode=true&characterEncoding=utf8";
String id = "test";
String pw = "test123";

try {
	/* 
	 * DB Driver로 mysql Driver를 이용합니다. 
	 * 이곳의 Driver 클래스명을 변경함으로써 Oracle DB, MSSql 등을 사용 할 수 있습니다.(이론적으로는...)
	 */
	Class.forName("com.mysql.jdbc.Driver");
	conn = DriverManager.getConnection(url, id, pw);
	stmt = conn.createStatement();
} catch (Exception ex) {
	ex.printStackTrace();
	out.println("<h1>DB에 연결하지 못했습니다.</h1>");
	return;
}

/* SELECT 결과를 받기 위해서는 ResultSet이 필요합니다.*/
ResultSet rset = null;
ArrayList<Board> boardList = new ArrayList<Board>();
/* ResultSet을 직관(?)적으로 사용 할 수 있도록 Board(Model - 이것은 차후에 설명합니다.)를 이용합니다. */
Board board = null;

String sql = "";

sql = "SELECT id, name, contents, reg_dt FROM board ORDER BY reg_dt DESC";
/* executeQuery는 SELECT를 위한 메소드입니다. 뒤에 executeUpdate도 살펴봅니다. */
rset = stmt.executeQuery(sql);
/* ResultSet은 아래와 같은 패턴으로 이용 할 수 있습니다. */
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