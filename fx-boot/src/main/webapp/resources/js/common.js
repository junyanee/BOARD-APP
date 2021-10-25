
/**
 * Ajax Call Count
 */
var g_AjaxCallCount = 0;


/**
 * 드롭다운 기본값 타입
 * ALL: "==전체=="
 * Select: "==선택=="
 * Blank: ""
 * None : 기본값 없음.(빈값 추가안함)
 */
var ddlType = { ALL: 1, ALL_VALUE: 2, Select: 3, SELECT_VALUE: 4, Blank: 5, None: -1 };
/**
 * 공통 컨트롤의 ddlType별 정의 text반환
 * @param1 {ddlType} obj_ddlType
 * @returns {String} text
 */
function fng_DdlTypeText(obj_ddlType)
{
    switch (obj_ddlType)
    {
        case ddlType.ALL:
        case ddlType.ALL_VALUE:
            return "==전체==";
        case ddlType.Select:
        case ddlType.SELECT_VALUE:
            return "==선택==";
        case ddlType.Blank:
            return " ";
        case ddlType.None:
        default:
            return obj_ddlType;
    }
}

/**
 * 공통 컨트롤의 ddlType별 정의 value반환
 * @param1 {ddlType} obj_ddlType
 * @returns {String} value
 */
function fng_DdlTypeValue(obj_ddlType) {
    switch (obj_ddlType) {
        case ddlType.ALL:
        case ddlType.Select:
        case ddlType.Blank:
        default:
            return "";
        case ddlType.SELECT_VALUE:
        case ddlType.ALL_VALUE:
            return "ALL";
        case ddlType.None:
    }
}

/**
 * 드롭다운 공통코드 바인딩.
 * @param1 {String} select tag id
 * @param2 {CodeType} CodeType
 * @param3 {JSON Object} oParam
 * @param4 {ddlType} obj_ddlType
 * @param5 {width} width size : 필수아님
 * @param6 {function} onchange : 필수아님
 * @param7 {function} oncomplete : 필수아님
 */
function fng_CodeDdlBind(ddlID, CodeType, oParam, obj_ddlType, width, onchange, oncomplete) {
    var ddl = $("#" + ddlID);
    var default_value = ddl.attr("default_value");
    if (!ddl) return;
    if (width) ddl.width(width);
    ddl.off("change");
    if (onchange) ddl.change(function () { onchange(ddl); });
    ddl.find('option').remove();
    if (obj_ddlType != ddlType.None) {
        ddl.prepend("<option value='" + fng_DdlTypeValue(obj_ddlType) + "' selected >" + fng_DdlTypeText(obj_ddlType) + "</option>");
    }
    fng_GetCodeJson(CodeType, oParam, function (data) {
        for (var i = 0; i < data.length; i++) {
            var option = $("<option value='" + data[i]["VALUE"] + "'>" + data[i]["TEXT"] + "</option>");
            option.data(data[i]);
            ddl.append(option);
        }
        if (default_value) fng_DefaultValue(default_value, ddl);
        if (oncomplete) oncomplete(ddl, data);
    });
}

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

function fng_DataDdlBind(ddlID, JsonData, obj_ddlType, width, onchange, oncomplete) {

	var ddl = $("#" + ddlID);
    var default_value = ddl.attr("default_value");
    if (!ddl) return;
    if (width) ddl.width(width);
    ddl.off("change");
    if (onchange) ddl.change(function () { onchange(ddl, JsonData); });
    ddl.find('option').remove();
    if (obj_ddlType != ddlType.None) {
        var nullValue = ddl.attr("null_value") == 'null' ? "" : ddl.attr("null_value");
        ddl.prepend("<option value='" + (typeof nullValue == "undefined" ? fng_DdlTypeValue(obj_ddlType) : nullValue) + "' selected >" + fng_DdlTypeText(obj_ddlType) + "</option>");
    }
    if (JsonData) {
        for (var i = 0; i < JsonData.length; i++) {
            var option = $("<option value='" + JsonData[i]["value"] + "'>" + JsonData[i]["text"] + "</option>");
            option.data(JsonData[i]);
            ddl.append(option);
        }
        if (default_value) fng_DefaultValue(default_value, ddl);
        if (oncomplete) oncomplete(ddl, JsonData);
    }
    return ddl;

}
/**
 * fng_ConvertObjectToJson
 * @param object
 * @returns [{"name" : "value"}] - jsonString
 */
