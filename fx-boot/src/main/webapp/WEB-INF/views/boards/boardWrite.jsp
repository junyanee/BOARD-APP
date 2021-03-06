<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name = "_csrf" content="${_csrf.token }"/>
<meta name = "_csrf_header" content="${_csrf.headerName }" />
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

	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$(document).ajaxSend(function (e, xhr, options){
		xhr.setRequestHeader(header, token);
	})
});
function insertBoard() {

	oEditors.getById['contents'].exec("UPDATE_CONTENTS_FIELD", []);
	// 공지사항 체크
	if ($("#isNotice").is(":checked")) {
		$("#isNotice").val(1);
	} else {
		$("#isNotice").val(0);
	}
	// 비밀글 체크
	if ($("#isSecret").is(":checked")) {
		$("#isSecret").val(1);
	} else {
		$("#isSecret").val(0);

	}

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
				alert("게시글 등록에 실패했습니다.");
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
<div class = "header-divider"></div>
<div class = "container" id = "container">
	<h3>새 게시글 작성</h3>
	<hr />
	<form id="boardForm" name="boardForm">
		<div class = "float-right">
			<input id = "isNotice" name = "isNotice" type = "checkbox">
			<label for = "isNotice">게시판 공지</label>
			<input id = "isSecret" name = "isSecret" type = "checkbox">
			<label for = "isSecret">비밀글</label>
		</div>
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


	<button class="btn btn-primary float-right" type="button" id="saveButton" onclick="javascript:insertBoard();">글쓰기</button>
</div>
</body>
</html>
