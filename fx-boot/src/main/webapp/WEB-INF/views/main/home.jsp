<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript">
/*
	var test;
	$(document).ready(function() {
		var objs = [];
		objs.push({
			VALUE : "t",
			TEXT : "e"
		});

		/**
		 * 지정된 형식의 JsonData DropDown 바인딩
		 * JsonData의 textField, valueField 가 Json 필드명의 TEXT, VALUE로 된 데이터
		 * @param1 {String} ddlID : select tag id
		 * @param2 {JSON Object} JsonData : 커스텀 Json데이터
		 * @param3 {ddlType} obj_ddlType
		 * @param4 {width} width size : 필수아님
		 * @param5 {function} onchange : 필수아님
		 * @param6 {function} oncomplete : 필수아님
		 */
		//fng_DataDdlBind("testdrop", objs, ddlType.ALL, 120);
		/**
		 * 공통 Ajax
		 * @param {JSON} options
		 * @example options = {
						            SvcName: "/system",
						            MethodName: "test.do",
						            Params: {
						            },
						            Callback: (function (result) {
						            }),
						            ErrorCallback: (function (result) {
						            }),
						            IsASync: true
				        		};


		var param = {};
		param["codeValue"] = "COMP";
		var ajaxOptions = {
			SvcName : "Common",
			MethodName : "getItemCode.do",
			Params : {
				param : param
			},
			Callback : function(result) {
				console.log(result);
				test = result;
				fng_DataDdlBind("testdrop", result, ddlType.ALL, 120);
			}
		}
		$.fng_Ajax(ajaxOptions);
	});
*/
var obj = [];
	function run(idx) {
		var idx = idx;
			$.ajax({
				type: "GET",
				url : "/selectAll.do",
				data : {"idx" : idx},
				dataType: 'json',
				success: function(response) {
					var result = JSON.stringify(response);
					console.log("SUCCESS: " + result)
					obj.push(response);
					},
				error: function(response) {
					console.log("ERROR: " + idx);
				}
			});
	}
	function call() {
		for (var i = 151; i < 1151; i ++) {
			run(i);
		}
		console.log(obj.sort());
	}

// carousel
$(function() {
	$(".carousel").carousel({
		interval : 5000,
		pause : "hover",
		wrap: true,
		keyboard: true
	});
});
</script>
<meta charset="UTF-8">
<title>Home</title>
</head>
<body>
	<div id="carouselExampleCaptions" class="carousel slide" data-ride="carousel">
        <ol class="carousel-indicators">
          <li data-target="#carouselExampleCaptions" data-slide-to="0" class="active"></li>
          <li data-target="#carouselExampleCaptions" data-slide-to="1"></li>
          <li data-target="#carouselExampleCaptions" data-slide-to="2"></li>
        </ol>
  		<div class="carousel-inner">
			<c:forEach var = "bannerInfo" items = "${bannerInfo }" varStatus = "status">
			<c:choose>
				<c:when test="${status.count == 1 }">
					<div class="carousel-item active">
            			<img class="third-slide" src=${bannerInfo.imageSrc } alt="slide-${status.count }" style = "min-width:100%; height: 30rem;">
              			<div class="carousel-caption text-right">
                			<h1>${bannerInfo.title }</h1>
                			<p>${bannerInfo.contents }</p>
                			<c:if test="${bannerInfo.buttonCheck == 'Y' }">
                				<p><a class="btn btn-lg btn-outline-warning" href=${bannerInfo.buttonLink } role="button">${bannerInfo.buttonContents }</a></p>
                			</c:if>
           				</div>
          			</div>
				</c:when>
				<c:otherwise>
					<div class="carousel-item">
            			<img class="third-slide" src=${bannerInfo.imageSrc } alt="slide-${status.count }" style = "min-width:100%; height: 30rem;">
              			<div class="carousel-caption text-right">
                			<h1>${bannerInfo.title }</h1>
                			<p>${bannerInfo.contents }</p>
                			<c:if test="${bannerInfo.buttonCheck == 'Y' }">
                				<p><a class="btn btn-lg btn-outline-warning" href=${bannerInfo.buttonLink } role="button">${bannerInfo.buttonContents }</a></p>
           					</c:if>
           				</div>
          			</div>
				</c:otherwise>
			</c:choose>
			</c:forEach>
  		</div>
  		<button class="carousel-control-prev" type="button" data-target="#carouselExampleCaptions" data-slide="prev">
    		<span class="carousel-control-prev-icon" aria-hidden="true"></span>
    		<span class="visually-hidden">Previous</span>
  		</button>
  		<button class="carousel-control-next" type="button" data-target="#carouselExampleCaptions" data-slide="next">
    		<span class="carousel-control-next-icon" aria-hidden="true"></span>
    		<span class="visually-hidden">Next</span>
  		</button>
	</div>
	<!--
	<div class = "container">
		<div class = "row">
			<div class = "jumbotron col-7">
				<h3>공지사항</h3>

			</div>
			<div class = "col-1" ></div>
			<div class = "jumbotron col-4">
				<h3>News</h3>
			</div>
		</div>
	</div>
	  -->
	<div class="container">
		<div class = "jumbotron">
			<div class="col-sm-8 mx-auto">
				<h1>AJAX 데이터 반복 조회</h1>
				<p class = "lead">JS의 Promise 사용의 이유를 알아보기 위해 AJAX를 통한 데이터 조회를 1000번 실시하고 순서대로 응답이 들어오는지를 확인하기 위한 예제입니다.</p>
				<p>조회 데이터 개수 : 1000건</p>
				<button type = "button" class = "btn btn-primary float-right" onclick = "javascript:call();"> 조회하기</button>
			</div>
		</div>
	</div>
	<div class="container">
        <div class="row">
          <div class="col-md-6">
            <h2>AJAX 데이터 반복 조회</h2>
            <p>JS의 Promise 사용의 이유를 알아보기 위해 AJAX를 통한 데이터 조회를 1000번 실시하고 순서대로 응답이 들어오는지를 확인하기 위한 예제입니다. </p>
            <p><a class="btn btn-secondary" onclick = "javascript:call();" role="button">조회하기 &raquo;</a></p>
          </div>
          <div class="col-md-6">
            <h2>AJAX 예제</h2>
            <p>AJAX를 사용하여 간단한 이름, 나이를 입력하는 예제입니다. </p>
            <p><a class="btn btn-secondary" href = "/Common/insertHome.do" role="button">예제실습 &raquo;</a></p>
          </div>
        </div>
	</div>
</body>
</html>