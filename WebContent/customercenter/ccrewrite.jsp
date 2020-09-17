<%@page import="ccboard.CCBoardBean"%>
<%@page import="ccboard.CCBoardDAO"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	request.setCharacterEncoding("utf-8");
	
	int num = Integer.parseInt(request.getParameter("num"));
	String id = (String)session.getAttribute("id");
	if(id == null) id="";
	
	CCBoardDAO ccBoardDAO = new CCBoardDAO();
	CCBoardBean boardBean = ccBoardDAO.getBoard(num);
	
	if(!id.equals(boardBean.getId())) {
%>
		<script>
			alert("작성자만 수정 가능합니다.");
			history.back();
		</script>
<%
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" type="text/css" href="/JSPProject/css/inc/top.css">
<link rel="stylesheet" type="text/css" href="/JSPProject/css/inc/bottom.css">
<link rel="stylesheet" type="text/css" href="/JSPProject/css/font.css">
<link rel="stylesheet" type="text/css" href="/JSPProject/css/customercenter/ccwrite.css">
<title>고객센터</title>
</head>
<body>
	<jsp:include page="/inc/top.jsp"/>
	<div id="wrap">
		<h1>문의하기</h1>
		<form action="ccrewritePro.jsp" method="post">
			<input type="hidden" name="num" value=<%=num %>>
			<table>
				<tr>
					<th>글 제목</th>
					<td><input type="text" name="subject" id="subject" class="textBox" value=<%=boardBean.getSubject() %>></td>
					<th>글 비밀번호</th>
					<td><input type="password" name="pw" id="pw" class="textBox" value=<%=boardBean.getPw() %> style="background-color:#f9f9f9;" readonly="readonly"></td>
				</tr>
				<tr>
					<th style="vertical-align: top;">글 내용</th>
					<td colspan="3"><textarea id="content" name="content" class="textBox"><%=boardBean.getContent() %></textarea></td>
				</tr>
			</table>
			<div id="submit_btn">
				<br>
				<%
				if(boardBean.getSecret() == 1) {
				%>
					<input type="checkbox" id="secret" name="secret" checked="checked">&nbsp;체크시 비밀글로 작성합니다.
				<%
				} else {
				%>
					<input type="checkbox" id="secret" name="secret">&nbsp;체크시 비밀글로 작성합니다.
				<%
				}
				%>
				<br>
				<input type="submit" class="btn" value="작성하기">
				<input type="reset" class="btn" value="초기화">
				<input type="button" class="btn" value="돌아가기" onclick="history.back();">
			</div>
		</form>
	</div>
	<jsp:include page="/inc/bottom.jsp"/>
</body>
</html>