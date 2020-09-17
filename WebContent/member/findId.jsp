<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>아이디 찾기</title>
<link rel="stylesheet" type="text/css" href="/JSPProject/css/inc/top.css">
<link rel="stylesheet" type="text/css" href="/JSPProject/css/inc/bottom.css">
<link rel="stylesheet" type="text/css" href="/JSPProject/css/font.css">
<link rel="stylesheet" type="text/css" href="/JSPProject/css/member/find.css">
<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
<script>
	function findId() {
		var name = document.getElementById("name").value;
		var msg = $("#msg");
		
		if(name == "") {
			msg.text("");
			msg.css("color", "red");
			msg.append("이름을 입력해주세요.");
			return;
		}
		
		$.ajax({
			url : 'findIdAjax.jsp',
			type : 'post',
			data : {
				name : name
			},
			dataType : 'text',
			success : function(data) {
				data = data.replace(/\s+/, "");//왼쪽 공백제거
				data = data.replace(/\s+$/g, "");//오른쪽 공백제거
				data = data.replace(/\n/g, "");//행바꿈제거
				data = data.replace(/\r/g, "");//엔터제거
				
				var jsonArr = JSON.parse(data);
				console.log(jsonArr.length);
				if(jsonArr.length == 0) {
					msg.text("");
					msg.css("color", "red");
					msg.append("가입된 회원이 존재하지 않습니다. <br>");
					return;
				}
				
				msg.text("");
				msg.css("color", "black");
				msg.append(name + "(으)로 가입된 아이디 검색결과입니다. <br>");
				for(var i=0; i<jsonArr.length; i++) {
					msg.append('<i>"' + jsonArr[i].id + '"</i>');
					
					if(i < (jsonArr.length - 1)) {
						msg.append(" , ");
					}
				}
			}
		});
	}
</script>
</head>
<body>
	<jsp:include page="/inc/top.jsp"/>
	<div id="wrap">
		<h1>아이디 찾기</h1>
		<form onsubmit="findId(); return false;">
			<table>
				<tr>
					<th>이름</th>
					<td><input type="text" name="name" class="textBox" id="name"></td>
					<td><input type="submit" value="아이디찾기" class="btn"></td>
				</tr>
			</table>
			<div id="msg"></div>
		</form>
	</div>
	<jsp:include page="/inc/bottom.jsp"/>
</body>
</html>