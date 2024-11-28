<%--JSP 페이지에 대한 정보를 page 디렉티브의 속성들을 사용하여 정의하였습니다. --%>
<%--JSP 페이지가 생성할 문서의 타입을 아래와 같이 지정하였습니다. --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>

<%-- 웹 브라우저에서 서버로 넘어오는 파라미터 값에 한글이 있는 경우, 한글 깨짐을 방지합니다.(post 방식)--%>
<%request.setCharacterEncoding("utf-8");%>

<%-- request 내장객체의 getParameter() 메소드를 사용하여 프로퍼티 값을 읽어옵니다. --%>
<%
String user_id = request.getParameter("user_id");
String user_pw = request.getParameter("user_pw");
String user_nick = request.getParameter("user_nick");
String user_email = request.getParameter("user_email");
String user_com = request.getParameter("user_com");
String user_sex = request.getParameter("user_sex");

Connection conn = null;
PreparedStatement pstmt = null;
String str = "";

/*예외 처리 부분입니다.*/
try {
	/*연동할 DB를 포함한 url입니다.*/
	String jdbcUrl = "jdbc:mariadb://localhost:3306/coolworld";

	/*사용자 계정과 패스워드입니다.*/
	String dbId = "root";
	String dbPass = "root";

	Class.forName("org.mariadb.jdbc.Driver");	 /*DriverManager에 등록합니다.*/
	conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);	/*Connection 객체를 얻어옵니다.*/

	String sql = "insert into USER (user_id, user_pw, user_nick, user_email, user_com, user_sex) values (?,?,?,?,?,?)";	/*위치홀더(?) 번호에 해당되는 필드의 데이터 타입은 문자열입니다.*/
	pstmt = conn.prepareStatement(sql);	/*sql이 실행할 쿼리문입니다.*/

	/*PrepareStatement 객제가 제공하는 setString 메소드입니다.*/
	pstmt.setString(1, user_id);
	pstmt.setString(2, user_pw);
	pstmt.setString(3, user_nick);
	pstmt.setString(4, user_email);
	pstmt.setString(5, user_com);
	pstmt.setString(6, user_sex);

	pstmt.executeUpdate();

	str = "회원 등록이 완료되었습니다";

}
catch (Exception e) {
	e.printStackTrace();
	str = "회원 등록에 실패했습니다";
}
finally {
	if (pstmt != null)
		try {
			pstmt.close();
		} catch (SQLException sqle) {}
	if (conn != null)
		try {
			conn.close();
		} catch (SQLException sqle) {}
}
%>

<html>
<head>
<title>레코드 추가</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- style 태그를 적용하였습니다. -->
<style>
	.container {
		width: 25vw;
		text-align: left;
		border: 5px solid gray;
		border-radius: 20px;
	}
</style>
</head>

<body>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<h2 style="text-align: center; margin-top: 8%; font-family:BernhardFashion BT; font-weight: bold;;">Cafe_in</h2>
	<div class="container" style="position: absolute; top: 25%; left: 37%;">
		<div style="text-align: center;">
			<img src="resources/img/coffee.png" alt="이미지">
		</div>
		<h5 align="center" style="margin-top: 4%;"><%=str%></h5>
		<button type="button" class="btn btn-primary" style="width: 99%; color: white; background-color: red; margin: 3% auto; border: none;" onclick="location.href='로그인' ">완료</button>
	</div>
</body>
</html>