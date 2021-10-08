<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<!DOCTYPE html>
<html>
<head>
<script>
function getMore() {
	var url = "getMyBoardListAll.do";
	location.href = url;
}
//선택 삭제
function deleteChecked() {
	var isChecked = $("input[name = 'rowCheck']:checked");
	if(isChecked.length == 0) {
		alert("게시물을 선택하세요.");
	} else {
		var result = confirm("선택된 게시물을 삭제하시겠습니까?");
		if(result) {
			var checkedList = $("input[name = 'rowCheck']");
			for (var i = 0; i < checkedList.length; i++) {
				if (checkedList[i].checked) {
					var param = checkedList[i].value;

					var ajaxOptions = {
							SvcName : "",
							MethodName : "deleteChecked.do",
							Params : { param : param }
					};

					var promise = new Promise(function (resolve, reject) {
						$.fng_Ajax(ajaxOptions);
						if(resolve) {
							resolve("정상적으로 삭제되었습니다.");
						} else {
							reject(Error("정상적으로 삭제되지 못했습니다."))
						}
					});
				}
			}
			Promise.all([promise]).then(function (values) {
				alert(values);
				location.reload();
			});
		}
	}
}
// 프로필 사진 업로드 전 미리보기
function preview(event) {
	for (var image of event.target.files) {
	var reader = new FileReader();
	reader.onload = function(event) {
		var img = document.createElement("img");
		img.setAttribute("src", event.target.result);
		img.setAttribute("width", 200);
		img.setAttribute("height", 200);
		$("#preview").empty();
		document.querySelector("div#preview").appendChild(img);
	};
	console.log(image);
	reader.readAsDataURL(image);
	$("#fileChangeCheck").val("1");
	}
}
// 모달창 닫을 때 정보 삭제
function deleteChanges() {
	var html = `
	<c:choose>
		<c:when test="${sessionScope.userInfo.profileImagePath != null }">
			<img src ="downloadProfile.do" name = "image" width = "200" height = "200" alt = "프로필사진" />
		</c:when>
		<c:otherwise>
			<img src ="/resources/img/common/blank-profile.png" name = "image" width = "200" height = "200" alt = "프로필사진" />
			<p style = "text-align:center;">프로필 사진이 없습니다</p>
		</c:otherwise>
	</c:choose>`;
	$("#preview").empty();
	$("#preview").append(html);
	$("#inputProfileImage").val("");
	$("#email").val("");
	$("#officeTelNum").val("");
	$("#mobileTelNum").val("");
}

