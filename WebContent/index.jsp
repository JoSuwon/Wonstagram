<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Wonstagram</title>
<link rel="stylesheet" type="text/css" href="/JSPProject/css/inc/top.css">
<link rel="stylesheet" type="text/css" href="/JSPProject/css/inc/bottom.css">
<link rel="stylesheet" type="text/css" href="/JSPProject/css/font.css">
<link rel="stylesheet" type="text/css" href="/JSPProject/css/index.css">
<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
<script>
location.href = "/JSPProject/newsfeed/newsfeed.jsp";
</script>
</head>
<body>
	<!-- <div id="loader-wrap">
		<div id="loader-text">로딩중 ...</div>
	</div> -->
	<jsp:include page="/inc/top.jsp"/>
	<div id="wrap">
		<h1>홈</h1>
	</div>
	<jsp:include page="/inc/bottom.jsp"/>
</body>
</html>