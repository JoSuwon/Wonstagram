<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>비밀번호 찾기</title>
<link rel="stylesheet" type="text/css" href="/JSPProject/css/inc/top.css">
<link rel="stylesheet" type="text/css" href="/JSPProject/css/inc/bottom.css">
<link rel="stylesheet" type="text/css" href="/JSPProject/css/font.css">
<link rel="stylesheet" type="text/css" href="/JSPProject/css/member/find.css">
<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
<script>
	function findPw() {
		var email = document.getElementById("email").value;
		var id = document.getElementById("id").value;
		
		var msg = $("#msg");
		
		if(email == "") {
			msg.text("");
			msg.css("color", "red");
			msg.append("이메일을 입력해주세요.");
			return;
		}
		if(id == "") {
			msg.text("");
			msg.css("color", "red");
			msg.append("아이디를 입력해주세요.");
			return;
		}
		
		msg.text("");
		msg.css("color", "black");
		msg.append('처리중입니다. 잠시 기다려주세요!');
		
		$.ajax({
			url : 'findPwAjax.jsp',
			type : 'post',
			data : {
				email : email,
				id : id
			},
			dataType : 'text',
			success : function(data) {
				data = data.replace(/\s+/, "");//왼쪽 공백제거
				data = data.replace(/\s+$/g, "");//오른쪽 공백제거
				data = data.replace(/\n/g, "");//행바꿈제거
				data = data.replace(/\r/g, "");//엔터제거
				
				if(data == "실패") {
					msg.text("");
					msg.css("color", "red");
					msg.append("일치하는 정보가 없습니다.");
					return;
				} else if(data == "성공") {
					msg.text("");
					msg.css("color", "black");
					msg.append('이메일로 현재 비밀번호 보내드렸습니다!');
				}
				
			}
		});
	}
</script>
</head>
<body>
	<jsp:include page="/inc/top.jsp"/>
	<div id="wrap">
		<h1>비밀번호 찾기</h1>
		<form onsubmit="findPw(); return false;">
			<table>
				<tr>
					<th>이메일</th>
					<td colspan="2"><input type="text" name="email" class="textBox" id="email" style="width:213px"></td>
				</tr>
				<tr>
					<th>아이디</th>
					<td><input type="text" name="id" class="textBox" id="id"></td>
					<td><input type="submit" value="비밀번호찾기" class="btn"></td>
				</tr>
			</table>
			<div id="msg"></div>
		</form>
	</div>
	<jsp:include page="/inc/bottom.jsp"/>
</body>
</html>