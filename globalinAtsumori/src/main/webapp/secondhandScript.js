//희망가가 숫자가 아닐 경우 알람
document.addEventListener("DOMContentLoaded", function() {
	
	const input = document.getElementById("costCheck");
	
	input.addEventListener("input", function(e){
		
		if(!/^\d*$/.test(this.value)) {
			alert("数字を入力してください。");
			this.value = this.value.replace(/\D/g, '');
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
