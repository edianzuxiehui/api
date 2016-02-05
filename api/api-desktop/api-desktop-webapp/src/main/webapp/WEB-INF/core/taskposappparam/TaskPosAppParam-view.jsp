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
	<title>任务参数明细查看</title>
	<link rel="stylesheet" type="text/css" href="themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="themes/icon.css">
	<link rel="stylesheet" type="text/css" href="css/default.css">
	<script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="js/jquery.bgiframe.js"></script>
	<script type="text/javascript" src="js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="js/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="js/common.js"></script>
    <script type="text/javascript" src="core/taskposappparam/TaskPosAppParam-view-js.js"></script>
	<script type="text/javascript">
		function queryInfo(){
		    var date=new Date();
		    var taskSysId=$('#idTaskSysId').val();
		    var appId=$('#idAppId').val();
		    var PARAM_GROUP = $('#idParamGroup').val();
		    var PARAM_ID = $('#idParamId').val();
		    //var PARAM_VALUE=$('#PARAM_VALUE').val();
		    //alert(escape(PARAM_VALUE));alert(escape(escape(PARAM_VALUE)));
		    //PARAM_VALUE= escape(escape(PARAM_VALUE));
			var param="flag="+date.getTime()+"&TASK_SYS_ID="+taskSysId+"&APP_ID="+appId+"&PARAM_GROUP="+PARAM_GROUP+"&PARAM_ID="+PARAM_ID;//+"&PARAM_VALUE="+PARAM_VALUE;
			$('#idTaskPosAppParam').datagrid('options').url = "listTaskPosAppParam.do?"+param; // 改变它的url  
			$("#idTaskPosAppParam").datagrid('load');
		}
		function cleardata(){
			$('#ff').form('clear');
		}
	</script>
</head>

<body class="easyui-layout" fit="true">
	    <div region="north" style="height:80px;position:relative;" title="查询面板"  split="true"> 
			<input type="hidden" name="TASK_SYS_ID" id="idTaskSysId"/>
			<input type="hidden" name="APP_ID" id="idAppId"/>
			<form id="ff">
			 <table class="formTable" style="width:95%;">
			 	<col  width="35%" class="leftCol"/>
				<col width="35%" align="center">
				<col  width="30%" />
				<tr>
				  <td >参数组
					<select  name="PARAM_GROUP" id="idParamGroup"  style="width:135px;" onchange="changeParamByGroup(this.value)">
			        </select>
				  </td>
				  <td >参数项
					 <select  name="PARAM_ID" id="idParamId"  style="width:135px;" >
			        </select>
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
			<table id="idTaskPosAppParam" ></table>
	    </div>
					<div region="south"   style="text-align:right;" class="toolbarHeader">
						<a class="easyui-linkbutton" iconCls="icon-ok" href="javascript:void(0)" onclick="javascript:window.close()">确认</a>
					</div>	  	    
</body>

</html>
