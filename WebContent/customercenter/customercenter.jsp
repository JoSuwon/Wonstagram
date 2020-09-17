<%@page import="ccboard.CCBoardBean"%>
<%@page import="java.util.List"%>
<%@page import="ccboard.CCBoardDAO"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	String id = (String)session.getAttribute("id");
	if(id == null) {
		//out.print("<script>alert('로그인을 해주세요!'); location.href='/JSPProject/member/login.jsp';</script>");
	}
	String pageNum = request.getParameter("pageNum");
	String searchId = request.getParameter("searchId");
	
	CCBoardDAO ccBoardDAO = new CCBoardDAO();
	int pageSize = 6;
	int boardCount = ccBoardDAO.getBoardCount();

	
	if(pageNum == null) {
		pageNum = "1";
	}
	if(searchId == null) {
		searchId = "*";
	} else {
		pageSize = boardCount;
	}
	
	int currentPage = Integer.parseInt(pageNum);
	int startRow = (currentPage - 1) * pageSize;
	
	List<CCBoardBean> ccBoardBeanList = null;
	
	if(boardCount > 0) {
		ccBoardBeanList = ccBoardDAO.getBoardList(startRow, pageSize, searchId);
	}
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" type="text/css" href="/JSPProject/css/inc/top.css">
<link rel="stylesheet" type="text/css" href="/JSPProject/css/inc/bottom.css">
<link rel="stylesheet" type="text/css" href="/JSPProject/css/font.css">
<link rel="stylesheet" type="text/css" href="/JSPProject/css/customercenter/customercenter.css">
<title>고객센터</title>
<script>
	function search() {
		var search_input = document.getElementById("search_board_input").value;
		if(search_input == null) search_input = '*';
		location.href = "/JSPProject/customercenter/customercenter.jsp?searchId=" + search_input;
	}
</script>
</head>
<body>
	<jsp:include page="/inc/top.jsp"/>
	<div id="wrap">
		<h1>고객센터</h1>
		<table>
			<tr>
				<th>글번호</th>
				<th>글제목</th>
				<th>작성자</th>
				<th>작성날짜</th>
				<th>조회수</th>
			</tr>
			<%
			if(boardCount > 0) {
				for(int i=0; i<ccBoardBeanList.size(); i++) {
					CCBoardBean boardBean = ccBoardBeanList.get(i);
			%>
					<tr>
						<td><%=boardBean.getNum() %></td>
						<td onclick="location.href = '/JSPProject/customercenter/cccontentPw.jsp?num=<%=boardBean.getNum()%>&pageNum=<%=pageNum%>';">
							<%
							for(int j=0; j<boardBean.getRe_lev(); j++) {
							%>
								&nbsp;&nbsp;
							<%
							}
							%>
							<%=boardBean.getRe_lev() == 0 ? "" : "↪"%><%=boardBean.getSecret() == 1 ? "🔒︎ " : ""%><%=boardBean.getSubject() %>
						</td>
						<td><%=boardBean.getId() %></td>
						<td><%=boardBean.getDate().toString().substring(0, 10) %></td>
						<td><%=boardBean.getReadcount() %></td>
					</tr>			
			<%
				}
				
			} else {
			%>
			<tr>
				<td colspan="5" style="text-align:center;">게시판 글 없음</td>
			</tr>
			<%
			}
			%>
		</table>
		<div id="write_btn">
			<%
			if(id != null) {
			%>
				<input type="button" class="btn" value="문의하기" onclick="location.href='/JSPProject/customercenter/ccwrite.jsp'">
			<%
			} else {
			%>
				<br>
			<%
			}
			%>
		</div>
		<div id="table_search">
			<form onsubmit="search(); return false;">
				<input type="text" id="search_board_input" class="textBox" placeholder="작성자검색">
				<input type="submit" id="search_button" class="btn" value="검색">
			</form>
		</div>
		<div id="page_control">
			<%
			if (boardCount > 0) {
				int pageCount = boardCount / pageSize + (boardCount % pageSize == 0 ? 0 : 1);

				int pageBlock = 5;

				int startPage = ((currentPage / pageBlock) - (currentPage % pageBlock == 0 ? 1 : 0)) * pageBlock + 1;
				int endPage = startPage + pageBlock - 1;
				if(endPage > pageCount) endPage = pageCount;

				if (startPage > pageBlock) {
			%>
					<a href="/JSPProject/customercenter/customercenter.jsp?pageNum=<%=startPage - pageBlock%>">이전</a>
			<%
				}

				for (int i = startPage; i <= endPage; i++) {
					if (Integer.parseInt(pageNum) == i) {
			%>
					<a href="/JSPProject/customercenter/customercenter.jsp?pageNum=<%=i%>"><b><%=i%></b></a>
			<%
					} else {
			%>
						<a href="/JSPProject/customercenter/customercenter.jsp?pageNum=<%=i%>"><%=i%></a>
			<%
					}
				}

				if (endPage < pageCount) {
			%>
					<a href="/JSPProject/customercenter/customercenter.jsp?pageNum=<%=startPage + pageBlock%>">다음</a>
			<%
				}
			}
			%>
		</div>
	</div>
	
	<jsp:include page="/inc/bottom.jsp"/>
</body>
</html>