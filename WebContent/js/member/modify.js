



function emailAddress_Change() {
	var emailAddress = document.joinForm.emailAddress.value;
	document.joinForm.email_2.value = emailAddress;
	if (emailAddress != "") {
		document.joinForm.email_2.setAttribute("readonly", "readonly");
	} else {
		document.joinForm.email_2.removeAttribute("readonly");
	}
}

function pwCheck() {
	var re = /^[a-zA-Z0-9]{4,12}$/; // 아이디와 패스워드가 적합한지 검사할 정규식
	var pw = document.joinForm.pw.value;
	var pwCheckEmoji = document.getElementById("pwCheckEmoji");
	
	if(pw == "") {
		pwCheckEmoji.style.color = "red";
		pwCheckEmoji.innerText = "필수 정보입니다.";
		return;
	}
	if(!re.test(pw)) {
		pwCheckEmoji.style.color = "red";
		pwCheckEmoji.innerText = "4~12자의 영문 대소문자와 숫자로만 입력";
		return;
	}
	
	pwCheckEmoji.style.color = "green";
	pwCheckEmoji.innerText = "✔️ 사용 가능한 비밀번호입니다.";
}

function pw2Check() {
	var re = /^[a-zA-Z0-9]{4,12}$/; // 아이디와 패스워드가 적합한지 검사할 정규식
	var pw = document.joinForm.pw.value;
	var pw2 = document.joinForm.pw2.value;
	var pw2CheckEmoji = document.getElementById("pw2CheckEmoji");
	
	if(pw2 == "") {
		pw2CheckEmoji.style.color = "red";
		pw2CheckEmoji.innerText = "필수 정보입니다.";
		return;
	}
	if(pw != pw2) {
		pw2CheckEmoji.style.color = "red";
		pw2CheckEmoji.innerText = "비밀번호가 일치하지 않습니다.";
		return;
	}
	pw2CheckEmoji.style.color = "green";
	pw2CheckEmoji.innerText = "✔️ 비밀번호가 일치 합니다.";
}

function genderCheck() {
	var gender = document.joinForm.gender.value;
	var genderCheckEmoji = document.getElementById("genderCheckEmoji");
	
	if(gender == "") {
		genderCheckEmoji.style.color = "red";
		genderCheckEmoji.innerText = "필수 정보입니다.";
		return;
	}
	genderCheckEmoji.style.color = "green";
	genderCheckEmoji.innerText = "✔️";
}

function emailCheck() {
	var re2 = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i; // 이메일이 적합한지 검사할 정규식
	var email = document.joinForm.email_1.value + "@" + document.joinForm.email_2.value;
	var emailCheckEmoji = document.getElementById("emailCheckEmoji");
	
	if (!(re2.test(email))) {
		emailCheckEmoji.style.color = "red";
		emailCheckEmoji.innerText = "적합하지 않은 이메일 형식입니다.";
		return;
	}
	emailCheckEmoji.style.color = "green";
	emailCheckEmoji.innerText = "✔️ 사용 가능한 이메일 입니다.";
}

function formCheck() {
	var re = /^[a-zA-Z0-9]{4,12}$/ // 아이디와 패스워드가 적합한지 검사할 정규식
	var re2 = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i; // 이메일이 적합한지 검사할 정규식

	var id = document.joinForm.id;
	var currentPw = document.joinForm.currentPw;
	var pw = document.joinForm.pw;
	var pw2 = document.joinForm.pw2;
	var name = document.joinForm.name;
	var gender = document.joinForm.gender;
	var email = document.joinForm.email_1.value + "@"
			+ document.joinForm.email_2.value;

	if (!check(re, id, "아이디는 4~12자의 영문 대소문자와 숫자로만 입력해주세요.")) {
		return false;
	}
	if (!check(re, pw, "비밀번호는 4~12자의 영문 대소문자와 숫자로만 입력해주세요.")) {
		return false;
	}
	
	if(pw.value != pw2.value) {
		alert("비밀번호가 일치하지 않습니다.");
		return false;
	}
	
	if(name.value == "") {
		alert("이름을 입력해주세요.");
		return false;
	}
	
	if(gender.value == "") {
		alert("성별을 골라주세요.");
		return false;
	}
	if (!(re2.test(email))) {
		alert("적합하지 않은 이메일 형식입니다.");
		document.joinForm.email_1.focus();
		return false;
	}
	
	var ajaxResult = true;
	$.ajax({
		async : false,
		url : 'pwCheck.jsp',
		type : 'post',
		data : {
			id : id.value,
			pw : currentPw.value
		},
		dataType : 'text',
		success : function(data) {
			data = data.replace(/\s+/, "");//왼쪽 공백제거
			data = data.replace(/\s+$/g, "");//오른쪽 공백제거
			data = data.replace(/\n/g, "");//행바꿈제거
			data = data.replace(/\r/g, "");//엔터제거
			if(data == "false") {
				ajaxResult = false;
			}
		}
	});
	if(ajaxResult == false) {
		alert("현재 비밀번호가 틀립니다.");
		document.joinForm.currentPw.focus();
		return false;
	}
}

function check(re, what, message) {
	if (re.test(what.value)) {
		return true;
	}
	alert(message);
	what.value = "";
	what.focus();
}