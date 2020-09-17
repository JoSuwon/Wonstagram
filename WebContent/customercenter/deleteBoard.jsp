<%@page import="ccboard.CCBoardBean"%>
<%@page import="ccboard.CCBoardDAO"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	request.setCharacterEncoding("utf-8");

	int num = Integer.parseInt(request.getParameter("num"));
	String id = (String)session.getAttribute("id");
	if(id == null) id ="";
	
	CCBoardDAO ccBoardDAO = new CCBoardDAO();
	CCBoardBean boardBean = ccBoardDAO.getBoard(num);
	
	if(!id.equals(boardBean.getId())) {
%>
		<script>
			alert("작성자만 삭제 가능합니다.");
			history.back();
		</script>
<%
	} else {
		ccBoardDAO.deleteBoard(num);		
		response.sendRedirect("/JSPProject/customercenter/customercenter.jsp");	
	}
%>