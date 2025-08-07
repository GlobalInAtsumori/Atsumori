/*
	자바스크립트 활용할 계획
	일단 생성함..
 */
//희망가가 숫자가 아닐 경우 알람
document.addEventListener("DOMContentLoaded", function() {
	
	document.getElementById("costCheck").addEventListener("keydown", function(e) {
		const key = e.key;
		if (!/^[0-9]$/.test(key) && key !== "Backspace" && key !== "Tab") {
			alert("数字を入力してください。");
			e.preventDefault();
		}
	});
});

function shWriteSave() {
	
	if(document.shWriteForm.tradeTitle.value=="") {
		alert("タイトルを入力してください。");
		document.shWriteForm.tradeTitle.focus();
		return false;
	}
	
	if(document.shWriteForm.cost.value=="") {
		alert("希望価格を入力してください。");
		document.shWriteForm.cost.focus();
		return false;
	}
	
	if(document.shWriteForm.tradeContent.value=="") {
		alert("内容を入力してください。");
		document.shWriteForm.tradeContent.focus();
		return false;
	}
	
}