function fng_ConvertObjectToJson(object){
	return JSON.stringify(object);
}

/**
 * fng_ConvertJsonToObject
 * @param jsonString
 * @returns object
 */
function fng_ConvertJsonToObject(jsonString){
	return JSON.parse(jsonString);
}
/**
 * Request
 * @param valuename
 * @returns dataString
 * @ex URL : http://localhost:8080?empno=SYC221143
 *     Request("empno") > "SYC221143"
 */
function Request(valuename){
    var rtnval;
    var nowAddress = unescape(location.href);
    var parameters = new Array();
    parameters = (nowAddress.slice(nowAddress.indexOf("?")+1,nowAddress.length)).split("&");
    for(var i = 0 ; i < parameters.length ; i++){
        if(parameters[i].indexOf(valuename) != -1){
            rtnval = parameters[i].split("=")[1];
            if(rtnval == undefined || rtnval == null){
                rtnval = "";
            }
            return rtnval;
        }
    }

}

function fng_JsonToUrlParam(JsonData) {
    try {
        return jQuery.param(JsonData);
    } catch (ex) { return "" }
}

////////////////////파일 업로드////////////////////
function fng_UploadFile(formId, url, callback) {

	var form = $('#' + formId)[0];

    var formData = new FormData(form);
        $.ajax({
           url: url,
           processData: false,
           contentType: false,
           data: formData,
           type: 'POST',
           success: function(result){
        	   console.log(result);
               if(callback) callback(result);
           },
           error : function(result ) {
               console.log(result);
           }
       });
}

//페이지 이동 (모든 페이지 최상위 div id = "container" 로 지정할것)
function movePage(url) {
	$.ajax({
		url : url,
		type : 'POST',
		dataType : "html",
		success : function(data) {
			$('#container').children().remove();
			$('#container').html(data);
		},
		error : function() {
			location.href = url;
		}
	});
}
/**/
jQuery.fn.serializeObject = function() {

	var obj = null;

	try {

	// this[0].tagName이 form tag일 경우

	if(this[0].tagName && this[0].tagName.toUpperCase() == "FORM" ) {

	var arr = this.serializeArray();

	if(arr){

	obj = {};

	jQuery.each(arr, function() {

	// obj의 key값은 arr의 name, obj의 value는 value값

	obj[this.name] = this.value;

	});

	}

	}

	}catch(e) {

	alert(e.message);

	}finally  {}

	return obj;

	};
/**/

