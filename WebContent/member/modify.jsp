<%@page import="member.MemberBean"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	String id = (String)session.getAttribute("id");
	MemberDAO memberDAO = new MemberDAO();
	MemberBean memberBean = memberDAO.selectMember(id);
	
	String email = memberBean.getEmail();
	int idx = email.indexOf('@');
	String email_1 = email.substring(0, idx);
	String email_2 = email.substring(idx+1);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>회원정보수정</title>
<link rel="stylesheet" type="text/css" href="/JSPProject/css/inc/top.css">
<link rel="stylesheet" type="text/css" href="/JSPProject/css/inc/bottom.css">
<link rel="stylesheet" type="text/css" href="/JSPProject/css/font.css">
<link rel="stylesheet" type="text/css" href="/JSPProject/css/member/modify.css">
<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
<script src="/JSPProject/js/member/modify.js"></script>
<script type="text/javascript">
</script>
</head>
<body>
	<jsp:include page="/inc/top.jsp"/>
	<div id="wrap">
		<h1>회원정보수정</h1>
		<form action="modifyPro.jsp" method="post" name="joinForm" onsubmit="return formCheck();">
			<table>
				<tr>
					<th>ID</th>
					<td>
						<input type="text" name="id" class="textBox" readonly="readonly" value="<%=memberBean.getId() %>"/>
						<span id="idCheckEmoji"></span>
					</td>
				</tr>
				<tr>
					<th>현재 비밀번호</th>
					<td>
						<input type="password" name="currentPw" class="textBox" />
					</td>
				</tr>
				<tr>
					<th>새 비밀번호</th>
					<td>
						<input type="password" name="pw" class="textBox" onfocusout="pwCheck();"/>
						<span id="pwCheckEmoji"></span>
					</td>
				</tr>
				<tr>
					<th>새 비밀번호 확인</th>
					<td>
						<input type="password" name="pw2" class="textBox" onfocusout="pw2Check();"/>
						<span id="pw2CheckEmoji"></span>
					</td>
				</tr>
				<tr>
					<th>이름</th>
					<td>
						<input type="text" name="name" class="textBox" readonly="readonly" value="<%=memberBean.getName()%>"/>
						<span id="nameCheckEmoji"></span>
					</td>
				</tr>
				<tr>
					<th>성별</th>
					<td>
						<%
							if(memberBean.getGender().equals("man")) {
						%>
						<input type="radio" name="gender" value="man" onfocusout="genderCheck();" checked="checked">남
						<input type="radio" name="gender" value="woman" onfocusout="genderCheck();">여
						<%
							} else {
						%>
						<input type="radio" name="gender" value="man" onfocusout="genderCheck();">남
						<input type="radio" name="gender" value="woman" onfocusout="genderCheck();" checked="checked">여
						<%
							}
						%>
						
						<span id="genderCheckEmoji"></span>
					</td>
				</tr>
				<tr>
					<th>이메일</th>
					<td>
						<input type="text" name="email_1" class="textBox" value="<%=email_1%>"/> @
						<input type="text" name="email_2" class="textBox" value="<%=email_2%>" onfocusout="emailCheck();" />
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
						<input type="submit" value="수정완료" class="btn">
					</td>
				</tr>
			</table>	
			
		</form>
	</div>
	<jsp:include page="/inc/bottom.jsp"/>
</body>
</html>