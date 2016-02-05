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
	<title>计划选择</title>
	<link rel="stylesheet" type="text/css" href="themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="themes/icon.css">
	<link rel="stylesheet" type="text/css" href="css/default.css">
	<script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="js/jquery.bgiframe.js"></script>
	<script type="text/javascript" src="js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="js/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="js/common.js"></script>
    <script type="text/javascript" src="core/taskinfo/PlanDef-js.js"></script>
	<script type="text/javascript">
		function queryInfo(){
		    var date=new Date();
			var param="flag="+date.getTime()				
				+"&PLAN_CODE="+escape(escape($.trim($('#idPlanCode').val())))
				+"&PLAN_NAME="+escape(escape($.trim($('#idPlanName').val())))
				+"&REG_ID="+escape(escape($.trim($('#idRegId').val())))
				+"&REG_ENTIRE_ID="+escape(escape($.trim($('#idRegEntireId').val())));		   
			$('#idPlanDef').datagrid('options').url = "listPlanDefForTask.do?"+param;// 改变它的url  
			$("#idPlanDef").datagrid('load');
		}
		function cleardata(){
			$('#queryForm').form('clear');
		}
		
		function retPlanDef(){
			var rows = $('#idPlanDef').datagrid('getSelections');
		 	if(rows.length==0) {
		 		msgShow("提示","请选择计划","info");
		 	}else if(rows.length>1) {
		 		msgShow("提示","只能选择一个计划","info");
		 	}else{
		 		var o = new Object();
		 		o.plan_code=rows[0].PLAN_CODE;
		 		if(!rows[0].PLAN_NAME){
		 			rows[0].PLAN_NAME="";
		 		}
		 		o.plan_name=rows[0].PLAN_NAME+"("+rows[0].PLAN_CODE+")";
		 		window.returnValue=o; 
		 		window.close();
		 	}
		}
	</script>
</head>

<body class="easyui-layout" fit="true">
	    <div region="north" style="height: 100px;position:relative;" title="查询面板"  split="true">  
					<form id="queryForm">
						<table class="formTable" style="width:95%;">
				<col  width="20%" class="leftCol"/>
				<col width="30%" >
				<col  width="20%" class="leftCol"/>
				<col width="30%" >
							<tr>
								<td>计划编号</td>
								<td>
									<input type="text" name="PLAN_CODE" id="idPlanCode" maxlength="8" />
								</td>
								<td>计划名称</td>
								<td>
									<input type="text" name="PLAN_NAME" id="idPlanName" maxlength="40" />
								</td>
							</tr>
							<tr>
							   <td>分支机构</td>
								<td>
									<input type="hidden" class="easyui-validatebox" name="REG_ID" id="idRegId" maxlength="8" />
									<input type="hidden" class="easyui-validatebox" name="REG_ENTIRE_ID" id="idRegEntireId" />
									<input type="text" class="easyui-validatebox" style="background-color: #EEEEEE"  name="REG_NAME" id="idRegName" readonly="readonly" size="15"/>
									<input id="idChoose" type="button" class="btn_grid" value="选择" onclick="queryReg('idRegId','idRegName','idRegEntireId')"/>
								</td>
							<td colspan="2" align="center">
							     <input id="idQuery" type="button" class="btn_grid" value=" 查 询 " onclick="queryInfo()"/>
							     <input id="idReset" type="button" class="btn_grid" value=" 重 置 " onclick="cleardata()"/>
							</td>
							</tr>
						</table>
					</form>
	     </div>
		<div region="center"  >  
			<table id="idPlanDef" ></table>
	    </div>
	      <div region="south" style="text-align:right;height: 30px;position:relative;background:url('<%=basePath%>images/indexbg.png') repeat;">  
	     	<a class="easyui-linkbutton" iconCls="icon-ok" href="javascript:void(0)" onclick="retPlanDef()">确认</a>
			<a class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="javascript:window.close()">取消</a>
	     </div>
</body>

</html>
