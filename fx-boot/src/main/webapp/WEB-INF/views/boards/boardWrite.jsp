<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>새 게시글 작성</title>
<script type="text/javascript">
var oEditors = [];
$(document).ready(function (){
	// SmartEditor2 사용 선언

	nhn.husky.EZCreator.createInIFrame({
	 oAppRef: oEditors,
	 elPlaceHolder: "contents",
	 sSkinURI: "/resources/se2/SmartEditor2Skin.html",
	 fCreator: "createSEditor2"
	});
/*
	$('#saveButton').click(function() {
		oEditors.getById['newArticle.contents'].exec("UPDATE_CONTENTS_FIELD", []);
		var title = document.getElementById('newArticle.title').value;
		var contents = document.getElementById('newArticle.contents').value;
		// 제목 Validation Check
		if(title == null || title == "") {
			alert("제목을 입력해주세요.");
			document.getElementById('newArticle.title').focus();
			return;
		}
		// 내용 Validation Check
		if (contents == null || contents == "" || contents == '&nbsp;' || contents == '<p>&nbsp;</p>' ||
			contents == '<br>' || contents == '<br/>' || contents == '<p><br></p>') {
			alert("내용을 입력해주세요.");
			oEditors.getById['newArticle.contents'].exec("FOCUS");
			return;
		}
		// 게시글 저장 (form 전송)
		var result = confirm("저장하시겠습니까");
		if(result) {
			alert("저장완료");
			document.getElementById('boardForm').submit();
		} else {
			return;
		}


	});
	*/


});
function insertBoard() {

	oEditors.getById['contents'].exec("UPDATE_CONTENTS_FIELD", []);
	var title = document.getElementById('title').value;
	var contents = document.getElementById('contents').value;
	// 제목 Validation Check
	if(title == null || title == "") {
		alert("제목을 입력해주세요.");
		document.getElementById('title').focus();
		return;
	}
	// 내용 Validation Check
	if (contents == null || contents == "" || contents == '&nbsp;' || contents == '<p>&nbsp;</p>' ||
		contents == '<br>' || contents == '<br/>' || contents == '<p><br></p>') {
		alert("내용을 입력해주세요.");
		oEditors.getById['contents'].exec("FOCUS");
		return;
	}
	// 게시글 저장 (Ajax 전송)
	var result = confirm("저장하시겠습니까?");
	var param;
	param = $(boardForm).serializeObject();

	var boardAjaxOptions = {
			SvcName: "",
			MethodName: "boardWrite.do",
			Params: {param: param},
			async: false,
			Callback: function(result) {
				var boardIdx = JSON.parse(result);
				$("#boardIdx").val(boardIdx);
				if (document.getElementById("uploadFile").files.length != 0) {
					fn_FileUpload();
				} else {
					alert("게시글 등록이 완료되었습니다.");
					var url = "/board-main.do";
					location.href = url;
				}
			},
			ErrorCallback: function() {
				alert("boardWrite.do FAILED");
			}
	};
	if (result) {
		$.fng_Ajax(boardAjaxOptions);
	}
}
	// ajax > data : formData > controller > logic > controller > result > front > result.msg == "ok" > alert > movepage
	// 실패하면 insert 된 bid 찾아서 삭제

function fn_FileUpload() {
	var boardIdx = "";
	boardIdx = $("#boardIdx").val();
	fng_UploadFile("boardForm", "/fileUpload.do", fn_FileUploadResult);
}

// 파일 업로드 결과 callback
function fn_FileUploadResult(result) {
 var string = result;
 var json = JSON.parse(string);
	if(json.isSuccess == true) {
		alert("게시글 등록이 완료되었습니다.");
		var url = "/board-main.do";
		location.href = url;
	}else if(json.isSuccess == false) {
		alert("게시글 등록이 실패했습니다.");
		return;
	}
}
</script>
</head>

<body>
<div class = "container" id = "container">
	<h3>새 게시글 작성</h3>
	<hr />
	<form id="boardForm" name="boardForm"> <!-- enctype="multipart/form-data" -->
		<div class="mb-3">
			<label for="exampleFormControlInput1" class="form-label">제목</label> <input
				type="text" class="form-control" id="title"
				name="title" placeholder="제목을 입력하세요.">
		</div>
		<div class="mb-3">
			<label for="exampleFormControlTextarea1" class="form-label"> 내용</label>
			<textarea class="form-control" name="contents"
				id="contents" rows="15" cols="200"></textarea>
		</div>

		<div class="mb-3">
			<label for="formFileMultiple" class="form-label">파일 업로드</label>
			<input class="form-control fileUpload" type="file" id="uploadFile" name = "uploadFile" multiple = "multiple">
		</div>
		<input type="hidden" id="boardIdx" name="boardIdx" value=""/>
		</form>


	<button class="btn btn-primary" type="button" id="saveButton" onclick="javascript:insertBoard();">글쓰기</button>
</div>
</body>
</html>
