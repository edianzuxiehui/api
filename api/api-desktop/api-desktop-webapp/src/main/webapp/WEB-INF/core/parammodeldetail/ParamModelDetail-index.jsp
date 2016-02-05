<%@ page language="java" pageEncoding="UTF-8"%>
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
<title>参数模板明细修改</title>
<link rel="stylesheet" type="text/css" href="themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="themes/icon.css">
<link rel="stylesheet" type="text/css" href="css/default.css">
<script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="js/jquery.bgiframe.js"></script>
<script type="text/javascript" src="js/jquery.easyui.min.js"></script>
<script type="text/javascript" src="js/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="js/common.js"></script>
<script type="text/javascript" src="core/parammodeldetail/ParamModelDetail-js.js"></script>
<script type="text/javascript">
        setModuleNameAndId();
		function doEdit(){
			var ids=updateValidate("idParamModelDetail");
		    if(ids){
		    	var retValue=openDialogFrame("<%=basePath%>core/parammodeldetail/ParamModelDetail-edit.jsp",ids,"600","300");
				if(retValue=="true"){
					msgShow("修改","修改成功!","info");
					flashTable("idParamModelDetail");
				}else if(retValue=="false"){
			       msgShow("修改","修改失败!","error");
			    }
		    }
			
		}
		
		function doDel(){
		 deleteNoteById("idParamModelDetail","delParamModelDetail.do", "");
		}
		
		function queryInfo(){
		    var date=new Date();
		    var PARAM_MODEL_ID=$('#PARAM_MODEL_ID').val();
		    //var PARAM_GROUP = $('#idParamGroup').combobox('getValue');
		    var PARAM_ID = $('#idParamId2').val();
		    var PARAM_NAME =$('#idParamName').val();
		    var PARAM_VALUE=$('#idParamValue').val();
		    PARAM_VALUE= escape(escape(PARAM_VALUE));
		    PARAM_NAME = escape(escape(PARAM_NAME));
			var param="flag="+date.getTime()+"&PARAM_MODEL_ID="+PARAM_MODEL_ID+"&PARAM_ID="+PARAM_ID+"&PARAM_VALUE="+PARAM_VALUE+"&PARAM_NAME="+PARAM_NAME;
			$('#idParamModelDetail').datagrid('options').url = "listParamModelDetail.do?"+param; // 改变它的url  
			   $("#idParamModelDetail").datagrid('load');
		}
		function cleardata(){
			//$('#ff').form('clear');//PARAM_MODEL_ID不能清除
			$('#idParamId2').val("");
			$('#idParamName').val("");
			$('#idParamValue').val("");
			queryInfo();
		}
	</script>
</head>

<body class="easyui-layout" fit="true">
	<div region="north" style="height: 65px; position: relative;" title=""
		split="true">
		<form id="ff">
			<table>
				<input type="hidden" class="readonly" readonly id="dataType"
					name="dataType" size="10" class="readonly" readonly>
				<input type="hidden" name="valueLen" id="idValueLen" size="10"
					class="readonly" readonly>
				<input type="hidden" name="PARAM_MODEL_ID" id="PARAM_MODEL_ID"
					value="">
				<input type="hidden" name="APP_ID" id="APP_ID" value="">
				<input type="hidden" id="PARAM_VALUE_ENCODING"
					name="PARAM_VALUE_ENCODING" size="15">
				<!-- 为解决添加中文乱码 -->
				<tr style="height: 25px;">
					<td style="text-align: center;">查询参数编号</td>
					<td><input type="text"  id="idParamId2" style="width:125px;" maxlength="8" size="15"/></td>
					<td style="text-align: center;">查询参数名称</td>
					<td><input type="text"  id="idParamName" style="width:125px;"  maxlength="40" size="15"/></td>
					<td style="text-align: center;">查询参数值</td>
					<td>
						<input type="text"  id="idParamValue" style="width:115px;"  maxlength="40" size="15"/>
						<input id="idQuery" type="button" class="btn_grid" value=" 查 询 " onclick="queryInfo()" />
						<input id="idReset" type="button" class="btn_grid" value=" 重 置 " onclick="cleardata()"/>
					</td>
					<td>
					</td>
				</tr>
				<tr>
					<td style="width:80px;vertical-align: middle;text-align: center;">参数组</td>
					<td style="width:125px;"><select id="idParamGroup" class="easyui-combobox"
						name="PARAM_GROUP" style="width: 125px;" panelHeight="auto">
					</select></td>
					<td style="width:80px;vertical-align: middle;text-align: center;">新增参数项</td>
					<td style="width:125px;"><select id="idParamId" class="easyui-combobox"
						name="PARAM_ID" style="width: 130px;" panelHeight="300px">
					</select></td>
					<td style="width:80px;text-align: center;">新增参数值</td>
					<td style="width:230px"><input type="text" class="easyui-validatebox"
						required="true" validType="maxLen[$('#idValueLen').val()]"
						id="PARAM_VALUE" name="PARAM_VALUE" size="18" maxlength="1024" />
						<a id="idShowTypeAndLen"></a></td>
					<td style="text-align: right;"><input type="button"
						id="Submit2" class="btn_grid"
						name="Submit2" value=" 增 加 " onClick="addParamModelDetail()">
					</td>
				</tr>
			</table>
		</form>
	</div>

	<div region="center">
		<table id="idParamModelDetail"></table>
	</div>
	<div region="south" style="text-align: right;" class="toolbarHeader">
		<a class="easyui-linkbutton" iconCls="icon-ok"
			href="javascript:void(0)" onclick="javascript:window.close()">确认</a>
	</div>
</body>

</html>
