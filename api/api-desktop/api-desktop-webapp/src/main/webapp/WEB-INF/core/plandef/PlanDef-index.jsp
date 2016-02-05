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
    <script type="text/javascript" src="core/plandef/PlanDef-js.js"></script>
	<script type="text/javascript">
		$(document).ready(function(){
			$(".import_toolbar").attr('disabled', true);
			$(".export_toolbar").attr('disabled', true);
	
	});
	
		function doNew(){
			var retValue=openDialogFrame("<%=basePath%>core/plandef/PlanDef-add.jsp","","780","600");
			if(retValue=="true"){
				//msgShow("新增","新增成功!","info");
				
			}else if(retValue=="false"){
			   msgShow("新增","新增失败!","error");
			}
			flashTable("idPlanDef");
			
		}
		
		
		function doEdit(){
			var ids=updateValidate("idPlanDef");
		    if(ids){
		      // alert(checkmodright(ids));
		       if(checkmodright(ids)){
		    	var retValue=openDialogFrame("<%=basePath%>core/plandef/PlanDef-edit.jsp",ids,"780","600");
				if(retValue=="true"){
					//msgShow("修改","修改成功!","info");
					//flashTable("idPlanDef");
				}else if(retValue=="false"){
			       msgShow("修改","修改失败!","error");
			       //flashTable("idPlanDef");
			      } 
			    flashTable("idPlanDef");
		     }
		     else {
		        msgShow("修改","计划已分配任务，不能进行修改!","error");
		      }
			}
		}
		
		function doDel(){
		 deleteNoteById("idPlanDef","delPlanDef.do", "");
		}
		
		function queryInfo(){
		       var date=new Date();
		       $('#idPlanDef').datagrid("clearSelections");
			var param="flag="+date.getTime()+"&PLANCODE="+escape(escape($.trim($('#idPlanCode').val())))+"&PLAN_NAME="+escape(escape($.trim($('#idPlanName').val())))+"&CREATE_DATE="+escape(escape($.trim($('#idCreateDate').val())))+"&PLAN_STATUS="+escape(escape($.trim($('#idPlanStatus').val())))+"&PLAN_TYPE="+escape(escape($.trim($('#idPlanType').val())))+"&VALID_DATE="+escape(escape($.trim($('#idValidDate').val())))+"&REG_ID="+escape(escape($.trim($('#idRegId').val())))+"&DESC_TXT="+escape(escape($.trim($('#idDescTxt').val())));			  
			 $('#idPlanDef').datagrid('options').url = "listPlanDef.do?"+param;// 改变它的url  
			   $("#idPlanDef").datagrid('load');
		}
		function cleardata(){
			$('#queryForm').form('clear');
		}
	</script>
</head>

<body class="easyui-layout" fit="true">
	    <div region="north" style="height: 80px;position:relative;" title=""  split="true">  
					<form id="queryForm">
						<table class="formTable" style="width:95%;">
				<col  width="5%" class="leftCol"/>
				<col width="15%" >

				<col  width="5%" class="leftCol"/>
				<col width="25%" >

				<col  width="5%" class="leftCol"/>
				<col width="15%" >


							<tr>
								<td>计划编号</td>
								<td>
									<input type="text" name="PLAN_CODE" id="idPlanCode" maxlength="8" />
								</td>
								<td>计划名称</td>
								<td>
									<input type="text" name="PLAN_NAME" id="idPlanName" maxlength="40" />
								</td>
								<td></td>
								<td></td>
								</tr>
								<tr>
								<td>计划状态:</td>
								
								<td>
								<select name="PLAN_STATUS" id="idPlanStatus" style="width:150px">
								<option value="" selected>请选择</option>
								<option value="1">已配置</option>
								<option value="0">未配置</option>
								</select>
								</td>
								<td>分支机构</td>
								<td>
									<input type="hidden" class="easyui-validatebox"    name="REG_ID" id="idRegId" maxlength="8" />
									<input type="text" class="easyui-validatebox" style="background-color: #EEEEEE"  name="REG_NAME" id="idRegName" readonly="readonly" />
									<input id="idChoose" type="button" class="btn_grid" value="选择" onclick="queryReg('idRegId','idRegName')"/>
									<input id="idClear" type="button" class="btn_grid" value="清空" onclick="clearReg('idRegId','idRegName')"/>
								</td>
								
								<td></td>		
								<td>
									<div style="align:left">
										<input id="idQuery" type="button" class="btn_grid" value=" 查 询 " onclick="queryInfo()"/>
								    	<input id="idReset" type="button" class="btn_grid" value=" 重 置 " onclick="cleardata()"/>
								     </div>
								</td>

							</tr>
							<!-- 
							<tr>
								<td>计划状态(已分配应用，未分配应用)</td>
								<td>
									<input type="text" name="PLAN_STATUS" id="idPlanStatus" maxlength="1" />
								</td>
								<td>计划类型</td>
								<td>
									<input type="text" name="PLAN_TYPE" id="idPlanType" maxlength="1" />
								</td>
								<td>有效时间</td>
								<td>
									<input type="text" name="VALID_DATE" id="idValidDate" maxlength="19" />
								</td>
							</tr>
							<tr>
								<td>分支机构编号</td>
								<td>
									<input type="text" name="REG_ID" id="idRegId" maxlength="8" />
								</td>
								<td>备注</td>
								<td>
									<input type="text" name="DESC_TXT" id="idDescTxt" maxlength="100" />
								</td>
							</tr>
						 
							<tr>
							<td colspan="6">
								<a href="javascript:void(0)" class="easyui-linkbutton"  icon="icon-search" onclick="queryInfo()">查找</a>
								<a class="easyui-linkbutton" iconCls="icon-redo" href="javascript:void(0);" onclick="cleardata()">重置</a>
							</td>
							</tr>
							-->
						</table>
					</form>
	     </div>
		<div region="center"  border="false">  
			<table id="idPlanDef" ></table>
	    </div>
	      <div region="south" border="false" style="height: 30px;position:relative;background:url('<%=basePath%>images/indexbg.png') repeat;">  
			<div id="toolbar"></div>
	     </div>
</body>

</html>
