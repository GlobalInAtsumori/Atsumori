/*
	자바스크립트 활용할 계획
	일단 생성함..
 */

function shWriteSave() {
	
	if(document.secondhandWriteForm.tradeTitle.value=="") {
		alert("タイトルを入力してください。");
		document.secondhandWriteForm.tradeTitle.focus();
		return false;
	}
	
	if(document.secondhandWriteForm.cost.value=="") {
		alert("希望価格を入力してください。");
		document.secondhandWriteForm.cost.focus();
		return false;
	}
	
	if(document.secondhandWriteForm.tradeContent.value=="") {
		alert("内容を入力してください。");
		document.secondhandWriteForm.tradeContent.focus();
		return false;
	}
	
}