//////////////////JQUERY EXTEND////////////////////
jQuery.extend({
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
    fng_Ajax: function (options) {
    	if (g_AjaxCallCount < 0) {
    		g_AjaxCallCount = 0;
    	}

    	g_AjaxCallCount++; // 전역변수 g_AjaxCallCount 횟수를 증가 시킴
    	//console.log("fng_Ajax Start :" + g_AjaxCallCount);

        var ajaxParamDefault = {
            SvcName: "",
            MethodName: "",
            Params: {
            },
            Callback: (function (result) {
            }),
            ErrorCallback: (function (result) {
            }),
            DataType: "json",
            IsASync: true,
            IsBlockProc : true
        };
        var ajaxParam = $.extend({}, ajaxParamDefault, options);
        //parameterWrapper처리

        if(!$.isEmptyObject(ajaxParam.Params))
        {
        	var o_paramWrap = null;
        	if($.isArray(ajaxParam.Params)){

        		o_paramWrap = [];
        		for(var i in ajaxParam.Params){
        			o_paramWrap[i] = {};
        			var j = 1;
	        		$.each(ajaxParam.Params[i], function(key, value){
	        			o_paramWrap[i]["param"+j] = value;
	        			j++;
	        		});
        		}
        	}
        	else{
        		o_paramWrap = {};

        		o_paramWrap = ajaxParam.Params;

        	}
        	ajaxParam.Params = o_paramWrap;

        }
        $.ajax({
        	url: ajaxParam.SvcName + (ajaxParam.MethodName ? "/" + ajaxParam.MethodName : ""),
            data: JSON.stringify( ajaxParam.Params),
            type: 'POST',
            cache: false,
            processData: false,
            contentType: 'application/json',
            timeout: 9393076,
            dataType: ajaxParam.DataType,
            async: ajaxParam.IsASync,
            beforeSend : function(xmlHttpRequest){
            	// ajax request 요청구분 처리.
            	xmlHttpRequest.setRequestHeader("AJAX", "true");
            },
            success: function (response) {
            	if(ajaxParam.Callback) ajaxParam.Callback(response && response.d ? response.d : response);
            	g_AjaxCallCount--; // 전역변수 g_AjaxCallCount 횟수를 감소 시킴
            },
            error: function (response) {
            	if(response){
            		// 세션만료 9999
            		if(response.status && response.status == 9999){
            			/*
            			fng_Error("세션이 만료되었습니다.</br>다시 로그인하여 주십시오.", function(){
            				top.location.href = "/main.do";
            			});*/
            		}
            		// other exceptions
            		else {
            			if(response.responseText && response.responseText.indexOf("<html>") != -1 ){
                    		g_Error_Message = $(response.responseText).text();
                    		//fng_Error(g_Error_Message);
                    	}
            			else if(response.responseJSON){
            				g_Error_Message = response.responseJSON.responseText + "\n\n" + response.responseJSON.stackTrace;
            				//fng_Error(response.responseJSON.message ? response.responseJSON.message : "Error");
            			}
            			else {
            				//fng_Error(response.responseText ? response.responseText : "Error");
            			}
            		}
            	}
            	else { alert("Error"); }

            	g_AjaxCallCount--; // 전역변수 g_AjaxCallCount 횟수를 감소 시킴
            	//console.log("fng_Ajax Error :" + g_AjaxCallCount);
            }
        });
    },
    /**
     * window.open 창 열기
     * @param url
     * @param param
     * @param w
     * @param h
     * @param isCenter
     * @param resizable
     * @param scrollable
     * @param useParentBlock
     * @param closedCallBack
     */
    fng_ShowWindow: function (url, param, w, h, isCenter, resizable, scrollable, useParentBlock, closedCallBack, isNew) {
        // var win;
        var strParam = fng_JsonToUrlParam(param);
        url = url + (url.indexOf("?") != -1 ? "&" : "?") + strParam;
        if (url.indexOf('?') > -1) {
            url = url + "&menuId=" + fng_GetUrlByName("menuId");
        } else {
            url = url + "?menuId=" + fng_GetUrlByName("menuId");
        }
        if (w == null) w = '500';
        if (h == null) h = '400';
        if (typeof(w) == "string") {
        	w = w.indexOf("?") != -1 ? w : (window.screen.width * (parseInt(w.replace("%", ""))) / 100);
        }
        if (typeof(h) == "string") {
        	h = h.indexOf("?") != -1 ? h : ((window.screen.height - 70) * (parseInt(h.replace("%", ""))) / 100);
        }

        var coordinatesObj = $.fng_GetCoordOfEventSrcElement(isCenter, w, h);

        var sFeatures = "width=" + w
                      + ",height=" + h
                      + ",left=" + coordinatesObj.x
                      + ",top=" + coordinatesObj.y
                      + ",resizable=" + (resizable === true ? 'yes' : 'no')
                      + ",scrollbars=" + (scrollable === true ? 'yes' : 'no')
                      + ",toolbar=no,status=no,alwaysRaised=yes"
                      + ",menubar=no";
        var winName = fng_SetReplaceSpChar2(strParam);

        if(isNew) {
        	winName = winName + fn_GetGUID();
        }

        var o_window = window.open("", winName, sFeatures);
        o_window.location = url;
        o_window.focus();
        return o_window;
    }

});