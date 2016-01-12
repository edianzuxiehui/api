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
	<title></title>
	<link rel="stylesheet" type="text/css" href="themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="themes/icon.css">
	<link rel="stylesheet" type="text/css" href="css/default.css">
	<script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="js/jquery.bgiframe.js"></script>
	<script type="text/javascript" src="js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="js/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="js/Toolbar.js"></script>
    <script type="text/javascript" src="js/common.js"></script>
    <script type="text/javascript" src="core/planappinfo/PlanAppInfo-js.js"></script>
	<script type="text/javascript">
		function doNew(){
			var retValue=openDialogFrame("<%=basePath%>core/planappinfo/PlanAppInfo-add.jsp","","600","300");
			if(retValue=="true"){
				msgShow("新增","新增成功!","info");
				flashTable("idPlanAppInfo");
			}else if(retValue=="false"){
			   msgShow("新增","新增失败!","error");
			}
		}
		
		
		function doEdit(){
			var ids=updateValidate("idPlanAppInfo");
		    if(ids){
		    	var retValue=openDialogFrame("<%=basePath%>core/planappinfo/PlanAppInfo-edit.jsp",ids,"600","300");
				if(retValue=="true"){
					msgShow("修改","修改成功!","info");
					flashTable("idPlanAppInfo");
				}else if(retValue=="false"){
			       msgShow("修改","修改失败!","error");
			    }
		    }
			
		}
		
		function doDel(){
		 deleteNoteById("idPlanAppInfo","delPlanAppInfo.do", "");
		}
		
		function queryInfo(){
		       var date=new Date();
			var param="flag="+date.getTime()+"&PLAN_CODE="+escape(escape($.trim($('#idPlanCode').val())))+"&APP_ID="+escape(escape($.trim($('#idAppId').val())))+"&APP_VER="+escape(escape($.trim($('#idAppVer').val())))+"&PARAM_MODEL_ID="+escape(escape($.trim($('#idParamModelId').val())))+"&UPDATE_DATE="+escape(escape($.trim($('#idUpdateDate').val())))+"&APP_UPDATE_FLAG="+escape(escape($.trim($('#idAppUpdateFlag').val())))+"&PARAM_UPDATE_FLAG="+escape(escape($.trim($('#idParamUpdateFlag').val())))+"&MASTER_APP_FLAG="+escape(escape($.trim($('#idMasterAppFlag').val())))+"&REG_ID="+escape(escape($.trim($('#idRegId').val())));			   $('#idPlanAppInfo').datagrid('options').url = "listPlanAppInfo.do?"+param;// 改变它的url  
			   $("#idPlanAppInfo").datagrid('load');
		}
		function cleardata(){
			$('#queryForm').form('clear');
		}
	</script>
</head>

<body class="easyui-layout" fit="true">
	    <div region="north" style="height: 100px;position:relative;" title="查询面板"  split="true">  
					<form id="queryForm">
						<table class="formTable" style="width:95%;">
				<col  width="50px" class="leftCol"/>
				<col width="250px" >

				<col  width="50px" class="leftCol"/>
				<col width="250px" >

				<col  width="50px" class="leftCol"/>
				<col width="250px" >

							<tr>
								<td>计划编号</td>
								<td>
									<input type="text" name="PLAN_CODE" id="idPlanCode" maxlength="8" />
								</td>
								<td>应用编号</td>
								<td>
									<input type="text" name="APP_ID" id="idAppId" maxlength="8" />
								</td>
								<td>应用版本</td>
								<td>
									<input type="text" name="APP_VER" id="idAppVer" maxlength="30" />
								</td>
							</tr>
							<tr>
								<td>参数模板编号</td>
								<td>
									<input type="text" name="PARAM_MODEL_ID" id="idParamModelId" maxlength="10" />
								</td>
								<td>更新时间</td>
								<td>
									<input type="text" name="UPDATE_DATE" id="idUpdateDate" maxlength="19" />
								</td>
								<td>应用更新标志</td>
								<td>
									<input type="text" name="APP_UPDATE_FLAG" id="idAppUpdateFlag" maxlength="2" />
								</td>
							</tr>
							<tr>
								<td>参数更新标志</td>
								<td>
									<input type="text" name="PARAM_UPDATE_FLAG" id="idParamUpdateFlag" maxlength="2" />
								</td>
								<td>主应用标志</td>
								<td>
									<input type="text" name="MASTER_APP_FLAG" id="idMasterAppFlag" maxlength="1" />
								</td>
								<td>分支机构编号</td>
								<td>
									<input type="text" name="REG_ID" id="idRegId" maxlength="8" />
								</td>
							</tr>
						
							<tr>
							<td colspan="6">
								<a href="javascript:void(0)" class="easyui-linkbutton"  icon="icon-search" onclick="queryInfo()">查找</a>
								<a class="easyui-linkbutton" iconCls="icon-redo" href="javascript:void(0);" onclick="cleardata()">重置</a>
							</td>
							</tr>
						</table>
					</form>
	     </div>
		<div region="center"  border="false">  
			<table id="idPlanAppInfo" ></table>
	    </div>
	      <div region="south" border="false" style="height: 30px;position:relative;background:url('<%=basePath%>images/indexbg.png') repeat;">  
			<div id="toolbar"></div>
	     </div>
</body>

</html>
