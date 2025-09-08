function writeSave(){
	if(document.writeForm.title.value==""){
		alert("제목을 입력해 주세요...");
		document.writeForm.title.focus();
		return false;
	}
	
	if(document.writeForm.content.value==""){
		alert("내용을 입력해 주세요...");
		document.writeForm.content.focus();
		return false;
	}
}

function deleteSave(){
	// 비밀번호 필드를 제거했으므로 더 이상 필요하지 않습니다.
	// 비밀번호 검증 없이 바로 삭제가 진행됩니다.
}
