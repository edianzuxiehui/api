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
	<title>任务参数明细修改</title>
	<link rel="stylesheet" type="text/css" href="themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="themes/icon.css">
	<link rel="stylesheet" type="text/css" href="css/default.css">
	<script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="js/jquery.bgiframe.js"></script>
	<script type="text/javascript" src="js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="js/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="js/common.js"></script>
    <script type="text/javascript" src="core/taskposappparam/TaskPosAppParam-js.js"></script>
	<script type="text/javascript">
		setModuleNameAndId();
		function queryInfo(){
		    var date=new Date();
		    var taskSysId=$('#idTaskSysId').val();
		    var appId=$('#idAppId').val();
		    var PARAM_GROUP = $('#idParamGroup').combobox('getValue');
		    var PARAM_ID = $('#idParamId').combobox('getValue');
		    var PARAM_VALUE=$('#PARAM_VALUE').val();
		    PARAM_VALUE= escape(escape(PARAM_VALUE));
			var param="flag="+date.getTime()+"&TASK_SYS_ID="+taskSysId+"&APP_ID="+appId+"&PARAM_GROUP="+PARAM_GROUP+"&PARAM_ID="+PARAM_ID+"&PARAM_VALUE="+PARAM_VALUE;
			$('#idTaskPosAppParam').datagrid('options').url = "listTaskPosAppParam.do?"+param; // 改变它的url  
			$("#idTaskPosAppParam").datagrid('load');
		}
		function cleardata(){
			$('#idParamId').combobox('setValue','');
		}
	</script>
</head>

<body class="easyui-layout" fit="true">
	    <div region="north" style="height:85px;position:relative;" title="查询面板"  split="true">  
			<form id="ff">
			 <table ><!-- class="formTable" style="width:95%;" -->
			 	<col  width="8%" align="right"/>
				<col width="14%" >
			    <col  width="8%" align="right"/>
				<col width="14%" >
				<col width="8%" align="right"/>
				<col  width="24%" />
				<col width="24%" align="left"/>
					<input type="hidden" name="TASK_SYS_ID" id="idTaskSysId"/>
					<input type="hidden" name="PLAN_CODE" id="idPlanCode"/>
					<input type="hidden" name="APOS_ID" id="idAposId"/>
					<input type="hidden" name="APP_ID" id="idAppId"/>
					<input type="hidden" name="REG_ID" id="idRegId"/>	
					<input type="hidden" id="dataType" name="dataType">
				    <input type="hidden"  name="valueLen" id="idValueLen">
					<input type="hidden" id="PARAM_VALUE_ENCODING" name="PARAM_VALUE_ENCODING"><!-- 为解决添加中文乱码 -->				
				<tr>
				  <td >参数组</td>
				  <td>
				    <select id="idParamGroup" class="easyui-combobox" name="PARAM_GROUP" style="width:145px;" panelHeight="auto">
					</select>
				  </td>
				  <td >参数项</td>
				  <td>
					 <select id="idParamId" class="easyui-combobox" name="PARAM_ID" style="width:145px;" panelHeight="300px">
					 </select>
				  </td>
				 
				　<td >参数值</td>
				  <td>
				  	<input type="text" class="easyui-validatebox" required="true" validType="maxLen[$('#idValueLen').val()]" id="PARAM_VALUE" name="PARAM_VALUE" size="15" maxlength="1024" />
				  	<a id="idShowTypeAndLen"></a>
				  </td>
				  <td>
				  	<input type="button" id="Submit2" class="btn_grid" name="Submit2" value=" 增 加 " onClick="addTaskParamDetail()" >
					<input id="idQuery" type="button" class="btn_grid" value=" 查 询 " onclick="queryInfo()"/>
				  </td>
				</tr>
			</table>
			</form>
	     </div>
	     
		<div region="center" border="false" >  
			<table id="idTaskPosAppParam" ></table>
	    </div>
					<div region="south"  border="false" style="text-align:right;" class="toolbarHeader">
						<a class="easyui-linkbutton" iconCls="icon-ok" href="javascript:void(0)" onclick="javascript:window.close()">确认</a>
					</div>	  	    
</body>

</html>
