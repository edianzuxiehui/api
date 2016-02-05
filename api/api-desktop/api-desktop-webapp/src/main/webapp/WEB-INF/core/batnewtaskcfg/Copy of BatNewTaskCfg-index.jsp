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
    <script type="text/javascript" src="core/batnewtaskcfg/BatNewTaskCfg-js.js"></script>
	<script type="text/javascript">
		function doNew(){
			var retValue=openDialogFrame("<%=basePath%>core/batnewtaskcfg/BatNewTaskCfg-add.jsp","","700","400");
			if(retValue=="true"){
				msgShow("新增","新增成功!","info");
				flashTable("idBatNewTaskCfg");
			}else if(retValue=="false"){
			   msgShow("新增","新增失败!","error");
			}
		}
		
		
		function doEdit(){
			var ids=updateValidate("idBatNewTaskCfg");
		    if(ids){
		    	var retValue=openDialogFrame("<%=basePath%>core/batnewtaskcfg/BatNewTaskCfg-edit.jsp",ids,"700","400");
				if(retValue=="true"){
					msgShow("修改","修改成功!","info");
					flashTable("idBatNewTaskCfg");
				}else if(retValue=="false"){
			       msgShow("修改","修改失败!","error");
			    }
		    }
			
		}
		
		function doDel(){
		 deleteNoteById("idBatNewTaskCfg","delBatNewTaskCfg.do", "");
		}
		
		function queryInfo(){
		 	   clearSelect('idBatNewTaskCfg');//防止页面选定一条记录后进行查询，原来的选定还存在，导致修改时选定多条
		       var date=new Date();
			   var param="flag="+date.getTime()+"&QUERY_REG_ID="+escape(escape($.trim($('#idQueryRegId').val())))
					+"&REG_ID="+escape(escape($.trim($('#idRegId').val())))
					+"&REG_ENTIRE_ID="+escape(escape($.trim($('#idRegEntireId').val())))
					+"&RUN_STATUS="+escape(escape($.trim($('#idRunStatus').val())))
					+"&CHECK_STATUS="+escape(escape($.trim($('#idCheckStatus').val())))
					//+"&PLAN_CODE="+escape(escape($.trim($('#idPlanCode').val())))
					//+"&APP_ID="+escape(escape($.trim($('#idAppId').val())))
					//+"&QUERY_APP_VER="+escape(escape($.trim($('#idQueryAppVer').val())))
					+"&QUERY_FID="+escape(escape($.trim($('#idFidSelect').val())))
					+"&QUERY_MID="+escape(escape($.trim($('#idMidSelect').val())));			   
			   $('#idBatNewTaskCfg').datagrid('options').url = "listBatNewTaskCfg.do?"+param;// 改变它的url  
			   $("#idBatNewTaskCfg").datagrid('load');
		}
		function cleardata(){
			$('#queryForm').form('clear');
		}
	</script>
</head>

<body class="easyui-layout" fit="true">
	    <div region="north" style="height:75px;position:relative;" title=""  split="true">  
			<form id="queryForm">
				<table class="formTable" style="width:95%;">
				<col  width="12%" class="leftCol"/>
				<col width="23%" >
				<col  width="10%" class="leftCol"/>
				<col width="10%" >
				<col  width="12%" class="leftCol"/>
				<col width="13%" >
				<col  width="10%" class="leftCol"/>
				<col width="10%" >
							<tr>
								<td>分支机构</td>
								<td>
									<input type="hidden" class="easyui-validatebox" name="REG_ID" id="idRegId" maxlength="8" />
									<input type="hidden" name="REG_ENTIRE_ID" id="idRegEntireId"/>
									<input type="text" class="easyui-validatebox" style="background-color: #EEEEEE" readonly name="REG_NAME" id="idRegName" size="15" />
									<input id="idChoose" type="button" class="btn_grid" value="选择" onclick="queryReg('idRegId','idRegName','idRegEntireId');"/>
									<input id="idClear" type="button" class="btn_grid" value="清空" onclick="clearReg('idRegId','idRegName','idRegEntireId');"/>
								</td>
								<td>执行状态</td>
								<td>
				                  <select name="RUN_STATUS" id="idRunStatus" style="width:135">
				     				  <option value="" selected>全部</option>
				     				  <option value="0">未执行</option>
							          <option value="1">已执行</option>
				                  </select>
								</td>
								<td>查询厂商</td>
								<td>
									<select  name="QUERY_FID" id="idFidSelect" maxlength="15" style="width:100%" onchange="changeModelByFID(this.value);">
									   <option value="">请选择终端厂商</option>
									</select>
								</td>
								<td></td><td></td>
			<!-- 				<td>应用</td>
								<td>
									<input type="text" name="APP_ID" id="idAppId" maxlength="8" />
								</td>
								<td>应用版本</td>
								<td>
									<input type="text" name="QUERY_APP_VER" id="idQueryAppVer" maxlength="30" />
								</td> -->
							</tr>
							<tr>
								<td>查询分支机构</td>
								<td>
									<input type="hidden" class="easyui-validatebox" name="QUERY_REG_ID" id="idQueryRegId" maxlength="8" />
									<input type="text" class="easyui-validatebox" style="background-color: #EEEEEE" readonly name="Query_REG_NAME" id="idQueryRegName" size="15" />
									<input id="idChoose" type="button" class="btn_grid" value="选择" onclick="queryReg('idQueryRegId','idQueryRegName');"/>
									<input id="idClear" type="button" class="btn_grid" value="清空" onclick="clearReg('idQueryRegId','idQueryRegName');"/>
								</td>
								<td>审核状态</td><!-- (1同意 0否决 2未审核)  -->
								<td>
				                  <select name="CHECK_STATUS" id="idCheckStatus" style="width:135">
				                 	  <option value="" selected>全部</option>
				     				  <option value="0">否决</option>
							          <option value="1">同意</option>
							          <option value="2">未审核</option>
				                  </select>
								</td>
								<td>查询主机型号</td>
								<td>
									<select type="text" class="easyui-validatebox" name="QUERY_MID" id="idMidSelect" maxlength="20" style="width:100%">
									 <option value="">请选择主机型号</option>
									</select>
								</td>
							<td colspan="2">
							     <input id="idQuery" type="button" class="btn_grid" value=" 查 询 " onclick="queryInfo()"/>
							     <input id="idReset" type="button" class="btn_grid" value=" 重 置 " onclick="cleardata()"/>
							</td>
							</tr>
						</table>
					</form>
	     </div>
		<div region="center"  >  
			<table id="idBatNewTaskCfg" ></table>
				<div id="checkDialog" class="easyui-dialog" title="终端任务定制审核" 
				style="padding:5px;width:400px;height:200px;"
				>
					<p>是否同意审核？</p>
				</div>
	    </div>
	      <div region="south" style="height: 30px;position:relative;background:url('<%=basePath%>images/indexbg.png') repeat;">  
			<div id="toolbar"></div>
	     </div>
</body>

</html>
