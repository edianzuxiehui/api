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
	<title>终端应用参数</title>
	<link rel="stylesheet" type="text/css" href="themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="themes/icon.css">
	<link rel="stylesheet" type="text/css" href="css/default.css">
	<script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="js/jquery.bgiframe.js"></script>
	<script type="text/javascript" src="js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="js/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="js/common.js"></script>
    <script type="text/javascript" src="core/aposinfo/AposAppParam.js"></script>
	<script type="text/javascript">

		function doEdit(){
			var ids=updateValidate("idParamModelDetail");
		    if(ids){
		    	var retValue=openDialogFrame("<%=basePath%>core/parammodeldetail/ParamModelDetail-edit.jsp",ids,"600","300");
				if(retValue=="true"){
					msgShow("修改","修改成功!","info");
					flashTable("idAposAppParam");
				}else if(retValue=="false"){
			       msgShow("修改","修改失败!","error");
			    }
		    }
			
		}
		
		function doDel(){
		 	deleteNoteById("idAposAppParam","delParamModelDetail.do", "");
		}
		
		function queryInfo(){
		    var date=new Date();
		    var APOS_ID = escape(escape($('#idAposId').val()));
		    var APP_ID = escape(escape($('#idAppId').val()));
		    var PARAM_GROUP=escape(escape($('#idParamGroup').combobox('getValue')));
		    //var PARAM_ID = escape(escape($('#idParamId').combobox('getValue')));
		    var PARAM_VALUE=escape(escape($('#idParamValue').val()));
			var param="flag="+date.getTime()+"&APOS_ID="+APOS_ID+"&APP_ID="+APP_ID+"&PARAM_GROUP="+PARAM_GROUP+"&PARAM_VALUE="+PARAM_VALUE;
			$('#idAposAppParam').datagrid('options').url = "listAposAppParam.do?"+param; // 改变它的url  
			$("#idAposAppParam").datagrid('load');
		}
		function cleardata(){
			$('#idParamGroup').combobox('select',$('#idParamGroup').combobox('getValue'));
			$('#idDataType').val('');
			$('#idDataTypeAlias').val('');
			$('#idValueLen').val('');
			$('#idDefValue').val('');
			$('#idParamValue').val('');
		}
	</script>
</head>

<body class="easyui-layout" fit="true">
	    <div region="north" style="height:140px;position:relative;" title="查询面板"  split="true">  
			<form id="ff" method="post">
			 <table class="formTable" style="width:95%;">
			 					
				<tr>
				  <td>参数组</td>
				  <td>
				  	<select id="idParamGroup" class="easyui-combobox" name="PARAM_GROUP" style="width:145px;" panelHeight="100px">
					</select>
					<input type="hidden" name="APOS_ID" id="idAposId" value="">
					<input type="hidden" name="APP_ID" id="idAppId" value="">
				  </td>
				  <td>参数项</td>
				  <td>
					 <select id="idParamId" class="easyui-combobox easyui-validatebox" required="true" name="PARAM_ID" style="width:145px;" panelHeight="150px" editable="false">
					 </select>
				  </td>
				  <td>参数值</td>
				  <td style="width:250px;">
				  	<input type="text" id="idParamValue" name="PARAM_VALUE" size="30" >
				  </td>
				  <td>
				  	<input id="idQuery" type="button" class="btn_grid" value=" 查 询 " onclick="queryInfo()"/>
					<input id="idReset" type="button" class="btn_grid" value=" 重 置 " onclick="cleardata()"/>
				  </td>
				</tr>
				<tr>
				  <td >类型</td>
				  <td>
				  	<input type="hidden" id="idDataType" name="DATA_TYPE" value=""/>
				  	<input type="text" id="idDataTypeAlias" name="DATA_TYPE_ALIAS" size="20" class="readonly easyui-validatebox" required="true" readonly>
				  </td>
				  <td >长度</td>
				  <td>
				  	<input type="text"  name="VALUE_LEN" id="idValueLen" size="20" class="readonly easyui-validatebox" required="true" readonly>
				  </td>
				  <td>默认值</td>
				　<td style="width:250px;">
				  	<input type="text" class="easyui-validatebox" required="true" validType="maxLen[$('#idValueLen').val()]" id="idDefValue" name="DEF_VALUE" size="30" maxlength="1024" />
				  </td>
				  <td>
				  	<input type="button" id="Submit2" class="btn_grid" name="Submit2" value=" 增 加 " onClick="addAposAppParam()" >
				  </td>
				</tr>
				<tr>
					<td colspan="7">
						<span style="color:red;">备注：根据参数组与参数值查询，根据参数项与默认值增加参数设置</span>
					</td>
				</tr>
			</table>
			</form>
	     </div>
	     
		<div region="center"  >  
			<table id="idAposAppParam" ></table>
	    </div>
		<div region="south"   style="text-align:right;" class="toolbarHeader">
			<a class="easyui-linkbutton" iconCls="icon-ok" href="javascript:void(0)" onclick="javascript:window.close()">确 认</a>
		</div>	  	    
</body>

</html>
