<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
var test;
$(document).ready(function (){
var objs = [];
objs.push({VALUE:"t", TEXT:"e"});

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
var ajaxOptions = {  SvcName: "Common"
		           , MethodName: "getItemCode.do"
		           , Params: {param: param}
		           , Callback: function(result){
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

      <!-- Main hero unit for a primary marketing message or call to action -->
      <div class="hero-unit">
        <h1>Hello, world!</h1>
        <p>This is a template for a simple marketing or informational website. It includes a large callout called the hero unit and three supporting pieces of content. Use it as a starting point to create something more unique.</p>
        <p><a href="#" class="btn btn-primary btn-large">Learn more »</a></p>
        <select id="testdrop"></select>
      </div>

      <!-- Example row of columns -->
      <div class="row">
        <div class="span4">
          <h2>Heading</h2>
          <p>Donec id elit non mi porta gravida at eget metus. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Etiam porta sem malesuada magna mollis euismod. Donec sed odio dui. </p>
          <p><a class="btn" href="#">View details »</a></p>
        </div>
        <div class="span4">
          <h2>Heading</h2>
          <p>Donec id elit non mi porta gravida at eget metus. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Etiam porta sem malesuada magna mollis euismod. Donec sed odio dui. </p>
          <p><a class="btn" href="#">View details »</a></p>
       </div>
        <div class="span4">
          <h2>Heading</h2>
          <p>Donec sed odio dui. Cras justo odio, dapibus ac facilisis in, egestas eget quam. Vestibulum id ligula porta felis euismod semper. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus.</p>
          <p><a class="btn" href="#">View details »</a></p>
        </div>
      </div>

      <hr>



    </div>
</div>