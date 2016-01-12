<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<jsp:directive.page import="com.landi.tms.util.GlobalConstants"/>
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
    <script type="text/javascript" src="core/taskinfo/TaskInfo-js.js"></script>
	<script type="text/javascript">
		function doNew(){
			var retValue=openDialogFrame("<%=basePath%>core/taskinfo/TaskInfo-add.jsp","","800","650");
			/*if(retValue=="true"){
				msgShow("新增","新增成功!","info");
				flashTable("idTaskInfo");
			}else if(retValue=="false"){
			   msgShow("新增","新增失败!","error");
			}*/
			$("#idTaskInfo").datagrid('load');
		}
		
		
		function doEdit(){
			var ids=updateValidate("idTaskInfo");
		    if(ids){
		    	var retValue=openDialogFrame("<%=basePath%>core/taskinfo/TaskInfo-edit.jsp",ids,"800","450");
				if(retValue=="true"){
					msgShow("修改","修改成功!","info");
					flashTable("idTaskInfo");
				}else if(retValue=="false"){
			       msgShow("修改","修改失败!","error");
			    }
		    }
			
		}
		
		function doDel(){
		 deleteNoteById("idTaskInfo","delTaskInfo.do", "");
		}
		
		function queryInfo(){
		 	clearSelect('idTaskInfo');//防止页面选定一条记录后进行查询，原来的选定还存在，导致修改时选定多条
		    var date=new Date();
			var param="flag="+date.getTime()+"&PLAN_CODE="+escape(escape($.trim($('#idPlanCode').val())))
			+"&APOS_ID="+escape(escape($.trim($('#idAposId').val())))
			+"&DEV_ID="+escape(escape($.trim($('#idDevId').val())))
			+"&TASK_STATUS="+escape(escape($.trim($('#idTaskStatus').val())))
			+"&MERCH_ID="+escape(escape($.trim($('#idMerchId').val())))
			+"&TERMINAL_ID="+escape(escape($.trim($('#idTerminalId').val())));			   
			$('#idTaskInfo').datagrid('options').url = "listTaskInfo.do?"+param;// 改变它的url  
			$("#idTaskInfo").datagrid('load');
		}
		function cleardata(){
			$('#queryForm').form('clear');
		}
		
		setModuleNameAndIdFromTab('queryForm');
		
	</script>
</head>

<body class="easyui-layout" fit="true">
	    <div region="north" style="height: 75px;position:relative;" title=""  split="true">  
			<form id="queryForm">
				<table class="formTable" style="width:95%;">
				<col  width="14%" class="leftCol"/>
				<col width="22%" >
				<col  width="14%" class="leftCol"/>
				<col width="18%" >
				<col  width="14%" class="leftCol"/>
				<col width="18%" >
							<tr>
								<td>计划编号</td>
								<td>
									<input type="text" name="PLAN_CODE" id="idPlanCode" maxlength="8" />
								</td>
								<td>应用终端号</td>
								<td>
									<input type="text" name="APOS_ID" id="idAposId" maxlength="10" />
								</td>
								<td>任务状态</td>
								<td>
						          <select name="TASK_STATUS" id="idTaskStatus" style="width:120" >
						        	    <option value=" ">全部</option> 
				                        <option value="<%=GlobalConstants.PLAN_UN_COMPLETE %>">未完成</option>		        	    
						                <option value="<%=GlobalConstants.PLAN_COMPLETE %>">已完成</option>
						                <option value="<%=GlobalConstants.PLAN_MASTERMERCH_UNCOMPLETE %>">主商户未配置</option>
						          </select>									
								</td>
							</tr>
							<tr>
								<td>主应用商户</td>
								<td>
									<input type="text" name="MERCH_ID" id="idMerchId" maxlength="15" class="readonly" size="15" />
									<input  type="button" class="btn_grid" value="选择" onclick="selectMerch('idMerchId');"/>
									<input id="idClear" type="button" class="btn_grid" value="清空" onclick="clearMerch('idMerchId')"/>
								</td>
								<td>主应用终端号</td>
								<td>
									<input type="text" name="TERMINAL_ID" id="idTerminalId" maxlength="8" />
								</td>
							<td></td>
							<td>
							     <input id="idQuery" type="button" class="btn_grid" value=" 查 询 " onclick="queryInfo()"/>
							     <input id="idReset" type="button" class="btn_grid" value=" 重 置 " onclick="cleardata()"/>
							</td>
							</tr>
					<!-- 		<tr>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							
							<td>&nbsp;</td>
							<td>
							<input id="idGenPosp" type="button" class="btn_grid" value=" 生 成 通 知 " onclick="genNotice()"/>
							</td>	
							</tr> -->
						</table>
					</form>
	     </div>
		<div region="center"  >  
			<table id="idTaskInfo" ></table>
				<div id="checkDialog" class="easyui-dialog" title="任务审核" 
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
