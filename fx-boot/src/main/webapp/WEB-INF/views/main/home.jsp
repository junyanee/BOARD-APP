<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
</script>
<div>
	<div class="container">
		<h1>Home</h1>
		<hr>
	<p>
	블라블라블라블라
	</p>

	</div>
</div>