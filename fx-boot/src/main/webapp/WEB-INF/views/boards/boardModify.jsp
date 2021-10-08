<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 수정</title>
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
});
function modifyArticle() {
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

	var idx = document.getElementById('boardIdx').value;
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
	// 게시글 저장
	var result = confirm("저장하시겠습니까");
	var param;
	param = $(boardForm).serializeObject();

	var boardAjaxOptions = {
			SvcName: "",
			MethodName: "boardModify.do",
			Params: {param: param},
			async: false,
			Callback: function(result) {
            	if (result.isSuccess == true) {
            		if(document.getElementById("uploadFile").files.length != 0) {
            			fn_FileUpload();
            		} else {
                    	alert("게시글 수정이 완료되었습니다.");
    					var url = "/boardDetail.do?idx=" + idx;
    					location.href = url;
            		}
            	}
			},
			ErrorCallback: function() {
            	if (result.isSuccess == false) {
                	alert("게시글 수정에 실패했습니다.");
            	}
			}
	};
	if(result) {
		$.fng_Ajax(boardAjaxOptions);
	}

}

function fn_FileUpload() {
	fng_UploadFile("boardForm", "/fileUpload.do", fn_FileUploadResult);
}

// 파일 업로드 결과 callback
function fn_FileUploadResult(result) {
var idx = document.getElementById('boardIdx').value;
 var string = result;
 var json = JSON.parse(string);
	if(json.isSuccess == true) {
    	alert("게시글 수정이 완료되었습니다.");
		var url = "/boardDetail.do?idx=" + idx;
		location.href = url;
	}else if(json.isSuccess == false) {
		alert("게시글 수정에 실패했습니다.");
		return;
	}
}
</script>
</head>

<body>
	<div class = "header-divider"></div>
	<div class = "container" id = "container">
		<h3>게시글 수정</h3>
		<hr />
		<form method="POST" id="boardForm" name="boardForm">
			<div class = "float-right">
				<input id = "isNotice" name = "isNotice" type = "checkbox" <c:if test = "${modifyArticle.isNotice == 1}">checked</c:if>>
				<label for = "isNotice">게시판 공지</label>
				&nbsp;&nbsp;&nbsp;
				<input id = "isSecret" name = "isSecret" type = "checkbox" <c:if test = "${modifyArticle.isSecret == 1}">checked</c:if>>
				<label for = "isSecret">비밀글</label>
			</div>
			<div class="mb-3">
				<label for="exampleFormControlInput1" class="form-label">제목</label>
				<input type="text" class="form-control" id="title"
					name="title" value = "${modifyArticle.title }">
			</div>
			<div class="mb-3">
				<label for="exampleFormControlTextarea1" class="form-label">내용</label>
				<textarea class="form-control" name="contents"
					id="contents" rows="15" cols="200">${modifyArticle.contents }</textarea>
			</div>
			<div class="mb-3">
				<label for="formFileMultiple" class="form-label">파일 업로드</label>
				<input class="form-control fileUpload" type="file" id="uploadFile" name = "uploadFile" multiple = "multiple">
			</div>
			<div class = "float-right">
				<button class="btn btn-primary" type="button" id="saveButton" onclick = "javascript:modifyArticle();">수정하기</button>
			</div>
			<input type="hidden" id="boardIdx" name="boardIdx" value="${modifyArticle.idx }"/>
			<input type="hidden" id = "idx" name = "idx" value = "${modifyArticle.idx }" />
		</form>
	</div>
</body>
</html>
