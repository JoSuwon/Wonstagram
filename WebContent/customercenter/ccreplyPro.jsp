<%@page import="ccboard.CCBoardDAO"%>
<%@page import="ccboard.CCBoardBean"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	request.setCharacterEncoding("utf-8");

	String id = (String)session.getAttribute("id");
	String pw = request.getParameter("pw");
	String subject = request.getParameter("subject");
	String content = request.getParameter("content");
	String secret = request.getParameter("secret");
	int re_ref = Integer.parseInt(request.getParameter("re_ref"));
	String mainId = request.getParameter("mainId");
	if(secret == null) {
		secret = "off";
	}
	
	CCBoardDAO ccBoardDAO = new CCBoardDAO();
	CCBoardBean boardBean = new CCBoardBean();
	
	CCBoardBean mainBean = ccBoardDAO.getBoard(re_ref);
	
	boardBean.setId(id);
	boardBean.setPw(pw);
	boardBean.setSubject(subject);
	boardBean.setContent(content);
	boardBean.setRe_ref(re_ref);
	boardBean.setMain_id(mainId);
	boardBean.setRe_lev(mainBean.getRe_lev() + 1);
	if(secret.equals("on")) {
		boardBean.setSecret(1);
	}
	
	
	ccBoardDAO.replyBoard(boardBean);
	
	int boardCount = ccBoardDAO.getMaxNum();	
	response.sendRedirect("/JSPProject/customercenter/cccontent.jsp?num=" + boardCount);
%>