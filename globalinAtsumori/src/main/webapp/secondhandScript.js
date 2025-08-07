/*
	자바스크립트 활용할 계획
	일단 생성함..
 */

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