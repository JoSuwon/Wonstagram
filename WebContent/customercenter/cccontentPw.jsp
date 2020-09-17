<%@page import="ccboard.CCBoardBean"%>
<%@page import="ccboard.CCBoardDAO"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	request.setCharacterEncoding("utf-8");
	
	String id = (String)session.getAttribute("id");
	if(id == null) {
		id="";
	}
	String num = request.getParameter("num");
	int _num = Integer.parseInt(num);
	String pageNum = request.getParameter("pageNum");
	
	CCBoardDAO ccBoardDAO = new CCBoardDAO();
	CCBoardBean boardBean = ccBoardDAO.getBoard(_num);
	String pw = boardBean.getPw();
	
	//admin으로 로그인중 or 작성한 아이디로 로그인 중 or 비밀번호가 걸리지않은 게시물
	if(id.equals("admin") || id.equals(boardBean.getMain_id()) || boardBean.getSecret() == 0) {
		response.sendRedirect("/JSPProject/customercenter/cccontent.jsp?num=" + num + "&pageNum=" + pageNum);
	}
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" type="text/css" href="/JSPProject/css/inc/top.css">
<link rel="stylesheet" type="text/css" href="/JSPProject/css/inc/bottom.css">
<link rel="stylesheet" type="text/css" href="/JSPProject/css/font.css">
<link rel="stylesheet" type="text/css" href="/JSPProject/css/customercenter/cccontentPw.css">
<title>고객센터</title>
<script>
	function check() {
		var pw = document.getElementById("pw").value;
		if(pw == <%=pw%>) {
			location.href = "/JSPProject/customercenter/cccontent.jsp?num=" + <%=num%> + "&pageNum=" + <%=pageNum%>;
		} else {
			alert("틀린 비밀번호 입니다.");
			document.getElementById("pw").value = "";
			document.getElementById("pw").focus();
		}
	}
</script>
</head>
<body>
	<jsp:include page="/inc/top.jsp"/>
	<div id="wrap">
		
		<div id="msg">
			<span style="color:red;">비공개 글 입니다.</span><br>
			글 작성시 입력한 비밀번호를 입력해주세요.<br>
			<input type="password" id="pw" class="textBox">
			<input type="button" class="btn" value="확인" onclick="check()">
		</div>
	</div>
	<jsp:include page="/inc/bottom.jsp"/>
</body>
</html>