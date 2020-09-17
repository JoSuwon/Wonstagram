<%@page import="ccboard.CCBoardBean"%>
<%@page import="ccboard.CCBoardDAO"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	request.setCharacterEncoding("utf-8");

	String id = (String)session.getAttribute("id");
	if(id == null) {
		id = "";
	}
	
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	if(pageNum == null) {
		pageNum = "1";
	}
	CCBoardDAO ccBoardDAO = new CCBoardDAO();
	ccBoardDAO.updateReadCount(num);
	CCBoardBean boardBean = ccBoardDAO.getBoard(num);
	String mainId = boardBean.getMain_id();
	
	String DBContent = "";
	
	if(boardBean.getContent() != null) {
		DBContent = boardBean.getContent().replace("\r\n", "<br/>");
	}
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" type="text/css" href="/JSPProject/css/inc/top.css">
<link rel="stylesheet" type="text/css" href="/JSPProject/css/inc/bottom.css">
<link rel="stylesheet" type="text/css" href="/JSPProject/css/font.css">
<link rel="stylesheet" type="text/css" href="/JSPProject/css/customercenter/cccontent.css">
<title>고객센터</title>
<script>
	function goList() {
		location.href = "/JSPProject/customercenter/customercenter.jsp?pageNum=" + <%=pageNum%>;
	}
	
	function updateBoard() {
		location.href = "/JSPProject/customercenter/ccrewrite.jsp?num=" + <%=num%>;
	}
	
	function deleteBoard() {
		location.href = "/JSPProject/customercenter/deleteBoard.jsp?num=" + <%=num%>;
	}
	function reply() {
		location.href = "/JSPProject/customercenter/ccreply.jsp?num=" + <%=num%> + "&mainId=<%=mainId%>"; 
	}
</script>
</head>
<body>
	<jsp:include page="/inc/top.jsp"/>
	<div id="wrap">
		<h1>문의내용</h1>
		<table>
			<tr>
				<th>글 제목</th>
				<td colspan="3"><%=boardBean.getSubject() %></td>
			</tr>
			<tr>
				<th>작성자</th>
				<td><%=boardBean.getId() %></td>
				<th>작성일</th>
				<td><%=boardBean.getDate().toString().substring(0,19) %></td>
			</tr>
			<tr>
				<th style="vertical-align: top;">글 내용</th>
				<td colspan="3"><%=DBContent %></td>
			</tr>
		</table><br>
		<input type="button" value="목록보기" class="btn" onclick="goList();">
		<input type="button" value="수정하기" class="btn" onclick="updateBoard();">
		<input type="button" value="삭제하기" class="btn" onclick="deleteBoard();">
		<%
		if(id.equals("admin")) {
		%>
			<input type="button" value="답글쓰기" class="btn" onclick="reply();">
		<%
		}
		%>
		
	</div>
	<jsp:include page="/inc/bottom.jsp"/>
</body>
</html>