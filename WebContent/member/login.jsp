<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>login</title>
<link rel="stylesheet" type="text/css" href="/JSPProject/css/inc/top.css">
<link rel="stylesheet" type="text/css" href="/JSPProject/css/inc/bottom.css">
<link rel="stylesheet" type="text/css" href="/JSPProject/css/font.css">
<link rel="stylesheet" type="text/css" href="/JSPProject/css/member/login.css">
</head>
<body>
	<jsp:include page="/inc/top.jsp"/>
	<div id="wrap">
		<h1>로그인</h1>
		<form action="loginPro.jsp" method="post" name="loginForm">
			<table>
				<tr>
					<th>ID</th>
					<td><input type="text" name="id" id="id" class="textBox"></td>
				</tr>
				<tr>
					<th>비밀번호</th>
					<td><input type="password" name="pw" id="pw" class="textBox"></td>
				</tr>
				<tr>
					<td></td>
					<td>
						<br>
						<input type="submit" class="btn" value="로그인">
						<a href="#"><input type="button" class="btn" value="회원가입" onclick="location.href='/JSPProject/member/join.jsp';"></a>
					</td>
				</tr>
				<tr>
					<td></td>
					<td>
						<a href="#"><input type="button" class="btn" value="아이디찾기" onclick="location.href='/JSPProject/member/findId.jsp';"></a>
						<a href="#"><input type="button" class="btn" value="비밀번호찾기" onclick="location.href='/JSPProject/member/findPw.jsp';"></a>
					</td>
				</tr>
			</table>
		</form>
	</div>
	<jsp:include page="/inc/bottom.jsp"/>
</body>
</html>