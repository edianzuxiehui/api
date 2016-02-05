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
	<title>批量增加参数</title>
	<link rel="stylesheet" type="text/css" href="themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="themes/icon.css">
	<link rel="stylesheet" type="text/css" href="css/default.css">
	<script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="js/jquery.bgiframe.js"></script>
	<script type="text/javascript" src="js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="js/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="js/common.js"></script>
    <script type="text/javascript" src="core/parammodeldetail/ParamItem-js.js"></script>
    <script type="text/javascript" src="js/jquery.json-2.3.min.js"></script>
	<script type="text/javascript">
		setModuleNameAndId('queryForm');
		function queryInfo(){
		    var date=new Date();
		    var idParamGroup = $('#idParamGroup').combobox('getValue');
			if($.trim(idParamGroup)===""){
			    	msgShow("批量增加参数","请选择参数组","请选择参数组!","info");
			    	return false;
			}
		    var param="flag="+date.getTime()+"&PARAM_ID="+escape(escape($.trim($('#idParamId').val())))+"&PARAM_NAME="+escape(escape($.trim($('#idParamName').val())))+"&DATA_TYPE="+escape(escape($.trim($('#idDataType').val())))+"&VALUE_LEN="+$('#idValueLen').val()+"&PARAM_GROUP="+idParamGroup+"&DEF_VALUE="+escape(escape($.trim($('#idDefValue').val())))+"&DESC_TXT="+escape(escape($.trim($('#idDescTxt').val())));			   
			$('#idParamItem').datagrid('options').url = "queryParamItemNotInParamModelDetailForPage.do?"+param;// 改变它的url  
			$("#idParamItem").datagrid('load');
		}
		
		function cleardata(){
			var paramModel = $('#PARAM_MODEL_ID').val();
			var paramGroup = $('#idParamGroup').combobox('getValue');
			$('#queryForm').form('clear');
			$('#PARAM_MODEL_ID').val(paramModel);
			$('#idParamGroup').combobox('setValue',paramGroup);
		}
	</script>
</head>

<body class="easyui-layout" fit="true">
	    <div region="north" style="height:50px;position:relative;" title=""  split="true">  
			<form id="queryForm">
				<table class="formTable" style="width:95%;">
				<col  width="8%" align="right"/>
				<col width="18%" >
				<col  width="8%" align="right"/>
				<col width="18%" >
				<col  width="8%" align="right"/>
				<col width="18%" >
				<col width="22%" >
				<input type="hidden" name="PARAM_MODEL_ID" id="PARAM_MODEL_ID" value="">
							<tr>
								<td>参数组别</td>
								<td>
									<select id="idParamGroup" class="easyui-combobox" name="PARAM_GROUP" style="width:145px;" panelHeight="auto">
									</select>
									<!-- <input type="text" name="PARAM_GROUP" id="idParamGroup" maxlength="2" /> -->
								</td>
								<td>参数项ID</td>
								<td>
									<input type="text" name="PARAM_ID" id="idParamId" maxlength="8" size="15"/>
								</td>
								<td>参数名称</td>
								<td>
									<input type="text" name="PARAM_NAME" id="idParamName" maxlength="40" size="15"/>
								</td>
								<td  align="center">
								     <input id="idQuery" type="button" class="btn_grid" value=" 查 询 " onclick="queryInfo()"/>
								     <input id="idReset" type="button" class="btn_grid" value=" 重 置 " onclick="cleardata()"/>
								</td>
							</tr>
						</table>
					</form>
	     </div>
		<div region="center" border="false" >  
			<table id="idParamItem" ></table>
	    </div>
					<div region="south"  border="false" style="text-align:right;" class="toolbarHeader">
						<a class="easyui-linkbutton" iconCls="icon-ok" href="javascript:void(0)" onclick="addParamModelDetails()">确认</a>
						<a class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="javascript:window.close()">取消</a>
					</div>	    
</body>

</html>
