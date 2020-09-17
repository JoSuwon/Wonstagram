<%@page import="ccboard.CCBoardBean"%>
<%@page import="ccboard.CCBoardDAO"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String id = (String)session.getAttribute("id");
	String mainId = request.getParameter("mainId");
	int num = Integer.parseInt(request.getParameter("num"));
	
	CCBoardDAO ccBoardDAO = new CCBoardDAO();
	CCBoardBean mainBean = ccBoardDAO.getBoard(num);
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
		<h1>답글쓰기</h1>
		<form action="ccreplyPro.jsp" method="post">
			<input type="hidden" name="re_ref" value="<%=num %>">
			<input type="hidden" name="mainId" value="<%=mainId %>">
			<table>
				<tr>
					<th>글 제목</th>
					<td><input type="text" name="subject" id="subject" class="textBox" value="<%=mainId%>님의 문의사항 답글입니다."></td>
					<th>글 비밀번호</th>
					<td><input type="password" name="pw" id="pw" class="textBox"></td>
				</tr>
				<tr>
					<th style="vertical-align: top;">글 내용</th>
					<td colspan="3">
						<textarea id="content" name="content" class="textBox"><%="문의사항 >> \n"%><%=mainBean.getContent() %><%="\n\n" %>----------------------------------------------------------------------<%="\n\n" %>답글 내용입니다 >> <%="\n" %></textarea>
					</td>
				</tr>
			</table>
			<div id="submit_btn">
				<br>
				<%
				%>
				<input type="checkbox" id="secret" name="secret" checked="checked">&nbsp;체크시 비밀글로 작성합니다.
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