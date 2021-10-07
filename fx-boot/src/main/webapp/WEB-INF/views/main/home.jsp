<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript">
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
		 */

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
var obj = [];
	function run(idx) {
		var idx = idx;
			$.ajax({
				type: "GET",
				url : "selectAll.do",
				data : {"idx" : idx},
				success: function(response) {
					//var result = JSON.stringify(response);
					//console.log("SUCCESS: " + result)
					//obj.push(JSON.parse(result));
					obj.push(response);

					},
				error: function(response) {
					console.log("ERROR: " + idx);
				},
				dataType: 'json',
				async: true
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
  		<div class="carousel-indicators">
    		<button type="button" data-target="#carouselExampleCaptions" data-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
    		<button type="button" data-target="#carouselExampleCaptions" data-slide-to="1" aria-label="Slide 2"></button>
    		<button type="button" data-target="#carouselExampleCaptions" data-slide-to="2" aria-label="Slide 3"></button>
  		</div>
  		<div class="carousel-inner">
    		<div class="carousel-item active">
      			<img src="/resources/img/common/carousel-1.jpg" class="d-block w-100" alt="슬라이드1" style = "max-width:auto; height:550px; overflow:hidden;">
      			<div class="carousel-caption d-none d-md-block">
        			<h5>First slide label</h5>
        			<p>Some representative placeholder content for the first slide.</p>
      			</div>
    		</div>
    		<div class="carousel-item">
      			<img src="/resources/img/common/carousel-2.jpg" class="d-block w-100" alt="슬라이드2" style = "max-width:auto; height:550px; overflow:hidden;">
      			<div class="carousel-caption d-none d-md-block">
        			<h5>Second slide label</h5>
        			<p>Some representative placeholder content for the second slide.</p>
      			</div>
    		</div>
    		<div class="carousel-item">
      			<img src="/resources/img/common/carousel-3.jpg" class="d-block w-100" alt="슬라이드3" style = "max-width:auto; height:550px; overflow:hidden">
      			<div class="carousel-caption d-none d-md-block">
        			<h5>Third slide label</h5>
        			<p>Some representative placeholder content for the third slide.</p>
      			</div>
    		</div>
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
	<div class="container" id = "container">
		<div>

			<div>
				<p>
					게시판 홈 화면
				</p>

			</div>
			<div>
				<button type = "button" onclick = "javascript:call();"> 조회하기</button>
				<a href = "/Common/insertHome.do"><button type = "button"> ajax 예제</button></a>
			</div>
		</div>
	</div>
</body>
</html>