//내용 입력한 상황에서 등록 안 하고 페이지 나가려고 할 때
document.addEventListener("DOMContentLoaded", function() {
	let formDirty = false;
	
	const inputs = document.querySelectorAll("input[type='text'], textarea");
	const costInput = document.getElementById("costCheck");
	
	// 입력 감지 → formDirty = true
	inputs.forEach(input => {
		input.addEventListener("input", function() {
			formDirty = true;
		});
	});
	
	// 페이지 이탈 시 경고
	window.addEventListener("beforeunload", function(e) {
		if (formDirty) {
			e.preventDefault();
			e.returnValue = ''; // 필수: 경고창을 띄우기 위한 값
		}
	});
	
	// 폼 제출 시에는 경고 제거
	document.trWriteForm.addEventListener("submit", function() {
		formDirty = false;
	});
	
	// 숫자 아닌 값 입력 시 알림 및 자동 정리
	if (costInput) {
		costInput.addEventListener("input", function(e){
			if (!/^\d*$/.test(this.value)) {
				alert("数字を入力してください。");
				this.value = this.value.replace(/\D/g, '');
			}
		});
	}
});

//희망가가 숫자가 아닐 경우 알람
document.addEventListener("DOMContentLoaded", function() {
	
	const input = document.getElementById("costCheck");
	
	input.addEventListener("input", function(e){
		//숫자가 아니면 alert
		if(!/^\d*$/.test(this.value)) {
			alert("数字を入力してください。");
			//숫자만 남기고 제거
			this.value = this.value.replace(/\D/g, '');
		}
	});
});

function trWriteSave() {
	
	if(document.trWriteForm.tradeTitle.value=="") {
		alert("タイトルを入力してください。");
		document.trWriteForm.tradeTitle.focus();
		return false;
	}
	
	if(document.trWriteForm.cost.value=="") {
		alert("希望価格を入力してください。");
		document.trWriteForm.cost.focus();
		return false;
	}
	
	if(document.trWriteForm.tradeContent.value=="") {
		alert("内容を入力してください。");
		document.trWriteForm.tradeContent.focus();
		return false;
	}
	
	//사진 업로드 필수 지정
	if(document.trWriteForm.imageFile.value=="") {
		alert("写真をアップロードしてください。");
		document.trWriteForm.imageFile.focus();
		return false;
	}
	return true;
}
