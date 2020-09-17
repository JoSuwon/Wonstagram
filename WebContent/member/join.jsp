<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>회원 가입</title>
<link rel="stylesheet" type="text/css" href="/JSPProject/css/font.css">
<link rel="stylesheet" type="text/css" href="/JSPProject/css/member/join.css">
<link rel="stylesheet" type="text/css" href="/JSPProject/css/inc/top.css">
<link rel="stylesheet" type="text/css" href="/JSPProject/css/inc/bottom.css">
<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
<script src="/JSPProject/js/member/join.js"></script>
<script type="text/javascript">
</script>
</head>
<body>
	<jsp:include page="/inc/top.jsp"/>
	<div id="wrap">
		<h1>회원가입</h1>
		<form action="joinPro.jsp" method="post" name="joinForm" onsubmit="return formCheck();">
			<table>
				<tr>
					<th>ID</th>
					<td>
						<input type="text" name="id" class="textBox" onfocusout="idCheck();"/>
						<span id="idCheckEmoji"></span>
					</td>
				</tr>
				<tr>
					<th>비밀번호</th>
					<td>
						<input type="password" name="pw" class="textBox" onfocusout="pwCheck();"/>
						<span id="pwCheckEmoji"></span>
					</td>
				</tr>
				<tr>
					<th>비밀번호 확인</th>
					<td>
						<input type="password" name="pw2" class="textBox" onfocusout="pw2Check();"/>
						<span id="pw2CheckEmoji"></span>
					</td>
				</tr>
				<tr>
					<th>이름</th>
					<td>
						<input type="text" name="name" class="textBox" onfocusout="nameCheck();"/>
						<span id="nameCheckEmoji"></span>
					</td>
				</tr>
				<tr>
					<th>성별</th>
					<td>
						<input type="radio" name="gender" value="man" onfocusout="genderCheck();">남
						<input type="radio" name="gender" value="woman" onfocusout="genderCheck();">여
						<span id="genderCheckEmoji"></span>
					</td>
				</tr>
				<tr>
					<th>이메일</th>
					<td>
						<input type="text" name="email_1" class="textBox"/> @
						<input type="text" name="email_2" class="textBox" style="width:100px;" onfocusout="emailCheck();" />
						<select name="emailAddress" onchange="emailAddress_Change()" onfocusout="emailCheck();">
							<option value="">직접선택</option>
							<option value="naver.com">naver.com</option>
							<option value="google.com">google.com</option>
							<option value="hanmail.net">hanmail.net</option>
						</select>
						<br><span id="emailCheckEmoji"></span>
					</td>
				</tr>
				<tr>
					<th></th>
					<td>
						<br>
						<input type="submit" value="회원가입" class="btn">
						<input type="reset" value="초기화" class="btn">
					</td>
				</tr>
			</table>	
			
		</form>
	</div>
	<jsp:include page="/inc/bottom.jsp"/>
</body>
</html>