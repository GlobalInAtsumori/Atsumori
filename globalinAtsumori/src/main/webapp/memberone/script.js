function idCheck(memberId) {
    if (memberId.trim() === "") {
        alert("ID를 입력하세요!");
        return;
    }
    window.open(
        "idCheck.jsp?memberId=" + encodeURIComponent(memberId), // 여기 이름 바꿈
        "idCheck",
        "width=400,height=200,top=200,left=200"
    );
}



function inputCheck() {
    var form = document.regForm;

    if(form.memberName.value.trim() === "") {
        alert("이름을 입력하세요!");
        form.memberName.focus();
        return false;
    }
    if(form.memberId.value.trim() === "") {
        alert("아이디를 입력하세요!");
        form.memberId.focus();
        return false;
    }
    if(form.password.value === "") {
        alert("비밀번호를 입력하세요!");
        form.password.focus();
        return false;
    }
    if(form.password.value !== form.repass.value) {
        alert("비밀번호가 일치하지 않습니다!");
        form.repass.focus();
        return false;
    }
    if(form.country.value === "") {
        alert("국가를 선택해주세요!");
        form.country.focus();
        return false;
    }

    // 이메일 체크
    if(form.email.value.trim() === "") {
        alert("이메일을 입력해주세요!");
        form.email.focus();
        return false;
    }

    var emailId = form.email.value.trim();
    var emailDomain = form.emailDomain.value;
    if(emailDomain === "직접입력") {
        if(form.emailDomainCustom.value.trim() === "") {
            alert("이메일 도메인을 입력해주세요!");
            form.emailDomainCustom.focus();
            return false;
        }
        emailDomain = form.emailDomainCustom.value.trim();
    }

    var fullEmail = emailId + "@" + emailDomain;

    // 이메일 형식 체크
    var atPos = fullEmail.indexOf('@'); 
    var atLastPos = fullEmail.lastIndexOf('@'); 
    var dotPos = fullEmail.indexOf('.'); 
    var spacePos = fullEmail.indexOf(' '); 
    var commaPos = fullEmail.indexOf(','); 
    var eMailSize = fullEmail.length;

    if(!(atPos > 1 && atPos == atLastPos && dotPos > 3 && spacePos == -1 && commaPos == -1 && atPos + 1 < dotPos && dotPos + 1 < eMailSize)) {
        alert("E_mail 주소 형식이 잘못되었습니다. 다시 입력해 주세요.");
        form.email.focus();
        return false;
    }

    // 이메일 합치기
    form.email.value = fullEmail;

    form.submit();
}



	function updateCheck() {


		if (document.regForm.pass.value == "") {
			alert("비밀번호를 입력해주세요.");
			document.regForm.pass.focus();
			return false;
		}
		if (document.regForm.repass.value == "") {
			alert("비밀번호를 확인을 입력해주세요.");
			document.regForm.repass.focus();
			return false;
		}


		if (document.regForm.pass.value != document.regForm.repass.value) {
			alert("비밀번호가 일치하지 않습니다.");
			document.regForm.repass.focus();
			return false;
		}




		if (document.regForm.email.value == "") {
			alert("이메일을 입력해주세요.");
			document.regForm.email.focus();
			return false;
		}

		var str = document.regForm.email.value;
		var atPos = str.indexOf('@');
		var atLastPos = str.lastIndexOf('@');
		var dotPos = str.indexOf('.');
		var spacePos = str.indexOf(' ');
		var commaPos = str.indexOf(',');
		var eMailSize = str.length;

		if (atPos > 1 && atPos == atLastPos && dotPos > 3 && spacePos == -1 && commaPos == -1 && atPos + 1 < dotPos && dotPos + 1 < eMailSize);
		else {
			alert('E_mail 주소 형식이 잘못되었습니다. \n\r 다시 입력해 주세요.');
			document.regForm.email.focus();
			return false;
		}



		document.regForm.submit();

	}


	function begin() {
		document.myForm.pass.focus();
	}

	function checkIt() {

		if (document.myForm.repass.value == "") {
			alert("비밀번호를 확인을 입력해주세요.");
			document.myForm.repass.focus();
			return false;
		}}