function saveProfile() {
	var email = $("#email").val();
	if(!email) {
		email = "${sessionScope.userInfo.email}";
	}
	var officeTelNum = $("#officeTelNum").val();
	if(!officeTelNum.value) {
		officeTelNum = '${sessionScope.userInfo.officeTelNum}';
	}
	var mobileTelNum = $("#mobileTelNum").val();
	if(!mobileTelNum) {
		mobileTelNum = '${sessionScope.userInfo.mobileTelNum}';
	}
	var result = confirm("저장하시겠습니까?");
	if (result) {
		var check = $("#inputProfileImage").val();
		if(check) {
			var form = new FormData();
			form.append("inputProfileImage", $("#inputProfileImage")[0].files[0]);
			var imageAjaxOptions = {
					SvcName: "/Info",
					MethodName: "saveProfileImage.do",
					type: 'POST',
					data: form,
					processData: false,
					contentType: false,
					enctype:"multipart/form-data",
					Callback: function(result) {
						console.log("success");
					},
					ErrorCallback: function() {
						console.log("failed");
					}
			};

			var promise = new Promise(function (resolve, reject) {
				//$.fng_Ajax(imageAjaxOptions);
				fng_UploadFile("profileImageForm","/Info/saveProfileImage.do",fn_FileUploadResult);
				if(resolve) {
					resolve("이미지 업데이트 성공");
				} else {
					reject(Error("이미지 업데이트 실패"))
				}
			});

		}
		 // input 값 VO 매칭
		var param = {"email" : email, "mobileTelNum" : mobileTelNum, "officeTelNum" : officeTelNum};
		var inputAjaxOptions = {
				SvcName: "/Info",
				MethodName: "saveProfileInfo.do",
				Params : {param : param},
				async: false,
				Callback: function(result) {
					console.log("success");
				},
				ErrorCallback: function() {
					console.log("failed");
				}
		};
		var promise = new Promise(function (resolve, reject) {
			$.fng_Ajax(inputAjaxOptions);
			if(resolve) {
				resolve("유저 정보 업데이트 성공");
			} else {
				reject(Error("유저 정보 업데이트 실패"))
			}
		});
		Promise.all([promise]).then(function (values) {
			alert("정상적으로 처리되었습니다. 정보 변경을 위해 다시 로그인해주세요.");
			location.href = "/Login/Login.do";
			sessionStorage.clear();
		});
	}
}
//파일 업로드 결과 callback
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
<meta charset="UTF-8">
<title>마이페이지</title>
</head>
<body>
<div class = "header-divider"></div>
	<div class = "container">
	<div style = "display:flex">
		<h3><c:out value="[${sessionScope.userInfo.sygCode }] ${sessionScope.userInfo.empName }"></c:out></h3> <span style="padding-top: 10px;">님의 페이지</span>
	</div>
	<hr />

	<div id = "profile" style= "border: solid aliceblue; padding: 10px;">
	<span style = "font-size:1.5em;"> <strong>사용자 정보</strong> </span>
	<button id = "updateProfile" class = "float-right btn btn-sm btn-primary" type = "button" data-toggle = "modal" data-target = "#profileUpdateModal">수정</button>
		<div style = "display:flex">
			<div id = "profilePicture" style = "padding-right: 10px; border:dotted thick aliceblue;">
				<c:choose>
					<c:when test="${sessionScope.userInfo.profileImagePath != null }">
						<img src ="downloadProfile.do" width = "200" height = "200" alt = "프로필사진" />
					</c:when>
					<c:otherwise>
						<img src ="/resources/img/common/blank-profile.png" width = "200" height = "200" alt = "프로필사진" />
						<p style = "text-align:center;">프로필 사진이 없습니다</p>
					</c:otherwise>
				</c:choose>
			</div>
			<div id = "profileTable">
				<table class = "table table-bordered">
					<tbody>
						<tr>
							<th style = "text-align:center;">사번</th>
							<td>${sessionScope.userInfo.empCode }</td>
						</tr>
						<tr>
							<th style = "text-align:center;">메일</th>
							<td>${sessionScope.userInfo.email }</td>
						</tr>
						<tr>
							<th style = "text-align:center;">직무</th>
							<td>${sessionScope.userInfo.jobName }</td>
						</tr>
						<tr>
							<th style = "text-align:center;">전화번호</th>
							<td>사무실 : ${sessionScope.userInfo.officeTelNum} / 핸드폰 : ${sessionScope.userInfo.mobileTelNum }</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<hr />
	<!-- updateProfile Modal -->
	<div class="modal fade" id="profileUpdateModal" tabindex="-1" aria-labelledby="profileUpdateModalLabel" aria-hidden="true">
 		<div class="modal-dialog">
    		<div class="modal-content">
      			<div class="modal-header">
        			<h5 class="modal-title" id="profileUpdateModalLabel">프로필 수정</h5>
        			<button type="button" class="btn-close" data-dismiss="modal" aria-label="닫기" onclick = "javascript:deleteChanges()"></button>
      			</div>
      			<div class="modal-body" id = "modal-body">
       				<div>
       					<div id = profilePicture style = "padding-bottom: 15px;">
							<div id = "preview" style = "text-align:center; border:solid thin aliceblue;">
								<c:choose>
									<c:when test="${sessionScope.userInfo.profileImagePath != null }">
										<img src ="downloadProfile.do" name = "image" width = "200" height = "200" alt = "프로필사진" />
									</c:when>
									<c:otherwise>
										<img src ="/resources/img/common/blank-profile.png" name = "image" width = "200" height = "200" alt = "프로필사진" />
										<p style = "text-align:center;">프로필 사진이 없습니다</p>
									</c:otherwise>
								</c:choose>
							</div>
							<div>
								<form id = "profileImageForm" enctype = "multipart/form-data">
									<input type = "file" id = "inputProfileImage" name = "inputProfileImage" onchange = "preview(event)" accept = "image/*" class = "form-control"/>
								</form>
							</div>
						</div>
						<div id = "profileTable">
							<table class = "table table-bordered">
								<tbody>
									<tr>
										<th style = "text-align:center;">사번</th>
										<td>${sessionScope.userInfo.empCode }</td>
									</tr>
									<tr>
										<th style = "text-align:center;">메일</th>
										<!-- email 문자열 가공 (@samyang.com 자르기) -->
										<c:set var = "str" value = "${sessionScope.userInfo.email }" />
										<c:set var = "length" value = "${fn:length(str)}" />
										<c:set var = "emailString" value = "${fn:substring(str, 0, length-12) }" />
										<td><input id = "email" name = "email" type = "text" placeholder = "${emailString }"/><span> @samyang.com</span></td>
									</tr>
									<tr>
										<th style = "text-align:center;">직무</th>
										<td>${sessionScope.userInfo.jobName }</td>
									</tr>
									<tr>
										<th style = "text-align:center;">전화번호</th>
										<td>사무실 : <input id = "officeTelNum" name = "officeTelNum" type = "text" placeholder = "${sessionScope.userInfo.officeTelNum }"/> / <br />
										핸드폰 : <input id = "mobileTelNum" name = "mobileTelNum" type = "text" placeholder = "${sessionScope.userInfo.mobileTelNum }" /></td>
									</tr>
								</tbody>
							</table>
							<p style="text-align:center"> * 수정하지 않은 항목은 그대로 유지합니다 *</p>
						</div>
					</div>
      			</div>
      			<div class="modal-footer">
        			<button type="button" class="btn btn-secondary" data-dismiss="modal" onclick = "javascript:deleteChanges()">닫기</button>
        			<button type="button" class="btn btn-primary" onclick = "javascript:saveProfile()">저장</button>
      			</div>
    		</div>
  		</div>
	</div>
	<div>
		<div style = "float:left;">
			<span style = "font-size:1.5em;"> <strong>내가 쓴 글</strong> </span>
		</div>
		<div style = "float:right; padding-bottom:10px;">
			<span>상위 5개만 표시됩니다.</span> &nbsp;
			<button class = "btn btn-primary" onclick = "javascript:getMore();">더보기</button>
		</div>
	</div>
		<div class="table-responsive-md">
			<table class="table table-hover">
				<thead class="table-light">
					<tr>
						<th scope = "col"><input id = "allCheck" type = "checkbox" name = "allCheck"></th>
						<th scope="col">번호</th>
						<th scope="col">제목</th>
						<th scope="col">작성자</th>
						<th scope="col">날짜</th>
						<th scope="col">조회수</th>
						<th scope="col">댓글수</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="myBoardList" items="${myBoardList}" varStatus="status">
						<c:choose>
							<c:when test="${myBoardList.isNotice == 1}">
								<tr>
									<td scope = "col"><input id = "rowCheck" type = "checkbox" name = "rowCheck" value = "${myBoardList.idx }"></td>
									<td><c:out value="<strong>[공지]</strong>" escapeXml = "false"></c:out></td>
									<td> <a href="/boardDetail.do?idx=${myBoardList.idx}"><c:out value="<strong>${myBoardList.title }</strong>" escapeXml = "false"/> </a> </td>
									<td><c:out value="<strong>${myBoardList.insertUser }</strong>" escapeXml = "false"/></td>
									<td><c:out value="<strong>${myBoardList.insertDate }</strong>" escapeXml = "false"/></td>
									<td><c:out value="<strong>${myBoardList.readCnt }</strong>" escapeXml = "false"/></td>
									<td><c:out value="<strong>${myBoardList.commentCnt }</strong>" escapeXml = "false"/></td>
								</tr>
							</c:when>
							<c:when test = "${myBoardList.isSecret == 1}">
								<tr>
									<td scope = "col"><input id = "rowCheck" type = "checkbox" name = "rowCheck" value = "${myBoardList.idx }"></td>
									<c:choose>
										<c:when test = "${sessionScope.userInfo.empCode == myBoardList.insertUser}">
											<td><c:out value="${myBoardList.idx }" /></td>
											<td> <a href="/boardDetail.do?idx=${myBoardList.idx}"><c:out value="${myBoardList.title } (비공개 처리됨)" /> </a> </td>
											<td><c:out value="${myBoardList.insertUser }"/></td>
											<td><c:out value="${myBoardList.insertDate }"/></td>
											<td><c:out value="${myBoardList.readCnt }"/></td>
											<td><c:out value="${myBoardList.commentCnt }"/></td>
										</c:when>
										<c:otherwise>
											<td><c:out value="${myBoardList.idx }"></c:out></td>
											<td><c:out value="비공개 게시글입니다." /></td>
											<td><c:out value="익명사용자"/></td>
											<td><c:out value="${myBoardList.insertDate }"/></td>
											<td><c:out value="${myBoardList.readCnt }"/></td>
											<td><c:out value="${myBoardList.commentCnt }"/></td>
										</c:otherwise>
									</c:choose>
								</tr>
							</c:when>
							<c:otherwise>
								<tr>
									<td scope = "col"><input id = "rowCheck" type = "checkbox" name = "rowCheck" value = "${myBoardList.idx }"></td>
									<td><c:out value="${myBoardList.idx }" /></td>
									<td> <a href="/boardDetail.do?idx=${myBoardList.idx}"><c:out value="${myBoardList.title }" /> </a> </td>
									<td><c:out value="${myBoardList.insertUser }" /></td>
									<td><c:out value="${myBoardList.insertDate }" /></td>
									<td><c:out value="${myBoardList.readCnt }" /></td>
									<td><c:out value="${myBoardList.commentCnt }" /></td>
								</tr>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<div class = "float-right">
			<button type = "button" class = "btn btn-primary" onclick = "javascript:deleteChecked();">선택 삭제</button>
		</div>
	</div>
</body>
</html>