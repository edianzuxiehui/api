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
	<title>计划详细信息</title>
	<link rel="stylesheet" type="text/css" href="<%=basePath%>themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>themes/icon.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>css/default.css">
	<script type="text/javascript" src="<%=basePath%>js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.bgiframe.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/common.js"></script>
	<script type="text/javascript" src="core/plandef/PlanDef-js.js"></script>
	<script type="text/javascript">
	   var k=window.dialogArguments; 
		  if(k.par){
		   
		  	var param={"PLAN_CODE":k.par};
		  	//var param="PLAN_CODE="+k.par;
		  	//alert(param);
			$.getJSON("queryPlanDef.do",param,function(data){
			$.each(data.rows,function(idx,item){
			$("#idPlanCode").val($.trim(item.PLAN_CODE));
			$("#idPlanName").val($.trim(item.PLAN_NAME));
			$("#idTypeName").val($.trim(item.TYPE_NAME));
			$("#idStatusName").val($.trim(item.STATUS_NAME));
			$("#idCreateDate").val($.trim(item.CREATE_DATE));
			$("#idValidDate").val($.trim(item.VALID_DATE));
			$("#idRegName").val($.trim(item.REG_NAME));
			$("#idDescTxt").val($.trim(item.DESC_TXT));
			//$("#idRegId").val($.trim(item.REG_ID));
			//$("#idRegName").val($.trim(item.REG_NAME)+"("+$.trim(item.REG_ID)+")");
			
				});
            }); 
            
         }
	
	//应用信息
	$(function(){
		     var parammodelId=$('#idPlanCode').val();
		     //alert(parammodelId);
			$('#idViewPlanAppInfo').datagrid({
				iconCls:'icon-save',
				fit:true,
				nowrap: false,
				striped: true,
				collapsible:true,
				url:'listPlanAppInfo.do',
				queryParams:param,
				sortName: 'KEYID',
				sortOrder: 'desc',
				remoteSort: false,
				idField:'KEYID',
				pageSize:20,
				pagination:false,
				rownumbers:true,
				columns:[[
			{title:'应用编号',field:'APP_ID',align:'center',width:80,sortable:true},
			{title:'应用名称',field:'APP_NAME',align:'center',width:100,sortable:true},
			{title:'应用版本',field:'APP_VER',align:'center',width:80,sortable:true},
			{title:'主应用标志',field:'MASTER_FLAG',align:'center',width:80,sortable:true},
			{title:'参数标志',field:'PARAM_FLAG',align:'center',width:60,sortable:true},
			{title:'应用标志',field:'APP_FLAG',align:'center',width:60,sortable:true},
			{title:'更新时间',field:'UPDATE_DATE',align:'center',width:150,formatter:function(value,rowData,rowIndex){
			             var data;
			             if(rowData.UPDATE_DATE=="0000-00-00 00:00:00"){
			             data="立即更新";
			             } else {
			               data=rowData.UPDATE_DATE;
			             }
			             return data;
			             }},
			{title:'参数模板',field:'PARAM_MODEL_ID',align:'center',width:100,formatter:function(value,rowData,rowIndex){
			             var data="";
			             if(rowData.PARAM_MODEL_ID!=""&&rowData.PARAM_MODEL_ID!=null){
			             data='<a id="modelId" style="color:blue;" href="javascript:paramModelDefView(\''+rowData.PARAM_MODEL_ID+'\',\''+rowData.APP_ID+'\')\">'+rowData.PARAM_MODEL_ID+'</a>';
			             }
			             return data;
			             }}

				]]
			});
			
	
		});
	
	
	//分配信息
		$(function(){
		     var parammodelId=$('#idPlanCode').val();
		     //alert(parammodelId);
			$('#idtaskassigninfo').datagrid({
				iconCls:'icon-save',
				fit:true,
				nowrap: false,
				striped: true,
				collapsible:true,
				url:'viewTaskInfoByPlan.do',
				queryParams:param,
				sortName: 'KEYID',
				sortOrder: 'desc',
				remoteSort: false,
				idField:'KEYID',
				pagination:false,
				rownumbers:true,
				columns:[[
			{title:'应用终端号',field:'APOS_ID',align:'center',width:80,sortable:true},
			{title:'物理终端号',field:'DEV_ID',align:'center',width:100,sortable:true},
			{title:'创建时间',field:'CREATE_DATE',align:'center',width:150,sortable:true},
			{title:'状态',field:'STATUS_NAME',align:'center',width:100,sortable:true},
			{title:'完成时间',field:'COMP_DATE',align:'center',width:150,sortable:true},
			{title:'操作员',field:'NAME',align:'center',width:100,sortable:true}

				]]
			});
			
	
		});
	
	
	</script>
  </head>
  
  <body class="easyui-layout" fit="true">
  <div region="north"  title="详细信息" style="height: 550px">
  <div id="tt" class="easyui-tabs" tools="#tab-tools" fit="true">
		<div  title="基本信息" tools="#p-tools" style="padding:20px;">
			<table class="formTable" fit="true">
				<col  width="55%" class="leftCol"/>
				<col width="45%" >



							<tr>
								<td>计划编号</td>
								<td>
									<input type="text" class="easyui-validatebox"  readonly="readonly" required="true"   name="PLAN_CODE" id="idPlanCode" maxlength="10" style="background-color: #EEEEEE;"/>
								</td>
								
							</tr>
							
							<tr>
								<td>计划名称</td>
								<td>
									<input type="text" class="easyui-validatebox"  readonly="readonly" required="true"  name="PLAN_NAME" id="idPlanName" maxlength="30"   />
								</td>
							</tr>
							<!-- 
							<tr>
								<td>计划类型</td>
								<td>
									<input type="text" class="easyui-validatebox"  readonly="readonly" required="true"  name="TYPE_NAME" id="idTypeName" maxlength="30"   />
								</td>
							</tr>
							 -->
							<tr>
								<td>计划状态</td>
								<td>
									<input type="text" class="easyui-validatebox" readonly="readonly" required="true"  name="STATUS_NAME" id="idStatusName" maxlength="30"   />
								</td>
							</tr>
							<tr>
								<td>创建时间</td>
								<td>
									<input type="text" class="easyui-validatebox" readonly="readonly"  readonly  name="CREATE_DATE" id="idCreateDate" maxlength="30"   />
								</td>
							</tr>
							<tr>
								<td>计划结束时间</td>
								<td>
									<input type="text" class="easyui-validatebox" readonly="readonly"    name="VALID_DATE" id="idValidDate" maxlength="30"   />
								</td>
							</tr>
							<tr>
								<td>分支机构</td>
								<td>
									<input type="text" class="easyui-validatebox"  readonly="readonly"   name="REG_NAME" id="idRegName" maxlength="30"   />
								</td>
							</tr>
							<tr>
							<td>备注</td>
								<td>
									<textarea  rows="6" cols="40" class="easyui-validatebox" readonly="readonly"    name="DESC_TXT" id="idDescTxt" maxlength="100"   ></textarea>
								</td>
							</tr>																														
						</table>
		</div>
		<div title="应用信息" closable="true" style="padding:20px;" cache="false" href="">
			<table id="idViewPlanAppInfo" ></table>
		</div>
		<div title="分配信息" iconCls="icon-reload" closable="true" style="padding:20px;">
			<table id="idtaskassigninfo" >

			</table>
		</div>
		</div>
		</div>
				<div region="center"   style="text-align:right;" class="toolbarHeader">
						<a class="easyui-linkbutton" iconCls="icon-ok" href="javascript:void(0)" onclick="javascript:window.close()">确认</a>
						<a class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="javascript:window.close()">取消</a>
					</div>
  </body>
</html>
