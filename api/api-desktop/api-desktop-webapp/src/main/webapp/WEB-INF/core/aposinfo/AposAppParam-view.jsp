<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<meta http-equiv="X-UA-Compatible" content="IE=8">
<html>
<head>
  <base href="<%=basePath%>">
  <base target="_self">
	<title>应用参数查看</title>
	<link rel="stylesheet" type="text/css" href="themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="themes/icon.css">
	<link rel="stylesheet" type="text/css" href="css/default.css">
	<script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="js/jquery.bgiframe.js"></script>
	<script type="text/javascript" src="js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="js/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="js/common.js"></script>
    <script type="text/javascript" src="core/aposinfo/AposAppParam-view.js"></script>
	<script type="text/javascript">
		function queryInfo(){
		    var date=new Date();
		    var PARAM_GROUP = escape(escape($('#idParamGroup').combobox('getValue')));
		    var APOS_ID=escape(escape($('#idAposId').val()));
		    var APP_ID=escape(escape($('#idAppId').val()));
		    var PARAM_VALUE = escape(escape($('#idParamValue').val()));
			var param="flag="+date.getTime()+"&APOS_ID="+APOS_ID+"&APP_ID="+APP_ID+"&PARAM_GROUP="+PARAM_GROUP+"&PARAM_VALUE="+PARAM_VALUE;
			$('#idAposAppParam').datagrid('options').url = "listAposAppParam.do?"+param;
			$("#idAposAppParam").datagrid('load');
		}
		function cleardata(){
			var value = $('#idParamGroup').combobox('getData')[0].ITEMCODE;
			$('#idParamGroup').combobox('select',value);
			$('#idParamValue').val('');
		}
	</script>
</head>

<body class="easyui-layout" fit="true">
	    <div region="north" style="height:80px;position:relative;" title="查询面板"  split="true"> 
	   		<input type="hidden" name="APOS_ID" id="idAposId" value=""/> 
	   		<input type="hidden" name="APP_ID" id="idAppId" value=""/>
			<form id="ff">
			 <table class="formTable" style="width:95%;">
			 	<col width="200px" />
				<col width="200px" />
				<col width="150px" />

				<tr>
				  <td >参数组
				    <select id="idParamGroup" class="easyui-combobox" name="PARAM_GROUP" style="width:145px;" panelHeight="100px">
					</select>
				  </td>
				  <td >参数值
				  	 <input type="text" id="idParamValue" name="PARAM_VALUE" value=""/>
				  </td>
				  <td>
						<input id="idQuery" type="button" class="btn_grid" value=" 查 询 " onclick="queryInfo()"/>
						<input id="idReset" type="button" class="btn_grid" value=" 重 置 " onclick="cleardata()"/>
				 </td>
				</tr>
			</table>
			</form>
	     </div>
	     
		<div region="center"  >  
			<table id="idAposAppParam" ></table>
	    </div>
		<div region="south"   style="text-align:right;" class="toolbarHeader">
			<a class="easyui-linkbutton" iconCls="icon-ok" href="javascript:void(0)" onclick="javascript:window.close()">返 回</a>
		</div>	  	    
</body>
</html>
